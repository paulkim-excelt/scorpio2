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

/**
    @defgroup grp_system_notification_impl Subsystem Notifications
    @ingroup grp_sys_service

    @addtogroup grp_system_notification_impl
    @{

    @file system_osil.c
    @brief Subsystem Notifications Implementation

    @version 0.1 Initial version
*/

#include <system.h>
#include <msg_queue.h>
#include <bcm_err.h>
#include <stdlib.h>
#include "ee.h"
#include <osil/system_osil.h>
#include <osil/bcm_osil.h>
#include <osil/module_osil.h>

/**
    @name Subsystem Notificaiton Design IDs
    @{
    @brief Design IDs for Subsystem Notificaiton

*/
#define BRCM_SWDSGN_SYS_CONTEXT_GLOBAL              (0xA101U)    /**< @brief #COMP_Context           */
#define BRCM_SWDSGN_SYS_FUNCTION_PART_PROC          (0xA102U)    /**< @brief #COMP_FunctionPart      */
#define BRCM_SWDSGN_SYS_FUNCTION_PROC               (0xA103U)    /**< @brief #COMP_Function          */
#define BRCM_SWDSGN_SYS_INT_STATE_MACRO             (0xA104U)    /**< @brief #COMP_IntStateType      */
#define BRCM_SWDSGN_SYS_CONTEXT_DEFINE_MACRO        (0xA105U)    /**< @brief #COMP_CONTEXT_DEFINE    */
#define BRCM_SWDSGN_SYS_INTCONTEXT_TYPE             (0xA106U)    /**< @brief #COMP_IntContextType    */
#define BRCM_SWDSGN_SYS_INTCONTEXT_GLOBAL           (0xA107U)    /**< @brief #COMP_IntContext        */
#define BRCM_SWDSGN_SYS_SUBMODEVENT_GLOBAL          (0xA108U)    /**< @brief #SYS_SubModEvent        */
#define BRCM_SWDSGN_SYSTEM_REBOOTEVENT_GLOBAL       (0xA10BU)    /**< @brief #SYSTEM_RebootEvent     */
#define BRCM_SWDSGN_SYS_REBOOT_TIMER_EXP_GLOBAL     (0xA10CU)    /**< @brief #SYS_RebootTimerExpired */
#define BRCM_SWDSGN_SYS_TRIGGER_REBOOT_GLOBAL       (0xA10DU)    /**< @brief #SYS_TriggerReboot      */
#define BRCM_SWDSGN_SYS_REBOOT_MODE_GLOBAL          (0xA10EU)    /**< @brief #SYS_RebootMode         */
#define BRCM_SWDSGN_SYS_SET_REBOOT_ALARM_CB_PROC    (0xA10FU)    /**< @brief #SYS_REBOOT_AlarmCb     */
#define BRCM_SWDSGN_SYS_SET_REBOOT_COUNTER_PROC     (0xA110U)    /**< @brief #SYS_SetRebootCounter   */

/** @} */

/*TODO: ENABLE_SYSTEM_MODULES MACRO Can be replaced with ENABLE_NVM and other than SYS_SubModEvent can be removed */
#if defined(ENABLE_SYSTEM_MODULES)
/**
    @brief Global to translate the OS event to U32 for SYS Module
    operation

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
const uint32_t SYS_SubModEvent = SYS_NOTIF_EVENT;

/**
    @brief Global to translate the OS event to U32 for Reboot Event

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
const uint32_t SYSTEM_RebootEvent = SYS_REBOOT_EVENT;

/**
    @brief Global to be set when reboot delay count expired

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
uint32_t SYS_RebootTimerExpired = FALSE;

/**
    @brief Global to be set to trigger reboot

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
uint32_t SYS_TriggerReboot = FALSE;

#endif

/**
    @brief Global context for COMP_Context

    Detailed description of the GComp_Context

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
typedef struct sSYS_ErrorNotifType {
    BCM_GroupIDType groupID;
    BCM_CompIDType compID;
    int32_t error;
} SYS_ErrorNotifType;

/**
    @brief Global context for COMP_Context

    Detailed description of the GComp_Context

    @anchor COMP_Context
    @trace #BRCM_SWARCH_COMP_CONTEXT_TYPE
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY
*/
SYS_ErrorNotifType SYS_ErrorNotif[MSGQ_SIZE];

/**
    @brief Get the i-th message from server

    Retrieve the i-th message from server.

    @behavior Sync, non-reentrant

    @pre None

    @param[in]  idx         Index of the message

    @return                 Pointer to the i-th message

    @post None

    @note To be used.

    @trace #TBD

    @limitations None
*/
void* SYS_GetNotif(uint32_t idx)
{
    void* pRet = NULL;

    if (idx < MSGQ_SIZE) {
        pRet = (void *)(&SYS_ErrorNotif[idx]);
    }
    return pRet;
}

/**
    @brief #MSGQ_HdrQType instance of SYS command message queue

    This macro shall be used by the message queue server to initialize an
    instance of #MSGQ_HdrQType.

    @trace #TBD
 */
MSGQ_DEFINE_HDRQ(SYS_NotifHdrQ);

/**
    @brief Command Message Queue

    The message queue for the events notified to switch. System task
    processes them asynchronously.

    @trace #TBD
*/
MSGQ_DEFINE((SYS_NotifQ), (SYS_TASK_NAME), (SYS_NOTIF_EVENT),
            (MSGQ_CLIENT_SIGNAL_DISABLE), SYS_ErrorNotifType, (&SYS_NotifHdrQ),
            (SYS_GetNotif));

static int32_t SYS_SendErrNotification(BCM_GroupIDType aSenderGroupID,
                                       BCM_CompIDType aSenderCompID,
                                       int32_t aError)
{
    SYS_ErrorNotifType notif;
    notif.groupID = aSenderGroupID;
    notif.compID = aSenderCompID;
    notif.error = aError;
    return MSGQ_SendMsg(&SYS_NotifQ, &notif, MSGQ_NO_CLIENTMASK, NULL);
}

const SYS_FnTblType SYS_FnTable =
{
    .parentGroupID = BCM_GROUPID_INVALID,
    .parentCompID = BCM_RSV_ID,
    .groupID = BCM_GROUPID_SYS,
    .compID = BCM_SYS_ID,
    .sendCmd = NULL,
    .recvResp = NULL,
    .getState = NULL,
    .notifyError = SYS_SendErrNotification,
};
/** @} */

/**
    @addtogroup grp_system_il
    @{
*/

/**
    This function could further check the task ID which is calling this API and Is the task
    expected to raise this notification, in future.

    @trace #BRCM_SWARCH_COMP_FUNCTION_PROC
    @trace #BRCM_SWREQ_COMP_FUNCTIONALITY

    @code{.c}
    ret = ERR_OK
    if Arguments are NULL
        ret = ERR_INVAL_PARAMS
    else if state is not COMP_STATE1
        ret = ERR_INVAL_STATE
    else
        ret = COMP_FunctionPart
    return ret
    @endcode
*/
void SYS_ClearNotification(void)
{
    int32_t retVal;
    do {
        uint32_t idx = 0UL;
        retVal = MSGQ_GetMsgIdx(&SYS_NotifQ, &idx);
        if (BCM_ERR_OK == retVal) {
            retVal = MSGQ_CompleteMsgIdx(&SYS_NotifQ, idx);
        }
    } while (BCM_ERR_OK == retVal);
}


/** @} */
