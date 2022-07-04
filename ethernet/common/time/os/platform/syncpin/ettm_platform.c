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
    @defgroup grp_ethsrv_time_platform_syncpin Ethtime module platform for chips using Sync in/out pin
    @ingroup grp_ethsrv_time

    @addtogroup grp_ethsrv_time_platform_syncpin
    @{

    @section grp_ethsrv_time_platform_syncpin_ttm_state TTM state Table

    @anchor ETTM_StateType_Table
    |   Present State            |        Next State          | Pass/Fail      |                         Details                                           |
    |:--------------------------:|:--------------------------:|:--------------:|:-------------------------------------------------------------------------:|
    | BCM_STATE_SUB_STATE_STAGE0 | BCM_STATE_SUB_STATE_STAGE1 |      Pass      |  Sync prepare message sent successfully to slave                          |
    | BCM_STATE_SUB_STATE_STAGE1 | BCM_STATE_SUB_STATE_STAGE2 |      Pass      |  Got Prepare sync response from slave successfully                        |
    | BCM_STATE_SUB_STATE_STAGE1 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Prepare sync failed on slave                                             |
    | BCM_STATE_SUB_STATE_STAGE2 | BCM_STATE_SUB_STATE_STAGE3 |      Pass      |  Sent Prepare heart beat read command to slave successfully               |
    | BCM_STATE_SUB_STATE_STAGE2 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Fail to send prepare heart beat read command to slave                    |
    | BCM_STATE_SUB_STATE_STAGE3 | BCM_STATE_SUB_STATE_STAGE4 |      Pass      |  Got Prepare HB read response from slave successfully                     |
    | BCM_STATE_SUB_STATE_STAGE3 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Prepare HB failed on slave                                               |
    | BCM_STATE_SUB_STATE_STAGE4 | BCM_STATE_SUB_STATE_STAGE5 |      Pass      |  Sent heart beat read message to slave successfully                       |
    | BCM_STATE_SUB_STATE_STAGE4 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Fail to send heart beat read command to slave                            |
    | BCM_STATE_SUB_STATE_STAGE5 | BCM_STATE_SUB_STATE_STAGE6 |      Pass      |  Got HB read response from slave, and master and slave HB matches         |
    | BCM_STATE_SUB_STATE_STAGE5 | BCM_STATE_SUB_STATE_STAGE0 |      Pass      |  Got HB read response from slave, but master and slave HB doesnot matches |
    | BCM_STATE_SUB_STATE_STAGE5 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  HB read fialed on slave or HB reach maximum retry limit reached          |
    | BCM_STATE_SUB_STATE_STAGE6 | BCM_STATE_SUB_STATE_STAGE7 |      Pass      |  Sent time sync ack message to slave successfully                         |
    | BCM_STATE_SUB_STATE_STAGE6 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Fail to send time sync ack command to slave                              |
    | BCM_STATE_SUB_STATE_STAGE7 | BCM_STATE_SUB_STATE_DONE   |      Pass      |  Got time sync ack response from slave successfully                       |
    | BCM_STATE_SUB_STATE_STAGE7 | BCM_STATE_SUB_STATE_RESET  |      Fail      |  Time sync ack command failed on slave                                    |
    | BCM_STATE_SUB_STATE_DONE   |                            |      XXXX      |                                                                           |
    | BCM_STATE_SUB_STATE_RESET  |                            |      XXXX      |                                                                           |

    @file ettm_platform.c
    @brief This file implements platform layer for Sync pin

    @version 0.1 Initial draft
*/

#include <bcm_err.h>
#include <ettm.h>
#include <ettm_platform.h>
#include <mcu.h>
#ifdef ENABLE_ETHUTILS_STACKING
#include <rpc_local_osil.h>
#include <bcm_time.h>
#include <bcm_utils.h>
#include <eth_osil.h>
#include <ettm_osil.h>
#include <mcu_switch_ext.h>
#endif
#include <rpc_local_osil.h>

/**
    @name Ethernet time module OSIL Design IDs
    @{
    @brief Design IDs for Ethernet time module OSIL
*/
#define BRCM_SWDSGN_ETTM_CONFIG_GLOBAL              (0xB401U)    /**< @brief #ETTM_Config            */
#define BRCM_SWDSGN_ETTM_MAX_SYNC_PULSES_MACRO      (0xB402U)    /**< @brief #ETTM_MAX_SYNC_PULSES   */
#define BRCM_SWDSGN_ETTM_MAX_HB_DIFFERENCE_MACRO    (0xB403U)    /**< @brief #ETTM_MAX_HB_DIFFERENCE */
#define BRCM_SWDSGN_ETTM_ERRORREPORT_PROC           (0xB404U)    /**< @brief #ETTM_ErrorReport       */
#define BRCM_SWDSGN_ETTM_PLATFORMINITNONE_PROC      (0xB405U)    /**< @brief #ETTM_PlatformInitNone  */
#define BRCM_SWDSGN_ETTM_PLATFORMSYNCSLAVE_PROC     (0xB407U)    /**< @brief #ETTM_PlatformSyncSlave */
#define BRCM_SWDSGN_ETTM_VALIDATE1588SYNC_PROC      (0xB408U)    /**< @brief #ETTM_Validate1588Sync  */
#define BRCM_SWDSGN_ETTM_GENINTERNALSYNC_PROC       (0xB409U)    /**< @brief #ETTM_GenInternalSync   */
#define BRCM_SWDSGN_ETTM_PLATFORMMERGEHB_PROC       (0xB40AU)    /**< @brief #ETTM_PlatformMergeHB   */
#define BRCM_SWDSGN_ETTM_TIMESTATE_TYPE             (0xB40BU)    /**< @brief #ETTM_StateType   */
/** @} */

/**
    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_GLOBAL
*/
const ETHER_TimeCfgType ETTM_Config = {
    .hwIdx = 0UL,
    .portEnableMask = 0x1FFUL,
    .sync = ETTM_TIMESYNC_MODE,
};

#ifdef ENABLE_ETHUTILS_STACKING

/**
    @brief Macro for maximum number of times framesync is to be (re)tried
    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

*/
#define ETTM_MAX_SYNC_PULSES   (8U)

/**
    @brief Macro for maximum allowed difference (in nanoseconds)
    between heartbeat messages
    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

*/
#define ETTM_MAX_HB_DIFFERENCE (16ULL)

/**
    @name ETTM state
    @{
    @brief ETTM time sync state transition table

    Please refer @ref ETTM_StateType_Table

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC
*/
typedef uint32_t ETTM_StateType;                                               /**< @brief ETTM system states */
#define ETTM_TIMESTATE_INVALID_STATE              (BCM_STATE_SUB_STATE_RESET)   /**< @brief Invalid state */
#define ETTM_TIMESTATE_INIT0_DONE                 (BCM_STATE_SUB_STATE_STAGE0)  /**< @brief Send prep sync command to slave */
#define ETTM_TIMESTATE_WAITING_SYNC_PREP_RESP     (BCM_STATE_SUB_STATE_STAGE1)  /**< @brief Wait prep sync response from slave */
#define ETTM_TIMESTATE_SYNC_PREP_DONE             (BCM_STATE_SUB_STATE_STAGE2)  /**< @brief Send prep HB read command to slave */
#define ETTM_TIMESTATE_WAITING_HB_READ_PREP_RESP  (BCM_STATE_SUB_STATE_STAGE3)  /**< @brief Wait prep HB read response from slave */
#define ETTM_TIMESTATE_PREP_HB_READ_DONE          (BCM_STATE_SUB_STATE_STAGE4)  /**< @brief Send HB read command to slave */
#define ETTM_TIMESTATE_WAITING_HB_READ_RESP       (BCM_STATE_SUB_STATE_STAGE5)  /**< @brief Wait HB read response from slave */
#define ETTM_TIMESTATE_READ_HB_DONE               (BCM_STATE_SUB_STATE_STAGE6)  /**< @brief Send time sync ack command to slave */
#define ETTM_TIMESTATE_WAITING_TIMESYNC_ACK_RESP  (BCM_STATE_SUB_STATE_STAGE7)  /**< @brief Wait time sync ack response from slave */
#define ETTM_TIMESTATE_INIT1_DONE                 (BCM_STATE_SUB_STATE_DONE)    /**< @brief Initialization complete */
/** @} */


/**
    @brief Error reporting API

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

    @code{.unparsed}
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3}
    BCM_ReportError((BCM_ETH_ID & BCM_LOGMASK_USER), 0U, aApiID,
                    aErr, 4UL, values)
    @endcode
 */
static void ETTM_ErrorReport(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                             uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_ETT_ID & BCM_LOGMASK_USER), 0U, aApiID,
                    aErr, 4UL, values);
}

/**
    API used to generate Pulse to sync heart beat.

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

    @code{.unparsed}
    @endcode
*/
static void ETTM_GenInternalSync(void)
{
    MCU_Gen1588SyncPulse();
}

/**
    API checks heart beat of the master and slave
    devices and ascertain if synchronisation has been achieved.

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

    @code{.unparsed}
    @endcode
*/
static int32_t ETTM_Validate1588Sync(const uint8_t *const aPayload)
{
    int32_t                    retVal = BCM_ERR_OK;
    ETTM_HeartBeatType mergedHb;

    BCM_MemCpy(&mergedHb, aPayload, sizeof(ETTM_HeartBeatType));
    if ((mergedHb.hb1 - mergedHb.hb0) > ETTM_MAX_HB_DIFFERENCE) {
        retVal = BCM_ERR_EAGAIN;
    }
    return retVal;
}
#endif /* ENABLE_ETHUTILS_STACKING */

/**
    API used to sync the heart beat of MCM Slave device.

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

    @code{.unparsed}
    @endcode
*/
void ETTM_PlatformSyncSlave(ETTM_ContextType *const aContext)
{
#ifdef ENABLE_ETHUTILS_STACKING
    int32_t                      retVal;
    int32_t                      status = BCM_ERR_OK;
    uint32_t                     size = 0UL;
    ETHER_TimeInitOutType        timeOut;
    MCU_InfoType                 stackingInfo = {0U};
    ETTM_HeartBeatType   masterHb;
    ETTM_HeartBeatType   slaveHb;
    ETTM_HeartBeatType   mergedHb;
    BCM_SubStateType     prevState;

    retVal = MCU_GetInfo(&stackingInfo);
    /* This unified list is managed at Master */
    if ((BCM_ERR_OK == retVal) &&
        (1U == stackingInfo.stackingEn) &&
        (MCU_DEVICE_MASTER == stackingInfo.mstSlvMode)) {
        do {
                prevState = aContext->moduleContext.subState;
                switch (aContext->moduleContext.subState) {
                    case BCM_STATE_SUB_STATE_STAGE0:
                        /* Send sync prepare message to slave */
                        retVal =  RPC_SlaveSendLocalCmd(BCM_GROUPID_ETHSRV, BCM_ETT_ID,
                                                 ETTM_CMDID_PREPARE_SYNC,
                                                 NULL,
                                                 0UL, 0UL,
                                                 ETTM_EventInfo.masterFrmSyncEvent,
                                                 &aContext->pHdrSlave);
                        if (BCM_ERR_OK == retVal) {
                            /* Wait prep sync response from slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE1;
                        } else {
                            retVal = BCM_ERR_BUSY;
                            /* wait in the same state until slave is ready don't throw error */
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE1:
                        /* Prepare sync response from slave*/
                        retVal =  RPC_SlaveGetLocalResp(aContext->pHdrSlave, &status,
                                                      NULL,
                                                      NULL);
                        if (BCM_ERR_OK != retVal) {
                            if (BCM_ERR_BUSY == retVal) {
                                /* Wait in this state and try again */
                            }
                        } else if (BCM_ERR_OK == status) {
                            /* Send sync prepare message to master */
                            ETHER_TimeInitStateHandler(ETHER_HW_ID_0,
                                                       ETHER_TIMEINITCMD_PREP_SYNC,
                                                       0ULL, NULL);
                            /* Send prep HB read command to slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE2;
                        } else {
                            /* ETTM_CMDID_PREPARE_SYNC command failed on slave */
                            retVal = status;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE2:
                        /* Send Prepare heart beat read command to slave */
                        ETTM_GenInternalSync();
                        retVal =  RPC_SlaveSendLocalCmd(BCM_GROUPID_ETHSRV, BCM_ETT_ID,
                                                 ETTM_CMDID_PREPARE_HEARTBEAT_READ,
                                                 NULL,
                                                 0UL, 0UL,
                                                 ETTM_EventInfo.masterFrmSyncEvent,
                                                 &aContext->pHdrSlave);
                        if (BCM_ERR_OK == retVal) {
                            /* Wait prep HB read response from slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE3;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE3:
                        /* Prepare HB read response from slave */
                        retVal =  RPC_SlaveGetLocalResp(aContext->pHdrSlave, &status,
                                                      NULL,
                                                      NULL);
                        if (BCM_ERR_OK != retVal) {
                            if (BCM_ERR_BUSY == retVal) {
                                /* Wait in this state and try again */
                            }
                        } else if (BCM_ERR_OK == status) {
                            /* Send Prepare heart beat read command to master */
                            ETHER_TimeInitStateHandler(ETHER_HW_ID_0,
                                                       ETHER_TIMEINITCMD_PREP_HB_READ,
                                                       0ULL, NULL);
                            /* Send HB read command to slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE4;
                            /* Generate sync pulse */
                            ETTM_GenInternalSync();
                        } else {
                            /* Prepare heart beat read command failed on slave */
                            retVal = status;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE4:
                        /* Send heart beat read message to slave */
                        retVal =  RPC_SlaveSendLocalCmd(BCM_GROUPID_ETHSRV, BCM_ETT_ID,
                                                 ETTM_CMDID_HEARTBEAT_GET,
                                                 aContext->payload,
                                                 sizeof(ETTM_HeartBeatType), 0UL,
                                                 ETTM_EventInfo.masterFrmSyncEvent,
                                                 &aContext->pHdrSlave);
                        if (BCM_ERR_OK == retVal) {
                            /* Wait HB read response from slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE5;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE5:
                        /* HB read response from slave */
                        retVal =  RPC_SlaveGetLocalResp(aContext->pHdrSlave, &status,
                                                      aContext->payload,
                                                      &size);
                        if (BCM_ERR_OK != retVal) {
                            if (BCM_ERR_BUSY == retVal) {
                                /* Wait in this state and try again */
                            }
                        } else if ((BCM_ERR_OK == status) && (size == sizeof(ETTM_HeartBeatType))) {
                            ETHER_TimeInitStateHandler(ETHER_HW_ID_0,
                                                       ETHER_TIMEINITCMD_GET_HB,
                                                       0ULL, &timeOut);
                            masterHb.hb0 =            (((uint64_t)timeOut.heartBeat0[3] << 48U) |
                                                      ((uint64_t)timeOut.heartBeat0[2] << 32U) |
                                                      ((uint64_t)timeOut.heartBeat0[1] << 16U) |
                                                      ((uint64_t)timeOut.heartBeat0[0] << 0U));
                            masterHb.hb1 =            (((uint64_t)timeOut.heartBeat1[3] << 48U) |
                                                      ((uint64_t)timeOut.heartBeat1[2] << 32U) |
                                                      ((uint64_t)timeOut.heartBeat1[1] << 16U) |
                                                      ((uint64_t)timeOut.heartBeat1[0] << 0U));

                            BCM_MemCpy(&slaveHb, aContext->payload, sizeof(ETTM_HeartBeatType));
                            aContext->hbReadCnt++;
                            retVal = ETTM_PlatformMergeHB(&masterHb, &slaveHb, &mergedHb);
                            if (BCM_ERR_OK == retVal) {
                                retVal = ETTM_Validate1588Sync(aContext->payload);
                            }
                            if(BCM_ERR_OK == retVal) {
                                /* Send time sync ack command to slave */
                                aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE6;
                                aContext->hbReadCnt = 0U;
                            } else if(aContext->hbReadCnt >= ETTM_MAX_SYNC_PULSES) {
                                /* We report the error and then let SDK boot mormally */
                                ETTM_ErrorReport(BRCM_SWDSGN_ETTM_PLATFORMSYNCSLAVE_PROC,
                                        BCM_ERR_MAX_ATTEMPS, __LINE__, aContext->moduleContext.subState,
                                        0UL,
                                        (uint32_t)aContext->hbReadCnt);
                                aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE6;
                                retVal = BCM_ERR_OK;
                            } else {
                                /* Retry and generate sync pulse */
                                aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE0;
                                retVal = BCM_ERR_EAGAIN;
                            }
                        } else {
                            /* Heart beat read command failed on slave */
                            retVal = status;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE6:
                        /* Send time sync ack message to slave */
                        retVal =  RPC_SlaveSendLocalCmd(BCM_GROUPID_ETHSRV, BCM_ETT_ID,
                                                 ETTM_CMDID_TIMESYNC_ACK,
                                                 NULL,
                                                 0UL, 0UL,
                                                 ETTM_EventInfo.masterFrmSyncEvent,
                                                 &aContext->pHdrSlave);
                        if (BCM_ERR_OK == retVal) {
                            /* Wait time sync ack response from slave */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_STAGE7;
                        }
                        break;
                    case BCM_STATE_SUB_STATE_STAGE7:
                        /* time sync ack response from slave */
                        retVal =  RPC_SlaveGetLocalResp(aContext->pHdrSlave, &status,
                                                      NULL,
                                                      NULL);
                        if (BCM_ERR_OK != retVal) {
                            if (BCM_ERR_BUSY == retVal) {
                                /* Wait in this state and try again */
                            }
                            break;
                        } else if (BCM_ERR_OK == status) {
                            /* Send time sync ack message to master */
                            ETHER_TimeInitStateHandler(ETHER_HW_ID_0,
                                    ETHER_TIMEINITCMD_1, 0ULL, NULL);
                            ETHER_TimeInitStateHandler(ETHER_HW_ID_0, ETHER_TIMEINITCMD_2, 0ULL, NULL);
                            /* Initialization complete */
                            aContext->moduleContext.subState = BCM_STATE_SUB_STATE_DONE;
                            aContext->frameSyncDone = TRUE;
                        } else {
                            /* ETTM_CMDID_TIMESYNC_ACK command failed on slave */
                            retVal = status;
                            break;
                        }
                        break;
                    default:
                        break;
                }

            if ((BCM_ERR_OK != retVal)    &&
                (BCM_ERR_BUSY != retVal)  &&
                (BCM_ERR_EAGAIN != retVal)) {
                ETTM_ErrorReport(BRCM_SWDSGN_ETTM_PLATFORMSYNCSLAVE_PROC,
                                  retVal, __LINE__, aContext->moduleContext.subState,
                                  0UL,
                                  (uint32_t)aContext->hbReadCnt);
                aContext->moduleContext.subState = BCM_STATE_SUB_STATE_RESET;
                aContext->hbReadCnt = 0U;
                /* Exit the loop on error */
                break;
            }
        } while (aContext->moduleContext.subState != prevState);
    }
#endif /* ENABLE_ETHUTILS_STACKING */
}

/**
    @trace #BRCM_SWARCH_ETTM_PLATFORMINITNONE_PROC
    @trace #BRCM_SWREQ_ETTM_SYNCPIN
*/
void ETTM_PlatformInitNone(uint64_t *const aTimeDiff)
{
}

/**
    API merge the heartbeat of master/slave and slave.

    @trace #BRCM_SWREQ_ETTM_SYNCPIN
    @trace #BRCM_SWARCH_ETTM_PLATFORMSYNCSLAVE_PROC

    @code{.unparsed}
    @endcode
*/
int32_t ETTM_PlatformMergeHB(void const *aInResponse1,
                             void const *aInResponse2,
                             void *aOutResponse)
{
    int32_t                  retVal = BCM_ERR_OK;
#ifdef ENABLE_ETHUTILS_STACKING
    ETTM_PayloadType ptr1;
    ETTM_PayloadType ptr2;
    ETTM_PayloadType outPtr;
    uint64_t                 hbMin = ~(0ULL);
    uint64_t                 hbMax = 0ULL;

    if ((NULL == aOutResponse) ||
        (NULL == aInResponse1) ||
        (NULL == aInResponse2)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto error;
    }
    ptr1.u8ConstPtr = (const uint8_t *)aInResponse1;
    ptr2.u8ConstPtr = (const uint8_t *)aInResponse2;
    outPtr.u8Ptr = (uint8_t *)aOutResponse;
    hbMin = BCM_MIN(hbMin, ptr1.heartBeat->hb0);
    hbMin = BCM_MIN(hbMin, ptr1.heartBeat->hb1);
    hbMin = BCM_MIN(hbMin, ptr2.heartBeat->hb0);
    hbMin = BCM_MIN(hbMin, ptr2.heartBeat->hb1);

    ETTM_ErrorReport(BRCM_SWDSGN_ETTM_PLATFORMMERGEHB_PROC, retVal,
                             (uint32_t)ptr1.heartBeat->hb0,
                             (uint32_t)ptr1.heartBeat->hb1,
                             (uint32_t)ptr2.heartBeat->hb0,
                             (uint32_t)ptr2.heartBeat->hb1);

    /* If any of the timestamps is 0, it would lead to hbMin being set to 0 */
    /* This indicates that the framesync pulse is not reaching the block.   */
    /* Mostly this should be a DIP switch problem on the board              */
    if (0ULL == hbMin) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto error;
    }

    hbMax = BCM_MAX(hbMax, ptr1.heartBeat->hb0);
    hbMax = BCM_MAX(hbMax, ptr1.heartBeat->hb1);
    hbMax = BCM_MAX(hbMax, ptr2.heartBeat->hb0);
    hbMax = BCM_MAX(hbMax, ptr2.heartBeat->hb1);
    outPtr.heartBeat->hb0 = hbMin;
    outPtr.heartBeat->hb1 = hbMax;
error:
#endif
    return retVal;
}

/** @} */
