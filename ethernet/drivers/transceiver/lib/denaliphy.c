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
    @defgroup grp_eth_xcvrdrv_denaliphy_impl Denali Phy Driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_denaliphy_impl
    @{

    @file denaliphy.c
    @brief This file implements Denali phy driver of Ethernet driver.

    @version 0.1 initial version
*/

#include <bcm_err.h>
#include <bcm_utils.h>
#include <ethxcvr.h>
#include <mdio.h>
#include "denaliphy_osil.h"

/**
    @name DENALIPHY driver Design IDs
    @{
    @brief Design IDs for DENALIPHY driver
*/
#define BRCM_SWDSGN_DENALIPHY_FUNCTBL_GLOBAL                       (0xBD01U)    /**< @brief #DENALIPHY_FuncTbl                      */
#define BRCM_SWDSGN_DENALIPHY_JOBSTATE_TYPE                        (0xBD02U)    /**< @brief #DENALIPHY_JobStateType                 */
#define BRCM_SWDSGN_DENALIPHY_JOB_TYPE                             (0xBD03U)    /**< @brief #DENALIPHY_JobType                      */
#define BRCM_SWDSGN_DENALIPHY_CNTXT_DATA_TYPE                      (0xBD04U)    /**< @brief #DENALIPHY_CNTXT_DATAType               */
#define BRCM_SWDSGN_DENALIPHY_TC10STATUS_TYPE                      (0xBD05U)    /**< @brief #DENALIPHY_Tc10StatusType               */
#define BRCM_SWDSGN_DENALIPHY_TC10SLEEPREQUEST_MACRO               (0xBD06U)    /**< @brief #DENALIPHY_TC10SLEEPREQUEST             */
#define BRCM_SWDSGN_DENALIPHY_TC10WAKEUPREQUEST_MACRO              (0xBD07U)    /**< @brief #DENALIPHY_TC10WAKEUPREQUEST            */
#define BRCM_SWDSGN_DENALIPHY_TC10WAKEUPMASK_MACRO                 (0xBD08U)    /**< @brief #DENALIPHY_TC10WAKEUPMASK               */
#define BRCM_SWDSGN_DENALIPHY_REPORTERROR_PROC                     (0xBD09U)    /**< @brief #DENALIPHY_ReportError                  */
#define BRCM_SWDSGN_DENALIPHY_CHECKMDIOJOBQFREELEN_PROC            (0xBD0AU)    /**< @brief #DENALIPHY_CheckMDIOJobQFreeLen         */
#define BRCM_SWDSGN_DENALIPHY_INITSTATEHANDLER_PROC                (0xBD0BU)    /**< @brief #DENALIPHY_InitStateHandler             */
#define BRCM_SWDSGN_DENALIPHY_DEINITSTATEHANDLER_PROC              (0xBD0CU)    /**< @brief #DENALIPHY_DeInitStateHandler           */
#define BRCM_SWDSGN_DENALIPHY_RESET0STATEHANDLER_PROC              (0xBD0DU)    /**< @brief #DENALIPHY_Reset0StateHandler           */
#define BRCM_SWDSGN_DENALIPHY_RESET1STATEHANDLER_PROC              (0xBD0EU)    /**< @brief #DENALIPHY_Reset1StateHandler           */
#define BRCM_SWDSGN_DENALIPHY_RESETSTATEHANDLER_PROC               (0xBD0FU)    /**< @brief #DENALIPHY_ResetStateHandler            */
#define BRCM_SWDSGN_DENALIPHY_GETLINKSTATE0STATEHANDLER_PROC       (0xBD10U)    /**< @brief #DENALIPHY_GetLinkState0StateHandler    */
#define BRCM_SWDSGN_DENALIPHY_GETLINKSTATE1STATEHANDLER_PROC       (0xBD11U)    /**< @brief #DENALIPHY_GetLinkState1StateHandler    */
#define BRCM_SWDSGN_DENALIPHY_GETLINKSTATEHANDLER_PROC             (0xBD12U)    /**< @brief #DENALIPHY_GetLinkStateHandler          */
#define BRCM_SWDSGN_DENALIPHY_SETMODESTATEHANDLER_PROC             (0xBD13U)    /**< @brief #DENALIPHY_SetModeStateHandler          */
#define BRCM_SWDSGN_DENALIPHY_SETMASTERMODE0STATEHANDLER_PROC      (0xBD14U)    /**< @brief #DENALIPHY_SetMasterMode0StateHandler   */
#define BRCM_SWDSGN_DENALIPHY_SETMASTERMODE1STATEHANDLER_PROC      (0xBD15U)    /**< @brief #DENALIPHY_SetMasterMode1StateHandler   */
#define BRCM_SWDSGN_DENALIPHY_SETMASTERMODE2STATEHANDLER_PROC      (0xBD16U)    /**< @brief #DENALIPHY_SetMasterMode2StateHandler   */
#define BRCM_SWDSGN_DENALIPHY_SETMASTERMODESTATEHANDLER_PROC       (0xBD17U)    /**< @brief #DENALIPHY_SetMasterModeStateHandler    */
#define BRCM_SWDSGN_DENALIPHY_SETSPEEDSTATEHANDLER_PROC            (0xBD18U)    /**< @brief #DENALIPHY_SetSpeedStateHandler         */
#define BRCM_SWDSGN_DENALIPHY_SETLOOPBACKMODE0STATEHANDLER_PROC    (0xBD19U)    /**< @brief #DENALIPHY_SetLoopbackMode0StateHandler */
#define BRCM_SWDSGN_DENALIPHY_SETLOOPBACKMODE1STATEHANDLER_PROC    (0xBD1AU)    /**< @brief #DENALIPHY_SetLoopbackMode1StateHandler */
#define BRCM_SWDSGN_DENALIPHY_SETLOOPBACKMODE2STATEHANDLER_PROC    (0xBD1BU)    /**< @brief #DENALIPHY_SetLoopbackMode2StateHandler */
#define BRCM_SWDSGN_DENALIPHY_SETLOOPBACKMODESTATEHANDLER_PROC     (0xBD1CU)    /**< @brief #DENALIPHY_SetLoopbackModeStateHandler  */
#define BRCM_SWDSGN_DENALIPHY_SETJUMBOMODESTATEHANDLER_PROC        (0xBD1DU)    /**< @brief #DENALIPHY_SetJumboModeStateHandler     */
#define BRCM_SWDSGN_DENALIPHY_SETAUTONEGMODESTATEHANDLER_PROC      (0xBD1EU)    /**< @brief #DENALIPHY_SetAutoNegModeStateHandler   */
#define BRCM_SWDSGN_DENALIPHY_RESTARTAUTONEGSTATEHANDLER_PROC      (0xBD1FU)    /**< @brief #DENALIPHY_RestartAutoNegStateHandler   */
#define BRCM_SWDSGN_DENALIPHY_GETAUTONEGSTATUSSTATEHANDLER_PROC    (0xBD20U)    /**< @brief #DENALIPHY_GetAutoNegStatusStateHandler */
#define BRCM_SWDSGN_DENALIPHY_UPDATEHWSTATUSSTATEHANDLER_PROC      (0xBD21U)    /**< @brief #DENALIPHY_UpdateHWStatusStateHandler   */
#define BRCM_SWDSGN_DENALIPHY_INTSTATEHANDLER_PROC                 (0xBD22U)    /**< @brief #DENALIPHY_IntStateHandler              */
#define BRCM_SWDSGN_DENALIPHY_QUEUEJOB_PROC                        (0xBD23U)    /**< @brief #DENALIPHY_QueueJob                     */
#define BRCM_SWDSGN_DENALIPHY_GETLINKSTATE_PROC                    (0xBD24U)    /**< @brief #DENALIPHY_GetLinkState                 */
#define BRCM_SWDSGN_DENALIPHY_RESET_PROC                           (0xBD25U)    /**< @brief #DENALIPHY_Reset                        */
#define BRCM_SWDSGN_DENALIPHY_SETMODE_PROC                         (0xBD26U)    /**< @brief #DENALIPHY_SetMode                      */
#define BRCM_SWDSGN_DENALIPHY_GETMODE_PROC                         (0xBD27U)    /**< @brief #DENALIPHY_GetMode                      */
#define BRCM_SWDSGN_DENALIPHY_SETMASTERMODE_PROC                   (0xBD28U)    /**< @brief #DENALIPHY_SetMasterMode                */
#define BRCM_SWDSGN_DENALIPHY_GETMASTERMODE_PROC                   (0xBD29U)    /**< @brief #DENALIPHY_GetMasterMode                */
#define BRCM_SWDSGN_DENALIPHY_SETSPEED_PROC                        (0xBD2AU)    /**< @brief #DENALIPHY_SetSpeed                     */
#define BRCM_SWDSGN_DENALIPHY_GETSPEED_PROC                        (0xBD2BU)    /**< @brief #DENALIPHY_GetSpeed                     */
#define BRCM_SWDSGN_DENALIPHY_GETDUPLEXMODE_PROC                   (0xBD2CU)    /**< @brief #DENALIPHY_GetDuplexMode                */
#define BRCM_SWDSGN_DENALIPHY_SETDUPLEXMODE_PROC                   (0xBD2DU)    /**< @brief #DENALIPHY_SetDuplexMode                */
#define BRCM_SWDSGN_DENALIPHY_SETFLOWCONTROL_PROC                  (0xBD2EU)    /**< @brief #DENALIPHY_SetFlowControl               */
#define BRCM_SWDSGN_DENALIPHY_GETFLOWCONTROL_PROC                  (0xBD2FU)    /**< @brief #DENALIPHY_GetFlowControl               */
#define BRCM_SWDSGN_DENALIPHY_GETSQIVALUE_PROC                     (0xBD30U)    /**< @brief #DENALIPHY_GetSQIValue                  */
#define BRCM_SWDSGN_DENALIPHY_INIT_PROC                            (0xBD31U)    /**< @brief #DENALIPHY_Init                         */
#define BRCM_SWDSGN_DENALIPHY_DEINIT_PROC                          (0xBD32U)    /**< @brief #DENALIPHY_DeInit                       */
#define BRCM_SWDSGN_DENALIPHY_SETLOOPBACKMODE_PROC                 (0xBD33U)    /**< @brief #DENALIPHY_SetLoopbackMode              */
#define BRCM_SWDSGN_DENALIPHY_GETLOOPBACKMODE_PROC                 (0xBD34U)    /**< @brief #DENALIPHY_GetLoopbackMode              */
#define BRCM_SWDSGN_DENALIPHY_SETJUMBOMODE_PROC                    (0xBD35U)    /**< @brief #DENALIPHY_SetJumboMode                 */
#define BRCM_SWDSGN_DENALIPHY_GETJUMBOMODE_PROC                    (0xBD36U)    /**< @brief #DENALIPHY_GetJumboMode                 */
#define BRCM_SWDSGN_DENALIPHY_SETWAKEUPMODE_PROC                   (0xBD37U)    /**< @brief #DENALIPHY_SetWakeUpMode                */
#define BRCM_SWDSGN_DENALIPHY_GETWAKEUPMODE_PROC                   (0xBD38U)    /**< @brief #DENALIPHY_GetWakeUpMode                */
#define BRCM_SWDSGN_DENALIPHY_GETWAKEUPREASON_PROC                 (0xBD39U)    /**< @brief #DENALIPHY_GetWakeUpReason              */
#define BRCM_SWDSGN_DENALIPHY_SETAUTONEGMODE_PROC                  (0xBD3AU)    /**< @brief #DENALIPHY_SetAutoNegMode               */
#define BRCM_SWDSGN_DENALIPHY_RESTARTAUTONEG_PROC                  (0xBD3BU)    /**< @brief #DENALIPHY_RestartAutoNeg               */
#define BRCM_SWDSGN_DENALIPHY_GETAUTONEGSTATUS_PROC                (0xBD3CU)    /**< @brief #DENALIPHY_GetAutoNegStatus             */
#define BRCM_SWDSGN_DENALIPHY_GETSTATS_PROC                        (0xBD3DU)    /**< @brief #DENALIPHY_GetStats                     */
#define BRCM_SWDSGN_DENALIPHY_STATEHANDLER_PROC                    (0xBD3EU)    /**< @brief #DENALIPHY_StateHandler                 */
#define BRCM_SWDSGN_DENALIPHY_UPDATEHWSTATUS_PROC                  (0xBD3FU)    /**< @brief #DENALIPHY_UpdateHWStatus               */
#define BRCM_SWDSGN_DENALIPHY_LINKIRQHANDLER_PROC                  (0xBD40U)    /**< @brief #DENALIPHY_LinkIRQHandler               */
#define BRCM_SWDSGN_DENALIPHY_LINKCHANGEINDHANDLER_PROC            (0xBD41U)    /**< @brief #DENALIPHY_LinkChangeIndHandler         */
/** @} */

/**
  @{
  @brief DENALIPHY job state
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
typedef uint32_t DENALIPHY_JobStateType;
#define DENALIPHY_JOBSTATE_NONE           (0UL)   /**< @brief Job state None */
#define DENALIPHY_JOBSTATE_0              (1UL)   /**< @brief Job state 0 */
#define DENALIPHY_JOBSTATE_1              (2UL)   /**< @brief Job state 1 */
#define DENALIPHY_JOBSTATE_2              (3UL)   /**< @brief Job state 2 */
#define DENALIPHY_JOBSTATE_3              (4UL)   /**< @brief Job state 3 */
#define DENALIPHY_JOBSTATE_4              (5UL)   /**< @brief Job state 4 */
#define DENALIPHY_JOBSTATE_5              (6UL)   /**< @brief Job state 5 */
#define DENALIPHY_JOBSTATE_6              (7UL)   /**< @brief Job state 6 */
#define DENALIPHY_JOBSTATE_7              (8UL)   /**< @brief Job state 7 */
#define DENALIPHY_JOBSTATE_8              (9UL)   /**< @brief Job state 8 */
#define DENALIPHY_JOBSTATE_9              (10UL)  /**< @brief Job state 9 */
#define DENALIPHY_JOBSTATE_10             (11UL)  /**< @brief Job state 10 */
#define DENALIPHY_JOBSTATE_11             (12UL)  /**< @brief Job state 11 */
#define DENALIPHY_JOBSTATE_12             (13UL)  /**< @brief Job state 12 */
#define DENALIPHY_JOBSTATE_13             (14UL)  /**< @brief Job state 13 */
#define DENALIPHY_JOBSTATE_14             (15UL)  /**< @brief Job state 14 */
#define DENALIPHY_JOBSTATE_15             (16UL)  /**< @brief Job state 15 */
#define DENALIPHY_JOBSTATE_16             (17UL)  /**< @brief Job state 16 */
#define DENALIPHY_JOBSTATE_MAX            (DENALIPHY_JOBSTATE_16)  /**< @brief Maximum job state */
/** @} */

/**
  @{
  @brief DENALIPHY job type
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
typedef uint32_t DENALIPHY_JobType;
#define DENALIPHY_JOB_NONE              (0UL)   /**< @brief No job */
#define DENALIPHY_JOB_INIT              (1UL)   /**< @brief Init job */
#define DENALIPHY_JOB_DEINIT            (2UL)   /**< @brief Deinit job */
#define DENALIPHY_JOB_RESET             (3UL)   /**< @brief Reset job */
#define DENALIPHY_JOB_GETLINKSTATE      (4UL)   /**< @brief Get link state job */
#define DENALIPHY_JOB_SETMODE           (5UL)   /**< @brief Set mode job */
#define DENALIPHY_JOB_SETMASTERMODE     (6UL)   /**< @brief Set master mode job */
#define DENALIPHY_JOB_SETSPEED          (7UL)   /**< @brief Set speed job */
#define DENALIPHY_JOB_SETLOOPBACKMODE   (8UL)  /**< @brief Set loopback mode job */
#define DENALIPHY_JOB_SETJUMBOMODE      (9UL)  /**< @brief Set jumbo mode job */
#define DENALIPHY_JOB_SETAUTONEGMODE    (10UL)  /**< @brief Set auto-neg mode job */
#define DENALIPHY_JOB_RESTARTAUTONEG    (11UL)  /**< @brief Restart auto-neg job */
#define DENALIPHY_JOB_GETAUTONEGSTATUS  (12UL)  /**< @brief Get auto-neg status job */
#define DENALIPHY_JOB_UPDATEHWSTATUS    (13UL)  /**< @brief Update hardware status job */
#define DENALIPHY_JOB_MAX               (DENALIPHY_JOB_UPDATEHWSTATUS)  /**< @brief Maximum job identifier */
/** @} */

/**
  @{
  @brief DENALIPHY context data array offset type
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
typedef uint32_t DENALIPHY_CNTXT_DATAType;
#define DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET         (0UL)   /**< @brief #DENALIPHY_JobType */
#define DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET        (1UL)   /**< @brief #DENALIPHY_JobStateType */
#define DENALIPHY_CNTXT_DATA_REGVAL_OFFSET          (2UL)   /**< @brief Value of register read through MDIO */
#define DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET         (3UL)   /**< @brief Job ID obtained from MDIO driver after submitting a read/write request */
#define DENALIPHY_CNTXT_DATA_ARG1_OFFSET            (4UL)   /**< @brief Argument associated with #DENALIPHY_JobType job */
/** @} */

/**
  @{
  @brief DENALIPHY Tc10 Status type
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
typedef uint16_t DENALIPHY_Tc10StatusType;                  /**< @brief #DENALIPHY_Tc10StatusType */
#define DENALIPHY_TC10STATUS_STANDBYSTATE_MASK    (0x600U)  /**< @brief StandBy State Mask*/
#define DENALIPHY_TC10STATUS_STANDBYSTATE_SHIFT   (0x8U)    /**< @brief StandBy State Shift*/
#define DENALIPHY_TC10STATUS_LOCWAKEUPSTAT_MASK   (0x40U)   /**< @brief LocWakeUpStatus Mask*/
#define DENALIPHY_TC10STATUS_LOCWAKEUPSTAT_SHIFT  (0x6U)    /**< @brief LocWakeUpStatus Shift*/
#define DENALIPHY_TC10STATUS_WAKEUPSTAT_MASK      (0x20U)   /**< @brief WakeUp Status Mask*/
#define DENALIPHY_TC10STATUS_WAKEUPSTAT_SHIFT     (0x5U)    /**< @brief WakeUp Status Shift*/
#define DENALIPHY_TC10STATUS_SLEEPSTAT_MASK       (0x4U)    /**< @brief Sleep Status Mask*/
#define DENALIPHY_TC10STATUS_SLEEPSTAT_SHIFT      (0x2U)    /**< @brief Sleep Status Shift*/
#define DENALIPHY_TC10STATUS_SLEEPFAILSTAT_MASK   (0x2U)    /**< @brief Sleep Fail Status Mask*/
#define DENALIPHY_TC10STATUS_SLEEPFAILSTAT_SHIFT  (0x1U)    /**< @brief Sleep Fail Status Shift*/
#define DENALIPHY_TC10STATUS_MDI_WAKEUPSTAT_MASK  (0x1U)    /**< @brief Energy on the MDI Signal Mask  */
#define DENALIPHY_TC10STATUS_MDI_WAKEUPSTAT_SHIFT (0x0U)    /**< @brief Energy on the MDI Signal  Shift*/
/** @} */

/**
  @{
  @brief DENALIPHY Tc10 wakeup
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
#define DENALIPHY_TC10WAKEUPMASK    (DENALIPHY_TC10STATUS_LOCWAKEUPSTAT_MASK \
                                     | DENALIPHY_TC10STATUS_WAKEUPSTAT_MASK  \
                                     | DENALIPHY_TC10STATUS_MDI_WAKEUPSTAT_MASK)
/** @} */

/**
    @{
    @brief DENALIPHY Tc10 Sleep Request

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
#define     DENALIPHY_TC10SLEEPREQUEST          (0x4003UL)  /**< @brief #DENALIPHY_TC10SLEEPREQUEST */
/** @} */

/**
    @{
    @brief DENALIPHY Tc10 WakeUp Request

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
 */
#define     DENALIPHY_TC10WAKEUPREQUEST          (0x4009UL)  /**< @brief #DENALIPHY_TC10WAKEUPREQUEST */
/** @} */

/** @brief Report error information to DET/DEM

    @code{.c}
    BCM_ReportError(BCM_XVR_ID, aInstanceID, aApiID, aErr, 4UL, values);
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static void DENALIPHY_ReportError(uint8_t aInstanceID, uint16_t aApiID,
        int32_t aErr, uint32_t aVal0, uint32_t aVal1,
        uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_XVR_ID, aInstanceID, aApiID, aErr, 4UL, values);
}

/**
    @brief Check MDIO Job-Q Free Length

    @code{.c}
    freeLen = MDIO_GetJobQFreeLen(aID)
    if (aReqLen > freeLen)
        return BCM_ERR_NOMEM
    else
        return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_CheckMDIOJobQFreeLen(ETHER_MDIOHwIDType aID,
                                    uint32_t aReqLen)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t freeLen = MDIO_GetJobQFreeLen(aID);
    if (aReqLen > freeLen) {
        retVal = BCM_ERR_NOMEM;
    }
    return retVal;
}

/**
    @brief Init State Handler

    @code{.c}
    aPhyCntxt->drvState = ETHXCVR_STATE_INIT
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] =
                                            DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] =
                                            DENALIPHY_JOB_NONE
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static void DENALIPHY_InitStateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{

    aPhyCntxt->drvState = ETHXCVR_STATE_INIT;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] =
                                            DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] =
                                            DENALIPHY_JOB_NONE;
}

/**
    @brief Deinit State Handler

    @code{.c}
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] =
                                            DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->drvState = ETHXCVR_STATE_UNINIT
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] =
                                            DENALIPHY_JOB_NONE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_DeInitStateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] =
                                            DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->drvState = ETHXCVR_STATE_UNINIT;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] =
                                            DENALIPHY_JOB_NONE;

    return BCM_ERR_OK;
}

/**
    @brief Reset State-0 Handler

    @code{.c}
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
    if (retVal is not BCM_ERR_OK)
        return retVal
    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x1
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0000U
    pkt.regData = (0x1U << 15U)
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (retVal is BCM_ERR_OK)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_Reset0StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;

    /* Check space in MDIO job queue */
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x1U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0000U; /* PMA_PMD_CONTROL_1 register */
    pkt.regData = (0x1U << 15U); /* Set reset bit-15. It is self-clearing */
    /* Queue MDIO requests */
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1;
    }

err:
    return retVal;
}

/**
    @brief Reset State-1 Handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (retVal is not BCM_ERR_OK)
        if (retVal is BCM_ERR_BUSY)
            retVal = BCM_ERR_EAGAIN
        return retVal
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_Reset1StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;

err:
    return retVal;
}

/**
    @brief Reset State Handler

    @code{.c}
    JobState = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]
    If JobState is DENALIPHY_JOBSTATE_0
        retVal = DENALIPHY_Reset0StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else If JobState is DENALIPHY_JOBSTATE_1
        retVal = DENALIPHY_Reset1StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else
        retVal = BCM_ERR_INVAL_STATE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_ResetStateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]) {
        case DENALIPHY_JOBSTATE_0:
            retVal = DENALIPHY_Reset0StateHandler(aPhyIdx, aPhyCntxt, aConfig);
            break;
        case DENALIPHY_JOBSTATE_1:
            retVal = DENALIPHY_Reset1StateHandler(aPhyIdx, aPhyCntxt, aConfig);
            break;
        default:
            retVal = BCM_ERR_INVAL_STATE;
            break;
    }

    return retVal;
}

/**
    @brief Get Link State-0 Handler

    @code{.c}
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL)
    if (BCM_ERR_OK != retVal)
        return retVal
    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x1
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0001
    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (BCM_ERR_OK == retVal)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetLinkState0StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;

    /* Check space in MDIO job queue */
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x1U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0001U; /* PMA_PMD_STATUS_1 register */
    /* Queue MDIO requests */
    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1;
    }
err:
    return retVal;
}

/**
    @brief Reset State-1 Handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (BCM_ERR_OK != retVal)
        if (BCM_ERR_BUSY == retVal)
            retVal = BCM_ERR_EAGAIN
        return retVal
    if ((pkt.regData & (0x1U << 2U)) == 0U)
        aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN
    else
        aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_ACTIVE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetLinkState1StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    if ((pkt.regData & (0x1U << 2U)) == 0U) {
        aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN;
    } else {
        aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_ACTIVE;
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;

err:
    return retVal;
}

/**
    @brief Get link State Handler

    @code{.c}
    JobState = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]
    If JobState is DENALIPHY_JOBSTATE_0
        retVal = DENALIPHY_GetLinkState0StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else If JobState is DENALIPHY_JOBSTATE_1
        retVal = DENALIPHY_GetLinkState1StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else
        retVal = BCM_ERR_INVAL_STATE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetLinkStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]) {
    case DENALIPHY_JOBSTATE_0:
        retVal = DENALIPHY_GetLinkState0StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOBSTATE_1:
        retVal = DENALIPHY_GetLinkState1StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

    return retVal;
}

/**
    @brief Set Mode State Handler

    @code{.c}
    if jobState is DENALIPHY_JOBSTATE_0
        Set jobId as 0xFFFFFFFFUL
    else
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]

    if (jobId is not 0xFFFFFFFFUL)
        Get the status of previous job using MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
        If MDIO_GetJobResult() return value is BCM_ERR_BUSY
            return EAGAIN
        If MDIO_GetJobResult() return value is not BCM_ERR_OK
            return err

        jobId = 0xFFFFFFFFUL
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData
    }

    if DENALIPHY_JOBSTATE_0
        pkt.deviceType = 0x1EU
        pkt.regAddr = 0xF1U
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_1
    else if DENALIPHY_JOBSTATE_1
        if( Sleep is Requested when Port is in StandBy) {
            write = FALSE
            read = FALSE
            nextState = DENALIPHY_JOBSTATE_NONE
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
            if (NULL != aMode)
                *aMode = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
        else
            pkt.deviceType = 0x1EU
            pkt.regAddr = 0xF0U
            write = FALSE
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_2
        aPhyCntxt->cacheInfo.tc10Status = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
    else if DENALIPHY_JOBSTATE_2
        if TC10 Wakeup Mode Enabled
            if ( ETHXCVR_MODE_DOWN is aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
                sleep Request ans skip other Jobs
                pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (DENALIPHY_TC10SLEEPREQUEST)
                aPhyCntxt->cacheInfo.tc10Status =0
                nextState = DENALIPHY_JOBSTATE_3
            else
                wakeup Request
                pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (DENALIPHY_TC10WAKEUPREQUEST)
                pkt.regData = pkt.regData & (~(0x1U << 1U))
                nextState = DENALIPHY_JOBSTATE_7
            pkt.deviceType = 0x1EU
            pkt.regAddr = 0xF0U
            write = TRUE
            read = FALSE
            aPhyCntxt->cacheInfo.localModeState = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
        } else {
            pkt.deviceType = 0x1U
            pkt.regAddr = 0x0000U
            write = FALSE
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_6
        }
    else if DENALIPHY_JOBSTATE_3
        pkt.deviceType = 0x1EU
        pkt.regAddr = 0xF1U
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_4
    else if DENALIPHY_JOBSTATE_4
        if(Port Sleep Fail)
            Report Error
            DENALIPHY_ReportError(aPhyIdx, BRCM_SWDSGN_DENALIPHY_SETMODESTATEHANDLER_PROC,
                                    retVal, 0UL, 0UL, 0UL,(uint32_t)__LINE__);
            pkt.deviceType = 0x1EU
            pkt.regAddr = 0xF0U
            write = FALSE
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_5
        else if ( Port is in Sleep) {
            pkt.deviceType = 0x1E
            pkt.regAddr = 0xF0U
            write = FALSE
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_5
        else
            write = FALSE
            read = FALSE
            nextState = DENALIPHY_JOBSTATE_3
    else if jobState is DENALIPHY_JOBSTATE_5
        pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1U << 1U))
        pkt.deviceType = 0x1EU
        pkt.regAddr = 0xF0U
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_16
    else if jobState is DENALIPHY_JOBSTATE_6
        if Wakeup Mode is Disabled
            if (ETHXCVR_MODE_DOWN is aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
                pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (0x1U << 11U)
            else
                pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1U << 11U))
        pkt.deviceType = 0x1
        pkt.regAddr = 0x0000
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_7
    else if jobState is DENALIPHY_JOBSTATE_7
        pkt.deviceType = 0x1U
        pkt.regAddr = 0xA011U
        pkt.regData = 0x1030U
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_8;
    else if jobState is DENALIPHY_JOBSTATE_8
        pkt.deviceType = 0x1
        pkt.regAddr = 0x0834
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_9
    else if jobState is DENALIPHY_JOBSTATE_9
        if (ETHXCVR_BOOLEAN_TRUE is aConfig->phy.masterMode)
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (0x1U << 14U)
        else
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1U << 14U))
        pkt.deviceType = 0x1
        pkt.regAddr = 0x0834
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_10
    else if jobState is DENALIPHY_JOBSTATE_10
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9306
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_11
    case DENALIPHY_JOBSTATE_11
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo)
            value = 1
        else
            value = 0
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9306
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~(0x3 << 14)) | (value << 14))
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_12
    else if jobState is DENALIPHY_JOBSTATE_12
        pkt.deviceType = 0x01
        pkt.regAddr = 0x8c01
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_13
    else if jobState is DENALIPHY_JOBSTATE_13
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo)
            value = 1
        else
            value = 0
        pkt.deviceType = 0x01
        pkt.regAddr = 0x8c01
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value)
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_14
    else if jobState is DENALIPHY_JOBSTATE_14
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9010
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_15
    else if jobState is DENALIPHY_JOBSTATE_15
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo)
            value = 1
        else
            value = 0
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9010
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value)
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_16
    else if jobState is 5ENALIPHY_JOBSTATE_16
        if (aIsModeChanged is not NULL)
            *aIsModeChanged = TRUE
        if (aMode is not NULL)
            *aMode = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
        write = FALSE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_NONE
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    else
        write = FALSE
        read = FALSE
        retVal = BCM_ERR_INVAL_STATE
        nextState = DENALIPHY_JOBSTATE_NONE

    if (read is TRUE) OR (write is TRUE)
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL)
        if (BCM_ERR_OK != retVal)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobID
            return retVal

        pkt.slaveAddr = aConfig->phy.slaveID
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
        if (write is TRUE)
            retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobId)
        if (read is TRUE)
            retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId)
        if (BCM_ERR_OK != retVal)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobID
            return retVal

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState

    if ((DENALIPHY_JOBSTATE_0 != state) AND (DENALIPHY_JOBSTATE_NONE != nextState)
        AND (BCM_ERR_OK == retVal))
        retVal = BCM_ERR_EAGAIN

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetModeStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               uint32_t *const aIsModeChanged,
                               ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;
    uint32_t state;
    uint32_t nextState;
    uint32_t write = FALSE;
    uint32_t read = FALSE;
    uint32_t value;

    state = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET];
    if (DENALIPHY_JOBSTATE_0 == state) {
        /* Reset Job ID field upon first entry */
        jobId = 0xFFFFFFFFUL;
    } else {
        /* Check if a read/write access is pending completion */
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    }

    if (0xFFFFFFFFUL != jobId) {
        /* Retrieve already issued register access result */
        retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
        if (BCM_ERR_OK != retVal) {
            if (BCM_ERR_BUSY == retVal) {
                retVal = BCM_ERR_EAGAIN;
            }
            goto err;
        }
        jobId = 0xFFFFFFFFUL;

        /* Irrespective of read/write, save pkt.data. Consumed only if a read
         * was awaiting completion.
         * Saving this value is necessary since a successive MDIO access using
         * this read value might fail(busy/retry) and the read valye would be
         * needed upon next entry(however MDIO driver would not be able to
         * recognise that job at that later point of time */
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData;
    }

    switch (state) {
    case DENALIPHY_JOBSTATE_0:
        /* Access to read  TC10_STATUS_REGISTER_1*/
        pkt.deviceType = 0x1EU;
        pkt.regAddr = 0xF1U; /* TC10_STATUS_REGISTER_1 */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_1;
        break;
    case DENALIPHY_JOBSTATE_1:
        if((DENALIPHY_TC10STATUS_STANDBYSTATE_MASK
                      == (DENALIPHY_TC10STATUS_STANDBYSTATE_MASK
                          & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]))
                      && (ETHXCVR_MODE_DOWN == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])) {
            /* If Port is alerady in StandBy and Sleep request received then skip all the jobs */
            write = FALSE;
            read = FALSE;
            nextState = DENALIPHY_JOBSTATE_NONE;
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
            if (NULL != aMode) {
                *aMode = (uint8_t)aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET];
            }
        } else {
            pkt.deviceType = 0x1EU;
            pkt.regAddr = 0xF0U; /* TC10_CONTROL_REGISTER_1 */
            write = FALSE;
            read = TRUE;
            /* If Port is in not in stand by Then Check Wakeup mode Enabled or not*/
            nextState = DENALIPHY_JOBSTATE_2;
        }
        /* TC10_STATUS_REGISTER_1 is a clear on read. Since it is read here, store the value */
        aPhyCntxt->cacheInfo.tc10Status = (uint16_t)aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET];
        break;
    case DENALIPHY_JOBSTATE_2:
        /* Check WakeUp Mode Enabled */
        if (0U == (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1UL << 15U))) {
            /* TC10 WakeUp Mode is Enabled. Checking for Sleep or wakeup Request*/
            if (ETHXCVR_MODE_DOWN == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
                /* Sleep Request */
                pkt.regData = (uint16_t)(aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (DENALIPHY_TC10SLEEPREQUEST));
                nextState = DENALIPHY_JOBSTATE_3;
                /* Clear the Previous tc10status cache to not give any wakeupreason on Sleep Mode.
                   When Port is wakeup then 'cacheInfo.tc10Status' will be updated from the TC10 Status register.
                   If user did not query the Reason this variable will not be cleared unless a new wakeup identified.
                   Now, a sleep request is received and Port is in standBy mode. Since there is no wakeup detected
                  'cacheInfo.tc10Status' will not be updated in the HWStatusStateHandler and hold the previous value.
                   So at this state user query the wakeupReason will give Local/Remote but actuval wakeup will not happen.
                   So to avoid that 'cacheInfo.tc10Status' needs to be cleard when in sleep / sleep request*/
                aPhyCntxt->cacheInfo.tc10Status =0;
            } else {
                /* Wakeup Request */
                pkt.regData = (uint16_t)(aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (DENALIPHY_TC10WAKEUPREQUEST));
                /* If TC10 Enabled and Wakeup request received then skip the Job 3 as Port Link up will be
                   done by TC10*/
                nextState = DENALIPHY_JOBSTATE_7;
            }
            pkt.deviceType = 0x1EU;
            pkt.regAddr = 0xF0U; /* TC10_CONTROL_REGISTER_1 */
            write = TRUE;
            read = FALSE;
            /* WakeUp Reason is updated with #ETHXCVR_MODE_DOWN (Sleep) or #ETHXCVR_MODE_ACTIVE(Wakeup) */
            aPhyCntxt->cacheInfo.localModeState = (uint8_t)aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET];
            /* Update the Admin Mode */
            aPhyCntxt->cacheInfo.mode = (uint8_t)aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET];
        } else {
            /* If TC10 wakeup is not enabled then proceed to Next JOB */
            /* Access to read PMA_PMD_CONTROL_1 */
            pkt.deviceType = 0x1U;
            pkt.regAddr = 0x0000U; /* PMA_PMD_CONTROL_1 register */
            write = FALSE;
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_6;
        }
        break;
    case DENALIPHY_JOBSTATE_3:
        /* Access to read  TC10_STATUS_REGISTER_1*/
        pkt.deviceType = 0x1EU;
        pkt.regAddr = 0xF1U; /* TC10_STATUS_REGISTER_1 */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_4;
        break;
    case DENALIPHY_JOBSTATE_4:
        /* Access to read  TC10_CONTROL_REGISTER_1*/
        if(0UL != (DENALIPHY_TC10STATUS_SLEEPFAILSTAT_MASK
                     & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET])) {
            /* If Port Sleep Request Fail then Report Error and Proceed to clear Sleep Request */
            DENALIPHY_ReportError(aPhyIdx, BRCM_SWDSGN_DENALIPHY_SETMODESTATEHANDLER_PROC,
                                    retVal, 0UL, 0UL, 0UL,(uint32_t)__LINE__);
            pkt.deviceType = 0x1EU;
            pkt.regAddr = 0xF0U; /* TC10_CONTROL_REGISTER_1 */
            write = FALSE;
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_5;
        } else if (0UL != ((DENALIPHY_TC10STATUS_SLEEPSTAT_MASK )
                          & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET])) {
            pkt.deviceType = 0x1EU;
            pkt.regAddr = 0xF0U; /* TC10_CONTROL_REGISTER_1 */
            write = FALSE;
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_5;
        } else {
            nextState = DENALIPHY_JOBSTATE_3;
            write = FALSE;
            read = FALSE;
        }
        break;
    case DENALIPHY_JOBSTATE_5:
        /* Clear the Sleep Request */
        pkt.regData = (uint16_t)(aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1UL << 1U)));
        /* Write the value back  TC10_CONTROL_REGISTER_1*/
        pkt.deviceType = 0x1EU;
        pkt.regAddr = 0xF0U; /* TC10_CONTROL_REGISTER_1 */
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_16;
        break;
    case DENALIPHY_JOBSTATE_6: /* PMA_PMD_CONTROL_1 register */
        if (ETHXCVR_MODE_DOWN == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (0x1U << 11U);
        } else {
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1U << 11U));
        }

        pkt.deviceType = 0x1U;
        pkt.regAddr = 0x0000U; /* PMA_PMD_CONTROL_1 register */
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_7;
        break;
    case DENALIPHY_JOBSTATE_7:
        /* Access to set 4mA driver */
        pkt.deviceType = 0x1U;
        pkt.regAddr = 0xA011U; /* RGMII Control 2 register */
        pkt.regData = 0x1030U;
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_8;
        break;
    case DENALIPHY_JOBSTATE_8:
        pkt.deviceType = 0x1U;
        pkt.regAddr = 0x0834U; /* PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_9;
        break;
    case DENALIPHY_JOBSTATE_9:
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->phy.masterMode) {
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] | (0x1U << 14U);
        } else {
            pkt.regData = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (~(0x1U << 14U));
        }
        pkt.deviceType = 0x1U;
        pkt.regAddr = 0x0834U; /* PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL register */
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_10;
        break;
    case DENALIPHY_JOBSTATE_10:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9306U; /* CORE_MISC_EXP46 register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_11;
        break;
    case DENALIPHY_JOBSTATE_11:
        /* FIFO_ELASTICITY_MODE:
           11 = Support 18k byte packets
           10 = support 15k byte packets
           01 = support 10k byte packets
           00 = support 5k byte packets (w/200 ppm offset)
         */
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo) {
            value = 1U;
        } else {
            value = 0U;
        }
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9306U; /* CORE_MISC_EXP46 register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~(0x3U << 14U)) | (value << 14U));
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_12;
        break;
    case DENALIPHY_JOBSTATE_12:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x8c01U; /* BR_GPCS_GMII_FIFO_CTL1 register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_13;
        break;
    case DENALIPHY_JOBSTATE_13:
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo) {
            value = 1U;
        } else {
            value = 0U;
        }
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x8c01U; /* BR_GPCS_GMII_FIFO_CTL1 register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value);
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_14;
        break;
    case DENALIPHY_JOBSTATE_14:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9010U; /* T1_CORE_MIIFIFO_CONTROL register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_15;
        break;
    case DENALIPHY_JOBSTATE_15:
        if (ETHXCVR_BOOLEAN_TRUE == aConfig->jumbo) {
            value = 1U;
        } else {
            value = 0U;
        }
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9010U; /* T1_CORE_MIIFIFO_CONTROL register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value);
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_16;
        break;
    case DENALIPHY_JOBSTATE_16:
        if (NULL != aIsModeChanged) {
            *aIsModeChanged = TRUE;
        }
        if (NULL != aMode) {
            *aMode = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET];
        }
        write = FALSE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
        break;
    default:
        write = FALSE;
        read = FALSE;
        retVal = BCM_ERR_INVAL_STATE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        break;
    }

    if ((TRUE == read) || (TRUE == write)) {
        /* Check space in MDIO job queue */
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }

        /* Queue MDIO request */
        pkt.slaveAddr = aConfig->phy.slaveID;
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
        if (TRUE == write) {
            retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobId);
        }
        if (TRUE == read) {
            retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId);
        }
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState;

    /* Except for the first state, remaining states should indicate EAGAIN so
     * that the state machine is triggered again until completion */
    if ((DENALIPHY_JOBSTATE_0 != state) /* first call to accept */
        && (DENALIPHY_JOBSTATE_NONE != nextState) /* last state to complete */
        && (BCM_ERR_OK == retVal)) { /* only if there was no other error */
        retVal = BCM_ERR_EAGAIN;
    }

err_jobclr:
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId;
err:
    return retVal;
}

/**
    @brief Set Master/slave mode State-0 Handler

    @code{.c}
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL)
    if (BCM_ERR_OK != retVal)
        return retVal

    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x1
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0834

    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (retVal is BCM_ERR_OK)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMasterMode0StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;

    /* Check space in MDIO job queue */
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x1U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0834U; /* PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL register */
    /* Queue MDIO requests */
    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1;
    }
err:
    return retVal;
}

/**
    @brief Set master/slave mode State-1 handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (retVal is not BCM_ERR_OK)
        if (retVal is BCM_ERR_BUSY)
            retVal = BCM_ERR_EAGAIN
        return retVal

    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x1
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0834
    if (ETHXCVR_BOOLEAN_TRUE is aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
        pkt.regData = pkt.regData | (0x1 << 14)
    else
        pkt.regData = pkt.regData & (~(0x1 << 14))

    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (retVal is BCM_ERR_OK)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_2
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMasterMode1StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x1U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0834U; /* PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL register */
    if (ETHXCVR_BOOLEAN_TRUE == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
        pkt.regData = pkt.regData | (0x1U << 14U);
    } else {
        pkt.regData = pkt.regData & (~(0x1U << 14U));
    }
    /* Queue MDIO requests */
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_2;
    }
err:
    return retVal;
}

/**
    @brief Set Master/slave mode state-2 handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (retVal is not BCM_ERR_OK)
        if (retVal is BCM_ERR_BUSY)
            retVal = BCM_ERR_EAGAIN
        return retVal

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMasterMode2StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;

err:
    return retVal;
}
/**
    @brief Set master/slave State Handler

    @code{.c}
    if jobState is DENALIPHY_JOBSTATE_0
        retVal = DENALIPHY_SetMasterMode0StateHandler(aPhyIdx, aPhyCntxt, aConfig)
        break
    else if jobState is DENALIPHY_JOBSTATE_1
        retVal = DENALIPHY_SetMasterMode1StateHandler(aPhyIdx, aPhyCntxt, aConfig)
        if (retVal is BCM_ERR_OK)
            retVal = BCM_ERR_EAGAIN;
        break;
    else if jobState is DENALIPHY_JOBSTATE_2
        retVal = DENALIPHY_SetMasterMode2StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else
        retVal = BCM_ERR_INVAL_STATE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMasterModeStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    switch (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]) {
    case DENALIPHY_JOBSTATE_0:
        retVal = DENALIPHY_SetMasterMode0StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOBSTATE_1:
        retVal = DENALIPHY_SetMasterMode1StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        /* StateMachine needs to be triggered again for completion */
        if (BCM_ERR_OK == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        break;
    case DENALIPHY_JOBSTATE_2:
        retVal = DENALIPHY_SetMasterMode2StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

    return retVal;
}

/**
    @brief Set speed state Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @note: TBD
*/
static int32_t DENALIPHY_SetSpeedStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @brief Set Loopback mode State-0 Handler

    @code{.c}
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL)
    if (retVal is not BCM_ERR_OK)
        return retVal
    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x3
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0000
    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (retVal is BCM_ERR_OK)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetLoopbackMode0StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;

    /* Check space in MDIO job queue */
    retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
    if (BCM_ERR_OK != retVal) {
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x3U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0000U; /* PCS_IEEE_PCS_CONTROL_1 register */
    /* Queue MDIO requests */
    retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_1;
    }
err:
    return retVal;
}

/**
    @brief Set Loopback mode State-1 Handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (BCM_ERR_OK != retVal)
        if (retVal is BCM_ERR_BUSY)
            retVal = BCM_ERR_EAGAIN
        return retVal

    pkt.slaveAddr = aConfig->phy.slaveID
    pkt.deviceType = 0x3
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
    pkt.regAddr = 0x0000
    if (ETHXCVR_BOOLEAN_TRUE is aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
        pkt.regData = pkt.regData | (0x1 << 14)
    else
        pkt.regData = pkt.regData & (~(0x1 << 14))
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET])
    if (retVal is BCM_ERR_OK)
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_2
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetLoopbackMode1StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    pkt.slaveAddr = aConfig->phy.slaveID;
    pkt.deviceType = 0x3U;
    pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
    pkt.regAddr = 0x0000U; /* PCS_IEEE_PCS_CONTROL_1 register */
    if (ETHXCVR_BOOLEAN_TRUE == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
        pkt.regData = pkt.regData | (0x1U << 14U);
    } else {
        pkt.regData = pkt.regData & (~(0x1U << 14U));
    }
    /* Queue MDIO requests */
    retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]);
    if (BCM_ERR_OK == retVal) {
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_2;
    }
err:
    return retVal;
}

/**
    @brief Set Loopback mode State-2 Handler

    @code{.c}
    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
    if (retVal is not BCM_ERR_OK)
        if (retVal is BCM_ERR_BUSY)
            retVal = BCM_ERR_EAGAIN
        return retVal
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetLoopbackMode2StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;

    jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    /* Retrieve register values */
    retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
    if (BCM_ERR_OK != retVal) {
        if (BCM_ERR_BUSY == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        goto err;
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_NONE;
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;

err:
    return retVal;
}
/**
    @brief Set Loopback mode State Handler

    @code{.c}
    jobState = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]
    if jobState is DENALIPHY_JOBSTATE_0
        retVal = DENALIPHY_SetLoopbackMode0StateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if jobState is DENALIPHY_JOBSTATE_1
        retVal = DENALIPHY_SetLoopbackMode1StateHandler(aPhyIdx, aPhyCntxt, aConfig)
        if (retVal is BCM_ERR_OK)
            retVal = BCM_ERR_EAGAIN
    else if jobState is DENALIPHY_JOBSTATE_2
        retVal = DENALIPHY_SetLoopbackMode2StateHandler(aPhyIdx, aPhyCntxt, aConfig);
    else
        retVal = BCM_ERR_INVAL_STATE
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetLoopbackModeStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;

    /* Todo */
    switch (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]) {
    case DENALIPHY_JOBSTATE_0:
        retVal = DENALIPHY_SetLoopbackMode0StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOBSTATE_1:
        retVal = DENALIPHY_SetLoopbackMode1StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        /* StateMachine needs to be triggered again for completion */
        if (BCM_ERR_OK == retVal) {
            retVal = BCM_ERR_EAGAIN;
        }
        break;
    case DENALIPHY_JOBSTATE_2:
        retVal = DENALIPHY_SetLoopbackMode2StateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

    return retVal;
}

/**
    @brief Set Jumbo mode state handler

    @code{.c}
    state = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]
    if (DENALIPHY_JOBSTATE_0 == state)
        jobId = 0xFFFFFFFFUL
    else
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]
    if (0xFFFFFFFFUL != jobId)
        retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
        if (retVal is not BCM_ERR_OK)
            if (retVal is BCM_ERR_BUSY)
                retVal = BCM_ERR_EAGAIN
            return retVal
        jobId = 0xFFFFFFFFUL
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData

    if (ETHXCVR_BOOLEAN_TRUE == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
        value = 1
    else
        value = 0

    if state is DENALIPHY_JOBSTATE_0
        pkt.deviceType = 0x01U
        pkt.regAddr = 0x9306U
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_1
    else if state is DENALIPHY_JOBSTATE_1
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9306
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~(0x3U << 14U)) | (value << 14U))
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_2
    else if state is DENALIPHY_JOBSTATE_2
        pkt.deviceType = 0x01
        pkt.regAddr = 0x8c01
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_3
    else if state is DENALIPHY_JOBSTATE_3
        pkt.deviceType = 0x01
        pkt.regAddr = 0x8c01
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value)
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_4
    else if state is DENALIPHY_JOBSTATE_4
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9010
        write = FALSE
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_5
    else if state is DENALIPHY_JOBSTATE_5
        pkt.deviceType = 0x01
        pkt.regAddr = 0x9010
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value)
        write = TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_6
    else if state is DENALIPHY_JOBSTATE_6
        write = FALSE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_NONE
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
    else
        write = FALSE
        read = FALSE
        retVal = BCM_ERR_INVAL_STATE
        nextState = DENALIPHY_JOBSTATE_NONE

    if (read is TRUE) OR (write is TRUE)
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1)
        if (BCM_ERR_OK != retVal)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
            return retVal
        pkt.slaveAddr = aConfig->phy.slaveID;
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
        if (TRUE == write)
            retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobId)
        if (TRUE == read)
            retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId)
        if (BCM_ERR_OK != retVal)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
            return retVal


    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState

    if ((DENALIPHY_JOBSTATE_0 != state) AND (DENALIPHY_JOBSTATE_NONE != nextState)
        AND (retVal is BCM_ERR_OK))
        retVal = BCM_ERR_EAGAIN
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetJumboModeStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;
    uint32_t state;
    uint32_t nextState;
    uint32_t write = FALSE;
    uint32_t read = FALSE;
    uint16_t value;

    state = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET];
    if (DENALIPHY_JOBSTATE_0 == state) {
        /* Reset Job ID field upon first entry */
        jobId = 0xFFFFFFFFUL;
    } else {
        /* Check if a read/write access is pending completion */
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    }

    if (0xFFFFFFFFUL != jobId) {
        /* Retrieve already issued register access result */
        retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
        if (BCM_ERR_OK != retVal) {
            if (BCM_ERR_BUSY == retVal) {
                retVal = BCM_ERR_EAGAIN;
            }
            goto err;
        }
        jobId = 0xFFFFFFFFUL;

        /* Irrespective of read/write, save pkt.data. Consumed only if a read
         * was awaiting completion.
         * Saving this value is necessary since a successive MDIO access using
         * this read value might fail(busy/retry) and the read valye would be
         * needed upon next entry(however MDIO driver would not be able to
         * recognise that job at that later point of time */
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData;
    }

    /* FIFO_ELASTICITY_MODE:
       11 = Support 18k byte packets
       10 = support 15k byte packets
       01 = support 10k byte packets
       00 = support 5k byte packets (w/200 ppm offset)
     */
    if (ETHXCVR_BOOLEAN_TRUE == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
        value = 1U;
    } else {
        value = 0U;
    }

    switch (state) {
    case DENALIPHY_JOBSTATE_0:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9306U; /* CORE_MISC_EXP46 register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_1;
        break;
    case DENALIPHY_JOBSTATE_1:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9306U; /* CORE_MISC_EXP46 register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~(0x3U << 14U)) | (value << 14U));
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_2;
        break;
    case DENALIPHY_JOBSTATE_2:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x8c01U; /* BR_GPCS_GMII_FIFO_CTL1 register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_3;
        break;
    case DENALIPHY_JOBSTATE_3:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x8c01U; /* BR_GPCS_GMII_FIFO_CTL1 register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value);
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_4;
        break;
    case DENALIPHY_JOBSTATE_4:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9010U; /* T1_CORE_MIIFIFO_CONTROL register */
        write = FALSE;
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_5;
        break;
    case DENALIPHY_JOBSTATE_5:
        pkt.deviceType = 0x01U;
        pkt.regAddr = 0x9010U; /* T1_CORE_MIIFIFO_CONTROL register */
        pkt.regData = ((aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
                        & ~0x3U) | value);
        write = TRUE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_6;
        break;
    case DENALIPHY_JOBSTATE_6:
        write = FALSE;
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
        break;
    default:
        write = FALSE;
        read = FALSE;
        retVal = BCM_ERR_INVAL_STATE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        break;
    }

    if ((TRUE == read) || (TRUE == write)) {
        /* Check space in MDIO job queue */
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }

        /* Queue MDIO request */
        pkt.slaveAddr = aConfig->phy.slaveID;
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
        if (TRUE == write) {
            retVal = MDIO_Write(aConfig->phy.hwID, &pkt, &jobId);
        }
        if (TRUE == read) {
            retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId);
        }
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState;

    /* Except for the first state, remaining states should indicate EAGAIN so
     * that the state machine is triggered again until completion */
    if ((DENALIPHY_JOBSTATE_0 != state) /* first call to accept */
        && (DENALIPHY_JOBSTATE_NONE != nextState) /* last state to complete */
        && (BCM_ERR_OK == retVal)) { /* only if there was no other error */
        retVal = BCM_ERR_EAGAIN;
    }

err_jobclr:
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId;
err:
    return retVal;
}

/**
    @brief Set Autonegotiation mode state Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @note: TBD
*/
static int32_t DENALIPHY_SetAutoNegModeStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @brief Restart Autonegotiation state Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @note: TBD
*/
static int32_t DENALIPHY_RestartAutoNegStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @brief Get Autonegotiation Status state Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @note: TBD
*/
static int32_t DENALIPHY_GetAutoNegStatusStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @brief Update Hardware Status

    @code{.c}
    state = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET]
    if (DENALIPHY_JOBSTATE_0 == state)
        jobId = 0xFFFFFFFFUL
    else
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET]

    if (0xFFFFFFFFUL != jobId)
        retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt)
        if (retVal is not BCM_ERR_OK)
            if (retVal is BCM_ERR_BUSY)
                retVal = BCM_ERR_EAGAIN
            return retVal
        jobId = 0xFFFFFFFFUL
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData

    if state is DENALIPHY_JOBSTATE_0
        pkt.deviceType = 0x1
        pkt.regAddr = 0x0001
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_1
        aPhyCntxt->cacheInfo.flowControl = ETHXCVR_FLOWCONTROL_NONE
        aPhyCntxt->cacheInfo.duplexMode = ETHXCVR_DUPLEXMODE_FULL
        aPhyCntxt->cacheInfo.speed = ETHXCVR_SPEED_100MBPS
        aPhyCntxt->cacheInfo.sqiValue = 0
    else if state is DENALIPHY_JOBSTATE_1
        if (0U == (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 2U)))
            aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN
        else
            aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_ACTIVE
        pkt.deviceType = 0x1E
        pkt.regAddr = 0xF0
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_2
    else if state is DENALIPHY_JOBSTATE_2
        if (0U == (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 15U)))
            if wakeup Mode Enabled
            aPhyCntxt->cacheInfo.wakeupMode = ETHXCVR_BOOLEAN_TRUE
            pkt.deviceType = 0x1E
            pkt.regAddr = 0xF1
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_3
        else
            aPhyCntxt->cacheInfo.wakeupMode = ETHXCVR_BOOLEAN_FALSE
            pkt.deviceType = 0x1U
            pkt.regAddr = 0x0000U
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_4
    else if state is DENALIPHY_JOBSTATE_3
        check if any wakeup happend
        if( 0U != (DENALIPHY_TC10WAKEUPMASK & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]))
            cache the TC10 Status register to process the wakeup reason
            aPhyCntxt->cacheInfo.tc10Status = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]
        if(DENALIPHY_TC10STATUS_STANDBYSTATE_MASK != (DENALIPHY_TC10STATUS_STANDBYSTATE_MASK
                                                      & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET]))
            if the port is in not standBy then update the portMode and proceed
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_ACTIVE
            pkt.deviceType = 0x1U
            pkt.regAddr = 0x0834U
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_5
        else
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_DOWN
            read = FALSE
            nextState = DENALIPHY_JOBSTATE_NONE
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
            retVal = BCM_ERR_OK
    else if state is DENALIPHY_JOBSTATE_4
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 11U)))
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_DOWN
        else
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_ACTIVE
        pkt.deviceType = 0x1
        pkt.regAddr = 0x0834
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_5
    else if state is DENALIPHY_JOBSTATE_5
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 14U)))
            aPhyCntxt->cacheInfo.connMode = ETHXCVR_BOOLEAN_TRUE
        else
            aPhyCntxt->cacheInfo.connMode = ETHXCVR_BOOLEAN_FALSE

        pkt.deviceType = 0x3
        pkt.regAddr = 0x0000
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_6
    else if state is DENALIPHY_JOBSTATE_6
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 14U)))
            aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_TRUE
        else
            aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_FALSE

        pkt.deviceType = 0x01
        pkt.regAddr = 0x9306
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_7
    else if state is DENALIPHY_JOBSTATE_7
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] >> 14U
        pkt.deviceType = 0x01
        pkt.regAddr = 0x8c01
        read = TRUE
        nextState = DENALIPHY_JOBSTATE_8
    else if state is DENALIPHY_JOBSTATE_8
        if (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
            is not (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & 0x3U))
            read = FALSE
            nextState = DENALIPHY_JOBSTATE_NONE
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
            aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE
            retVal = BCM_ERR_OK
        else
            pkt.deviceType = 0x01
            pkt.regAddr = 0x9010
            read = TRUE
            nextState = DENALIPHY_JOBSTATE_9
    else if state is DENALIPHY_JOBSTATE_9
        if (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
            is not (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & 0x3U))
            aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE
            retVal = BCM_ERR_OK
        else
            if (0x00U == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET])
                aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE
            else
                aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_TRUE
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_NONE
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE
        retVal = BCM_ERR_OK
    else
        read = FALSE
        nextState = DENALIPHY_JOBSTATE_NONE
        retVal = BCM_ERR_INVAL_STATE
        break

    if (read is TRUE)
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL)
        if (retVal is not BCM_ERR_OK)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
            return retVal
        pkt.slaveAddr = aConfig->phy.slaveID
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45
        retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId)
        if (retVal is not BCM_ERR_OK)
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
            return retVal
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState
    if ((DENALIPHY_JOBSTATE_0 != state) AND (DENALIPHY_JOBSTATE_NONE != nextState)
        AND (BCM_ERR_OK == retVal))
        retVal = BCM_ERR_EAGAIN
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId
    return retVal
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_UpdateHWStatusStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    int32_t retVal = BCM_ERR_OK;
    ETHER_MDIOPktType pkt;
    uint32_t jobId;
    uint32_t state;
    uint32_t nextState;
    uint32_t read = FALSE;

    state = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET];
    if (DENALIPHY_JOBSTATE_0 == state) {
        /* Reset Job ID field upon first entry */
        jobId = 0xFFFFFFFFUL;
    } else {
        /* Check if a read/write access is pending completion */
        jobId = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET];
    }

    if (0xFFFFFFFFUL != jobId) {
        /* Retrieve already issued register read result */
        retVal = MDIO_GetJobResult(aConfig->phy.hwID, jobId, &pkt);
        if (BCM_ERR_OK != retVal) {
            if (BCM_ERR_BUSY == retVal) {
                retVal = BCM_ERR_EAGAIN;
            }
            goto err;
        }
        jobId = 0xFFFFFFFFUL;

        /* Irrespective of read/write, save pkt.data. Consumed only if a read
         * was awaiting completion.
         * Saving this value is necessary since a successive MDIO access using
         * this read value might fail(busy/retry) and the read valye would be
         * needed upon next entry(however MDIO driver would not be able to
         * recognise that job at that later point of time */
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] = pkt.regData;
    }

    switch (state) {
    case DENALIPHY_JOBSTATE_0:
        aPhyCntxt->cacheInfo.flowControl = ETHXCVR_FLOWCONTROL_NONE;
        aPhyCntxt->cacheInfo.duplexMode = ETHXCVR_DUPLEXMODE_FULL;
        /* TODO: Get speed and sqi */
        aPhyCntxt->cacheInfo.sqiValue = 0UL;

        pkt.deviceType = 0x1E;
        pkt.regAddr = 0xF0; /* TC10_CONTROL_REGISTER_1 register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_1;
        break;

    case DENALIPHY_JOBSTATE_1:
        /* Store WakeUp Mode (TC10 Enabled or Not) and access to get TC10_STATUS_REGISTER_1 */
        if (0U == (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1UL << 15U))) {
            /* If bit15 is '0' then Enabled */
            aPhyCntxt->cacheInfo.wakeupMode = ETHXCVR_BOOLEAN_TRUE;
            pkt.deviceType = 0x1E;
            pkt.regAddr = 0xF1; /* TC10_STATUS_REGISTER_1 register */
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_2;
        } else {
            /* if TC10 is not enabled then proceed to read the Mode */
            aPhyCntxt->cacheInfo.wakeupMode = ETHXCVR_BOOLEAN_FALSE;
            pkt.deviceType = 0x1U;
            pkt.regAddr = 0x0000U; /* PMA_PMD_CONTROL_1 register */
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_3;
            break;
        }
        break;

    case DENALIPHY_JOBSTATE_2:
        /* Store WakeUp Reason and Access CORE_MISC_EXP46 connMode*/
        if( 0U != (DENALIPHY_TC10WAKEUPMASK & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET])) {
            aPhyCntxt->cacheInfo.tc10Status = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET];
        }
        /* checking the Port in Standby State. In standby state other than TC10 Control and Status Registers
           all other registers are invalid. So can skip other registers reading if standby State*/
        if(DENALIPHY_TC10STATUS_STANDBYSTATE_MASK != (DENALIPHY_TC10STATUS_STANDBYSTATE_MASK
                                                      & aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET])) {
            /* Awake State */
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_ACTIVE;
            /* Access to get linkState */
            pkt.deviceType = 0x1U;
            pkt.regAddr = 0x0001U; /* PMA_PMD_STATUS_1 register */
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_4;
        } else {
            /* 'cacheInfo.localModeState' is updated with #ETHXCVR_MODE_DOWN when PHY is in standBy mode.
               If wakeup Requestd By local PHY then it will be updated to #ETHXCVR_MODE_ACTIVE in 'SetModeStateHandler'
               This helps to report wakeup reason accurately where the connected Partner PHY try for a
               Unauthorized Wakeup.
               Unauthorized Wakeup : If One PHY (local) sends a sleep request then both the connected PHY's will
               go to Sleep. At this state if the connected (remote) PHY try to wakeup instead from
               Sleep Requestd source PHY then it is an Unauthorized Wakeup.
               At this state PHY will be still on StandBy as this operation is not allowed*/
            aPhyCntxt->cacheInfo.localModeState = ETHXCVR_MODE_DOWN;
            /* Update the Admin Mode */
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_DOWN;
            /* Clear the Previous tc10status cache to not give any wakeupreason when Sleep on a Remote PHY.
               When Port is wakeup then 'cacheInfo.tc10Status' will be updated from the TC10 Status register.
               If user did not query the Reason this variable will not be cleared unless a new wakeup identified.
               Now, a sleep request is received and Port is in standBy mode. Since there is no wakeup detected
              'cacheInfo.tc10Status' will not be updated in the HWStatusStateHandler and hold the previous value.
               So at this state user query the wakeupReason will give Local/Remote but actuval wakeup will not happen.
               So to avoid that 'cacheInfo.tc10Status' needs to be cleard when in sleep / sleep request*/
            aPhyCntxt->cacheInfo.tc10Status =0;
            /* if on standBy then skip all other Jobs */
            read = FALSE;
            nextState = DENALIPHY_JOBSTATE_NONE;
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
            retVal = BCM_ERR_OK;
        }
        break;
    case DENALIPHY_JOBSTATE_3:
        /* Store mode and access to get  */
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 11U))) {
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_DOWN;
        } else {
            aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_ACTIVE;
        }

        /* Access to get linkState */
        pkt.deviceType = 0x1U;
        pkt.regAddr = 0x0001U; /* PMA_PMD_STATUS_1 register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_4;
        break;
    case DENALIPHY_JOBSTATE_4:
        /* Store linkState and access to PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL to update Master/Slave and Speed*/
        if (0U == (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 2U))) {
            aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN;
        } else {
            aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_ACTIVE;
        }

        pkt.deviceType = 0x1U;
        pkt.regAddr = 0x0834U; /* PMA_PMD_IEEE_BASET1_PMA_PMD_CONTROL register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_5;
        break;
    case DENALIPHY_JOBSTATE_5:
        /* Store connMode and access to get loopbackMode */
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 14U))) {
            aPhyCntxt->cacheInfo.connMode = ETHXCVR_BOOLEAN_TRUE;
        } else {
            aPhyCntxt->cacheInfo.connMode = ETHXCVR_BOOLEAN_FALSE;
        }
        /* Read the operating Speed configured*/
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U))) {
            aPhyCntxt->cacheInfo.speed = ETHXCVR_SPEED_1000MBPS;
        } else {
            aPhyCntxt->cacheInfo.speed = ETHXCVR_SPEED_100MBPS;
        }

        pkt.deviceType = 0x3U;
        pkt.regAddr = 0x0000U; /* PCS_IEEE_PCS_CONTROL_1 register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_6;
        break;

    case DENALIPHY_JOBSTATE_6:
        /* Store loopbackMode and access CORE_MISC_EXP46 */
        if (0U != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & (0x1U << 14U))) {
            aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_TRUE;
        } else {
            aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_FALSE;
        }

        pkt.deviceType = 0x01;
        pkt.regAddr = 0x9306; /* CORE_MISC_EXP46 register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_7;
        break;

    case DENALIPHY_JOBSTATE_7:
        /* Store jumbo value locally and access to validate it with BR_GPCS_GMII_FIFO_CTL1 */
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] >> 14U;

        pkt.deviceType = 0x01;
        pkt.regAddr = 0x8c01; /* BR_GPCS_GMII_FIFO_CTL1 register */
        read = TRUE;
        nextState = DENALIPHY_JOBSTATE_8;
        break;

    case DENALIPHY_JOBSTATE_8:
        /* Validate jumboMode */
        if (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
            != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & 0x3U)) {
            /* Inconsistent jumbo configuration, abort with status as jumbo
             * disabled */

            read = FALSE;
            nextState = DENALIPHY_JOBSTATE_NONE;
            aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
            aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE;
            retVal = BCM_ERR_OK;
        } else {
            /* Access to validate it with T1_CORE_MIIFIFO_CONTROL */
            pkt.deviceType = 0x01;
            pkt.regAddr = 0x9010; /* T1_CORE_MIIFIFO_CONTROL register */
            read = TRUE;
            nextState = DENALIPHY_JOBSTATE_9;
        }
        break;

    case DENALIPHY_JOBSTATE_9:
        /* Validate jumboMode */
        if (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]
            != (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_REGVAL_OFFSET] & 0x3U)) {
            /* Inconsistent jumbo configuration, abort with status as jumbo
             * disabled */

            aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE;
            retVal = BCM_ERR_OK;
        } else {
            /* FIFO_ELASTICITY_MODE:
                11 = Support 18k byte packets
                10 = support 15k byte packets
                01 = support 10k byte packets
                00 = support 5k byte packets (w/200 ppm offset)
            */
            if (0x00U == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET]) {
                aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE;
            } else {
                aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_TRUE;
            }
        }

        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = DENALIPHY_JOB_NONE;
        retVal = BCM_ERR_OK;
        break;

    default:
        read = FALSE;
        nextState = DENALIPHY_JOBSTATE_NONE;
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

    if (TRUE == read) {
        /* Check space in MDIO job queue */
        retVal = DENALIPHY_CheckMDIOJobQFreeLen(aConfig->phy.hwID, 1UL);
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }

        pkt.slaveAddr = aConfig->phy.slaveID;
        pkt.regAccMode = ETHER_MDIOREGACCESS_CL45;
        /* Queue MDIO requests */
        retVal = MDIO_Read(aConfig->phy.hwID, &pkt, &jobId);
        if (BCM_ERR_OK != retVal) {
            goto err_jobclr;
        }
    }

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = nextState;

    /* Except for the first state, remaining states should indicate EAGAIN so
     * that the state machine is triggered again until completion */
    if ((DENALIPHY_JOBSTATE_0 != state) /* first call to accept */
        && (DENALIPHY_JOBSTATE_NONE != nextState) /* last state to complete */
        && (BCM_ERR_OK == retVal)) { /* only if there was no other error */
        retVal = BCM_ERR_EAGAIN;
    }

err_jobclr:
    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_MDIOJOB_OFFSET] = jobId;
err:
    return retVal;
}

/**
    @brief Internal State Handler

    @code{.c}
    if JobType is DENALIPHY_JOB_RESET:
        DENALIPHY_ResetStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_GETLINKSTATE:
        DENALIPHY_GetLinkStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_SETMODE:
        DENALIPHY_SetModeStateHandler(aPhyIdx, aPhyCntxt, aConfig, aIsModeChanged, aMode)
    else if JobType is DENALIPHY_JOB_SETMASTERMODE:
        DENALIPHY_SetMasterModeStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_SETSPEED:
        DENALIPHY_SetSpeedStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_SETLOOPBACKMODE:
        DENALIPHY_SetLoopbackModeStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_SETJUMBOMODE:
        DENALIPHY_SetJumboModeStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_SETAUTONEGMODE:
        DENALIPHY_SetAutoNegModeStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_RESTARTAUTONEG:
        DENALIPHY_RestartAutoNegStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_GETAUTONEGSTATUS:
        DENALIPHY_GetAutoNegStatusStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else if JobType is DENALIPHY_JOB_UPDATEHWSTATUS:
        DENALIPHY_UpdateHWStatusStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    else
        return BCM_ERR_INVAL_STATE
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_IntStateHandler(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               uint32_t *const aIsModeChanged,
                               ETHXCVR_ModeType *const aMode)
{
    int32_t retVal;

    switch (aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET]) {
    case DENALIPHY_JOB_RESET:
        retVal = DENALIPHY_ResetStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_GETLINKSTATE:
        retVal = DENALIPHY_GetLinkStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_SETMODE:
        retVal = DENALIPHY_SetModeStateHandler(aPhyIdx, aPhyCntxt, aConfig,
                aIsModeChanged, aMode);
        break;
    case DENALIPHY_JOB_SETMASTERMODE:
        retVal = DENALIPHY_SetMasterModeStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_SETSPEED:
        retVal = DENALIPHY_SetSpeedStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_SETLOOPBACKMODE:
        retVal = DENALIPHY_SetLoopbackModeStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_SETJUMBOMODE:
        retVal = DENALIPHY_SetJumboModeStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_SETAUTONEGMODE:
        retVal = DENALIPHY_SetAutoNegModeStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_RESTARTAUTONEG:
        retVal = DENALIPHY_RestartAutoNegStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_GETAUTONEGSTATUS:
        retVal = DENALIPHY_GetAutoNegStatusStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    case DENALIPHY_JOB_UPDATEHWSTATUS:
        retVal = DENALIPHY_UpdateHWStatusStateHandler(aPhyIdx, aPhyCntxt, aConfig);
        break;
    default:
        retVal = BCM_ERR_INVAL_STATE;
        break;
    }

    return retVal;
}

/**
    @brief Queue Job

    @code{.c}
    If (aPhyCntxt is NULL) or (DENALIPHY_JOB_MAX < aJobType)
        return BCM_ERR_INVAL_PARAMS
    else if JobType is not DENALIPHY_JOB_NONE
        return BCM_ERR_BUSY
    else if drvState is ETHXCVR_STATE_UNINIT
        return BCM_ERR_UNINIT
    else
        Set JobType as aJobType
        Set JobState as DENALIPHY_JOBSTATE_0
        DENALIPHY_IntStateHandler(aPhyIdx, aPhyCntxt, aConfig, NULL, NULL)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_QueueJob(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               DENALIPHY_JobType aJobType)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t *cntxtData = NULL;

    if ((NULL == aPhyCntxt) || (DENALIPHY_JOB_MAX < aJobType)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (DENALIPHY_JOB_NONE != aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET]) {
        retVal = BCM_ERR_BUSY;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        cntxtData = aPhyCntxt->data;
        cntxtData[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET] = aJobType;
        cntxtData[DENALIPHY_CNTXT_DATA_JOBSTATE_OFFSET] = DENALIPHY_JOBSTATE_0;
        retVal = DENALIPHY_IntStateHandler(aPhyIdx, aPhyCntxt, aConfig, NULL,
                NULL);
    }

    return retVal;
}

/**
    @brief Get Link state

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.linkState to aLinkState
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetLinkState(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_LinkStateType *const aLinkState)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aLinkState = aPhyCntxt->cacheInfo.linkState;
    }

    return retVal;
}

/**
    @brief Reset

    @code{.c}
    DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_RESET)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_Reset(uint8_t aPhyIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_RESET);
}

/**
    @brief Set administrative mode

    @code{.c}
    if TC10 #ETHXCVR_BOOLEAN_TRUE AND
          Speed is NOT #ETHXCVR_SPEED_100MBPS OR AutoNeg is NOT #ETHXCVR_BOOLEAN_FALSE
        retVal = BCM_ERR_INVAL_PARAMS;
    else
        Copy aMode into Data_Arg1 and update retVal
    if aMode is not ETHXCVR_MODE_ISOLATE
        DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETMODE)
    return BCM_ERR_OK

    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType aMode)
{
    int32_t retVal = BCM_ERR_OK;

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aMode;
    if (ETHXCVR_MODE_ISOLATE != aMode) {
        retVal = DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETMODE);
    }

    return retVal;
}

/**
    @brief Getadmin mode configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.mode to aMode
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_ModeType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aMode = aPhyCntxt->cacheInfo.mode;
    }

    return retVal;
}

/**
    @brief Set Master/slave mode

    @code{.c}
    Copy aMasterMode to Data_Arg1
    DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETMASTERMODE)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetMasterMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType aMasterMode)
{
    int32_t retVal;

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aMasterMode;
    retVal = DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETMASTERMODE);

    return retVal;
}

/**
    @brief Get master/slave configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.connMode to aConnMode
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetMasterMode(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType *const aConnMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aConnMode = aPhyCntxt->cacheInfo.connMode;
    }

    return retVal;
}

/**
    @brief Set speed

    @code{.c}
    if aSpeed is ETHXCVR_SPEED_1000MBPS
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetSpeed(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_SpeedType aSpeed)
{

    int32_t retVal;

    if (ETHXCVR_SPEED_100MBPS <= aSpeed) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @brief Get speed configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.speed to aSpeed
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetSpeed(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_SpeedType *const aSpeed)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aSpeed = aPhyCntxt->cacheInfo.speed;
    }

    return retVal;
}

/**
    @brief Get Duplex mode configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Set aDuplexMode as ETHXCVR_DUPLEXMODE_FULL
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetDuplexMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_DuplexModeType *const aDuplexMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        /* TODO: Get registers for duplex */
        *aDuplexMode = ETHXCVR_DUPLEXMODE_FULL;
    }

    return retVal;
}

/**
    @brief Set Duplex mode

    @code{.c}
    if aDuplexMode is ETHXCVR_DUPLEXMODE_FULL
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetDuplexMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_DuplexModeType aDuplexMode)
{
    int32_t retVal;

    if (ETHXCVR_DUPLEXMODE_FULL == aDuplexMode) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @brief Set Flowcontrol

    @code{.c}
    if aFlowCOntrol is ETHXCVR_FLOWCONTROL_NONE
        return BCM_ERR_OK
    else
        return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType aFlowControl)
{
    int32_t retVal;

    if (ETHXCVR_FLOWCONTROL_NONE == aFlowControl) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_NOSUPPORT;
    }

    return retVal;
}

/**
    @brief Get Flowcontrol configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.flowControl to aFlowControl
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetFlowControl(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_FlowControlType *const aFlowControl)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aFlowControl = aPhyCntxt->cacheInfo.flowControl;
    }

    return retVal;
}


/**
    @brief Get Signal Quality Index

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.sqiValue to aSQIValue
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetSQIValue(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    uint32_t *const aSQIValue)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aSQIValue = aPhyCntxt->cacheInfo.sqiValue;
    }

    return retVal;
}

/**
    @brief Initialisation

    @code{.c}
    aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN
    aPhyCntxt->cacheInfo.mode = ETHXCVR_MODE_ACTIVE
    PhyCntxt->cacheInfo.connMode = ETHXCVR_BOOLEAN_TRUE
    aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_FALSE
    aPhyCntxt->cacheInfo.jumboMode = ETHXCVR_BOOLEAN_FALSE
    aPhyCntxt->cacheInfo.speed = ETHXCVR_SPEED_100MBPS
    aPhyCntxt->cacheInfo.flowControl = ETHXCVR_FLOWCONTROL_NONE
    aPhyCntxt->cacheInfo.sqiValue = 0UL
    aPhyCntxt->cacheInfo.duplexMode = ETHXCVR_DUPLEXMODE_FULL
    aPhyCntxt->cacheInfo.localModeState = ETHXCVR_MODE_DOWN
    aPhyCntxt->cacheInfo.tc10Status = 0U

    DENALIPHY_InitStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_Init(uint8_t aPhyIdx,
                            ETHXCVR_CntxtType *const aPhyCntxt,
                            const ETHXCVR_PortConfigType *const aConfig)
{
    aPhyCntxt->cacheInfo.linkState = ETHXCVR_LINKSTATE_DOWN;
    aPhyCntxt->cacheInfo.mode = (aConfig->portEnable == ETHXCVR_BOOLEAN_TRUE) ? ETHXCVR_MODE_ACTIVE:ETHXCVR_MODE_DOWN;;
    aPhyCntxt->cacheInfo.connMode = aConfig->phy.masterMode;
    aPhyCntxt->cacheInfo.loopbackMode = ETHXCVR_BOOLEAN_FALSE;
    aPhyCntxt->cacheInfo.jumboMode = aConfig->jumbo;
    aPhyCntxt->cacheInfo.speed = aConfig->speed;
    aPhyCntxt->cacheInfo.flowControl = ETHXCVR_FLOWCONTROL_NONE; /* fixed */
    aPhyCntxt->cacheInfo.sqiValue = 0UL;
    aPhyCntxt->cacheInfo.duplexMode = ETHXCVR_DUPLEXMODE_FULL; /* fixed */
    aPhyCntxt->cacheInfo.localModeState = aConfig->portEnable;
    aPhyCntxt->cacheInfo.tc10Status = 0U;

    DENALIPHY_InitStateHandler(aPhyIdx, aPhyCntxt, aConfig);
    return BCM_ERR_OK;
}

/**
    @brief Deinitialisation

    @code{.c}
    DENALIPHY_DeInitStateHandler(aPhyIdx, aPhyCntxt, aConfig)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_DeInit(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig)
{
    return DENALIPHY_DeInitStateHandler(aPhyIdx, aPhyCntxt, aConfig);
}

/**
    @brief Set Loopback mode configuration

    @code{.c}
    Store Data_Arg1 as aMode
    DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETLOOPBACKMODE)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetLoopbackMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aMode;
    retVal = DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETLOOPBACKMODE);

    return retVal;
}

/**
    @brief Get Loopback mode configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.loopbackMode to aStats
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetLoopbackMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aMode = aPhyCntxt->cacheInfo.loopbackMode;
    }

    return retVal;
}

/**
    @brief Set Jumbo Mode

    @code{.c}
    Store Data_Arg1 as JumboMode
    DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETJUMBOMODE)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetJumboMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode)
{
    int32_t retVal;

    aPhyCntxt->data[DENALIPHY_CNTXT_DATA_ARG1_OFFSET] = aMode;
    retVal = DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_SETJUMBOMODE);

    return retVal;
}

/**
    @brief Set Wakeup Enable Mode

    @anchor BCM_ERR_NOPERM

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aMode          Enabled or Disabled

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_NOPERM    Wake up mode is hardwired and cannot be modified

    @post None

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @limitations None

    @code{.c}
    return BCM_ERR_NOPERM
    @endcode
*/
static int32_t DENALIPHY_SetWakeUpMode(uint8_t aPhyIdx,
                                         ETHXCVR_CntxtType *const aPhyCntxt,
                                         const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOPERM;
}

/**
    @brief Get Wakeup Mode

    This API Responds with Wakeup Mode Enabled or Not
    Get Wakeup Mode will be cached and returns when a request received

    @anchor BCM_ERR_INVAL_PARAMS
    @anchor BCM_ERR_UNINIT
    @anchor BCM_ERR_OK

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aMode          Pointer to read Wakeup Mode feature enable

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_INVAL_PARAMS    aPhyCntxt is NULL
    @retval     #BCM_ERR_UNINIT          Driver is not initialized
    @retval     #BCM_ERR_OK              Job Successfully scheduled

    @post None

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @limitations None

    @code{.c}
    if aPhyCntxt is NULL
        return BCM_ERR_INVAL_PARAMS
    else if drvState is ETHXCVR_STATE_UNINIT
        return BCM_ERR_UNINIT
    else
        Copy aPhyCntxt->cacheInfo.wakeupMode to aMode
    return retVal
    @endcode
*/
static int32_t DENALIPHY_GetWakeUpMode(uint8_t aPhyIdx,
                                         ETHXCVR_CntxtType *const aPhyCntxt,
                                         const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal=BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aMode = aPhyCntxt->cacheInfo.wakeupMode;
    }

    return retVal;
}

/**
    @brief Get Wakeup Reason

    This API Provides wakeup reason if wakeupMode is enabled and wakeup detected
    On Request this API process the cached WakeUp Reason.
    'cacheInfo.localModeState' will be used to store/maintain the Local sleep or wakeup status
    if the localModeState is set to #ETHXCVR_MODE_ACTIVE to report #ETHXCVR_WAKEUPREASON_LOCAL
    if the localModeState is set to #ETHXCVR_MODE_DOWN to report #ETHXCVR_WAKEUPREASON_REMOTE
    if there is no Wakeup Reason then it says #ETHXCVR_WAKEUPREASON_NONE

    @anchor BCM_ERR_INVAL_PARAMS
    @anchor BCM_ERR_INVAL_STATE
    @anchor BCM_ERR_UNINIT
    @anchor BCM_ERR_OK

    @behavior Sync, Non re-entrant

    @pre None

    @param[in]      aPhyIdx        Port index
    @param[in]      aPhyCntxt      Pointer to PHY context structure
    @param[in]      aConfig        Pointer to Configuration
    @param[in]      aReason        Report Wakeup Reason

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_INVAL_PARAMS    aPhyCntxt is NULL
    @retval     #BCM_ERR_INVAL_STATE     Wakeup Mode is not Enabled
    @retval     #BCM_ERR_UNINIT          Driver is not initialized
    @retval     #BCM_ERR_OK              Job Successfully scheduled

    @post None

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL

    @limitations None

    @code{.c}
        if aPhyCntxt is NULL
            return BCM_ERR_INVAL_PARAMS
        else if drvState is ETHXCVR_STATE_UNINIT
            return BCM_ERR_UNINIT
        else if Wakeup Mode is Disabled
            return BCM_ERR_INVAL_STATE
        else
            if There is A WakeUp Reason in aPhyCntxt->cacheInfo.tc10Status AND Port is Awake State
                if  aPhyCntxt->cacheInfo.localModeState is Sleep
                    *aReason is ETHXCVR_WAKEUPREASON_REMOTE
                else
                    *aReason is ETHXCVR_WAKEUPREASON_LOCAL
                set the default Wakeup Reason to sleep
                clear the aPhyCntxt->cacheInfo.tc10Status
            else
               *aReason is ETHXCVR_WAKEUPREASON_NONE
    @endcode

*/
static int32_t DENALIPHY_GetWakeUpReason(uint8_t aPhyIdx,
                                         ETHXCVR_CntxtType *const aPhyCntxt,
                                         const ETHXCVR_PortConfigType *const aConfig,
                                         ETHXCVR_WakeupReasonType *const aReason)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else if (ETHXCVR_BOOLEAN_FALSE == (uint32_t)aPhyCntxt->cacheInfo.wakeupMode) {
        retVal = BCM_ERR_INVAL_STATE;
    } else {
        /* Check Wakeup Pulse received and Port is in AWAKE State */
        if((0U < aPhyCntxt->cacheInfo.tc10Status)
             && (DENALIPHY_TC10STATUS_STANDBYSTATE_MASK != ((DENALIPHY_TC10STATUS_STANDBYSTATE_MASK)
                                                            & (aPhyCntxt->cacheInfo.tc10Status)))) {
            if(ETHXCVR_MODE_DOWN == aPhyCntxt->cacheInfo.localModeState) {
               *aReason = ETHXCVR_WAKEUPREASON_REMOTE;
            } else {
               *aReason = ETHXCVR_WAKEUPREASON_LOCAL;
            }
            aPhyCntxt->cacheInfo.localModeState = ETHXCVR_MODE_DOWN;
            /* Clear the WakeUp Reason */
            aPhyCntxt->cacheInfo.tc10Status =0;
       } else {
           *aReason = ETHXCVR_WAKEUPREASON_NONE;
       }
    }

    return retVal;
}

/**
    @brief Get Jumbo Mode Configuration

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.jumboMode to aMode
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetJumboMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType *const aMode)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        *aMode = aPhyCntxt->cacheInfo.jumboMode;
    }

    return retVal;
}

/**
    @brief Set Autonegotiation Mode

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_SetAutoNegMode(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_OK;
}

/**
    @brief Restart Autonegotiation

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_RestartAutoNeg(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    /* TODO: update this */
    return BCM_ERR_OK;
}

/**
    @brief Get Autonegotiation Status

    @code{.c}
    #if defined(__BCM89559G__)
    If aConfig->phy.slaveID is 1
        Set aStatus as ETHXCVR_AUTONEGSTATUS_INCOMPLETE
    else if aConfig->phy.slaveID is 0
        Set aStatus as ETHXCVR_AUTONEGSTATUS_COMPLETE
    #endif
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetAutoNegStatus(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_AutoNegStatusType *const aStatus)
{
#if defined(__BCM89559G__)
    if (1U == aConfig->phy.slaveID) {
        *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
    } else if (0U == aConfig->phy.slaveID) {
        *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
    }
#endif
    return BCM_ERR_OK;
}

/**
    @brief Get Statistics

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_UNINIT if drvState is ETHXCVR_STATE_UNINIT
    Copy aPhyCntxt->cacheInfo.stats to aStats
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_GetStats(uint8_t aPhyIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_StatsType *const aStats)
{
    int32_t retVal = BCM_ERR_OK;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (ETHXCVR_STATE_UNINIT == aPhyCntxt->drvState) {
        retVal = BCM_ERR_UNINIT;
    } else {
        BCM_MemCpy(aStats, &(aPhyCntxt->cacheInfo.stats),
                sizeof(ETHXCVR_StatsType));
    }

    return retVal;
}

/**
    @brief State Handler

    @code{.c}
    return BCM_ERR_INVAL_PARAMS if aPhyCntxt is NULL
    return BCM_ERR_OK if JobType is DENALIPHY_JOB_NONE
    Call DENALIPHY_IntStateHandler()
    If return value is not any of BCM_ERR_OK, BCM_ERR_BUSY & BCM_ERR_EAGAIN
        Log Error through DENALIPHY_ReportError()
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_StateHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    uint32_t *const aIsModeChanged,
                                    ETHXCVR_ModeType *const aMode)
{
    int32_t retVal;

    if (NULL == aPhyCntxt) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }

    if (DENALIPHY_JOB_NONE == aPhyCntxt->data[DENALIPHY_CNTXT_DATA_JOBTYPE_OFFSET]) {
        retVal = BCM_ERR_OK;
        goto err;
    }

    retVal = DENALIPHY_IntStateHandler(aPhyIdx, aPhyCntxt, aConfig,
            aIsModeChanged, aMode);

    if ((BCM_ERR_OK != retVal) && (BCM_ERR_BUSY != retVal)
            && (BCM_ERR_EAGAIN != retVal)) {
        DENALIPHY_ReportError(aPhyIdx, BRCM_SWDSGN_DENALIPHY_STATEHANDLER_PROC,
                retVal, 0UL, 0UL, 0UL,(uint32_t)__LINE__);
    }

err:
    return retVal;
}

/**
    @brief Update Hardware Status

    @code{.c}
    DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig, DENALIPHY_JOB_UPDATEHWSTATUS)
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_UpdateHWStatus(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    /* DENALIPHY_CNTXT_DATA_ARG1_OFFSET is used to cache jumboMode temporarily */
    return DENALIPHY_QueueJob(aPhyIdx, aPhyCntxt, aConfig,
            DENALIPHY_JOB_UPDATEHWSTATUS);
}

/**
    @brief Link IRQ Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_LinkIRQHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_OK;
}

/**
    @brief Link Change Indication Handler

    @code{.c}
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
static int32_t DENALIPHY_LinkChangeIndHandler(uint8_t aPhyIdx,
                                    ETHXCVR_CntxtType *const aPhyCntxt,
                                    const ETHXCVR_PortConfigType *const aConfig,
                                    ETHXCVR_LinkStateType *const aLinkState,
                                    uint32_t *const aIsLinkStateChanged)
{
    return BCM_ERR_OK;
}

/**
    @trace #BRCM_SWARCH_DENALIPHY_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_DENALIPHY_FUNCTBL
*/
const ETHXCVR_FuncTblType DENALIPHY_FuncTbl = {
    .init = DENALIPHY_Init,
    .deinit = DENALIPHY_DeInit,
    .reset = DENALIPHY_Reset,
    .setMode = DENALIPHY_SetMode,
    .getMode = DENALIPHY_GetMode,
    .setMasterMode = DENALIPHY_SetMasterMode,
    .getMasterMode = DENALIPHY_GetMasterMode,
    .getSpeed = DENALIPHY_GetSpeed,
    .setSpeed = DENALIPHY_SetSpeed,
    .getDuplexMode = DENALIPHY_GetDuplexMode,
    .setDuplexMode = DENALIPHY_SetDuplexMode,
    .setFlowControl = DENALIPHY_SetFlowControl,
    .getFlowControl = DENALIPHY_GetFlowControl,
    .getLinkState = DENALIPHY_GetLinkState,
    .getSQIValue = DENALIPHY_GetSQIValue,
    .setLoopbackMode = DENALIPHY_SetLoopbackMode,
    .getLoopbackMode = DENALIPHY_GetLoopbackMode,
    .setJumboMode = DENALIPHY_SetJumboMode,
    .getJumboMode = DENALIPHY_GetJumboMode,
    .setWakeUpMode = DENALIPHY_SetWakeUpMode,
    .getWakeUpMode = DENALIPHY_GetWakeUpMode,
    .getWakeUpReason = DENALIPHY_GetWakeUpReason,
    .setAutoNegMode = DENALIPHY_SetAutoNegMode,
    .getAutoNegStatus = DENALIPHY_GetAutoNegStatus,
    .restartAutoNeg = DENALIPHY_RestartAutoNeg,
    .getStats = DENALIPHY_GetStats,
    .stateHandler = DENALIPHY_StateHandler,
    .updateHWStatus = DENALIPHY_UpdateHWStatus,
    .linkChangeIndHandler = DENALIPHY_LinkChangeIndHandler,
    .linkIRQHandler  = DENALIPHY_LinkIRQHandler,
};

/** @} */
