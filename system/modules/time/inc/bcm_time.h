/*****************************************************************************
 Copyright 2017-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_time_utils_ifc Time Utilities
    @ingroup grp_time_utils

    @addtogroup grp_time_utils_ifc
    @{
    This section describes the various time related utility APIs.

    @file bcm_time.h
    @brief Time related APIs

    This file specifies various time related APIs.

    @version 1.3 Import comments from docx
*/

#ifndef BCM_TIME_H
#define BCM_TIME_H

#include <inttypes.h>

/**
    @name BCM Time Utils Architecture IDs
    @{
    @brief Architecture IDs for BCM Time Utils
*/
#define BRCM_SWARCH_BCM_NS_TO_MS_MACRO             (0x8101U)    /**< @brief #BCM_NS_TO_MS           */
#define BRCM_SWARCH_BCM_NS_PER_SEC_MACRO           (0x8102U)    /**< @brief #BCM_NS_PER_SEC         */
#define BRCM_SWARCH_BCM_TIME_TYPE                  (0x8103U)    /**< @brief #BCM_TimeType           */
#define BRCM_SWARCH_BCM_GETSYSTEMTIME_PROC         (0x8104U)    /**< @brief #BCM_GetSystemTime      */
#define BRCM_SWARCH_BCM_GETTIME_PROC               (0x8105U)    /**< @brief #BCM_GetTime            */
#define BRCM_SWARCH_BCM_GETTIMEABSDIFF_PROC        (0x8106U)    /**< @brief #BCM_GetTimeAbsDiff     */
#define BRCM_SWARCH_BCM_DELAYNS_PROC               (0x8107U)    /**< @brief #BCM_DelayNs            */
#define BRCM_SWARCH_BCM_DELAYUS_PROC               (0x8108U)    /**< @brief #BCM_DelayUs            */
#define BRCM_SWARCH_BCM_GETTIMENS_PROC             (0x8109U)    /**< @brief #BCM_GetTimeNs          */
#define BRCM_SWARCH_BCM_GETSYSTEMTIMENS_PROC       (0x810AU)    /**< @brief #BCM_GetSystemTimeNs    */
#define BRCM_SWARCH_BCM_SYSTEMHRTIMERSTART_PROC    (0x810BU)    /**< @brief #BCM_SystemHRTimerStart */
#define BRCM_SWARCH_BCM_SYSTEMHRTIMERSTOP_PROC     (0x810CU)    /**< @brief #BCM_SystemHRTimerStop  */
#define BRCM_SWARCH_BCM_SEC_TO_MS_MACRO            (0x810DU)    /**< @brief #BCM_SEC_TO_MS          */
/** @} */


/**
    @brief Nanoseconds to milliseconds

    @trace #BRCM_SWREQ_BCM_TIME
*/
#define BCM_NS_TO_MS(ns)     ((ns) / 1000000ULL)

/**
    @brief Nanoseconds per second

    @trace #BRCM_SWREQ_BCM_TIME
*/
#define BCM_NS_PER_SEC      (1000000000UL)

/**
    @brief Second to Millisecond

    @trace #BRCM_SWREQ_BCM_TIME
*/
#define BCM_SEC_TO_MS(x)    (1000UL * (x))

/**
    @brief Type for time structure

    @trace #BRCM_SWREQ_BCM_TIME
*/
typedef struct sBCM_TimeType {
    uint32_t s;         /**< @brief Seconds */
    uint32_t ns;        /**< @brief Nano seconds */
} BCM_TimeType;

/** @brief Get the current system time

    This API obtains the current system time privileged context

    @behavior Sync, Re-entrant

    @pre None

    @param[out]  aTime       Pointer to Time structure

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations This API shall only be called from privileged context.
*/
extern void BCM_GetSystemTime(BCM_TimeType * const aTime);

/** @brief Get the current system time

    This API obtains the current system time from unprivileged context

    @behavior Sync, Re-entrant

    @pre None

    @param[out]  aTime       Pointer to Time structure

    @retval     void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations This API shall only be called from unprivileged context.
*/
extern void BCM_GetTime(BCM_TimeType * const aTime);

/** @brief Get the current system time in nanoseconds

    This API obtains the current system time from unprivileged context

    @behavior Sync, Re-entrant

    @pre None

    @param void

    @retval     aTimeInNs       Pointer to time in nanoseconds

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations This API shall only be called from unprivileged context.
*/
extern uint64_t BCM_GetTimeNs(void);

/** @brief Get the current system time in nanoseconds

    This API obtains the current system time from privileged context

    @behavior Sync, Re-entrant

    @pre None

    @param void

    @retval     aTimeInNs       Pointer to time in nanoseconds

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations This API shall only be called from privileged context.
*/
extern uint64_t BCM_GetSystemTimeNs(void);

/** @brief Get absolute difference between two time values

    This API obtains absolute difference between two time values.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aTime1      Time 1 value
    @param[in]   aTime2      Time 2 value

    @retval Absolute difference between aTime1 and aTime2.

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations This API shall only be called from unprivileged context.
*/
BCM_TimeType BCM_GetTimeAbsDiff(const BCM_TimeType aTime1, const BCM_TimeType aTime2);

/** @brief Do busy waiting

    This API does busy waiting (up to Nanoseconds granularity) using internal timer block.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aTime_ns      Time in nanoseconds

    @retval void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations    This API shall only be called from privileged context.
                    This API shall be used only after timer is initialized.
                    This API is expensive in terms of system performance and
                    hence must be used carefully.
*/
extern void BCM_DelayNs(uint32_t aTime_ns);

/** @brief Do busy waiting

    This API does cpu busy waiting (upto Microseconds granularity).

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aTime_us      Time in microseconds

    @retval void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations    This API shall only be called from privileged context.
                    This API shall be used only after timer is initialized.
                    The delay will be equal to or more than the requested value.
                    This API is expensive in terms of system performance and
                    hence must be used carefully.
*/
extern void BCM_DelayUs(uint32_t aTime_us);


/** @brief

    This API starts High Resolution Timer

    @behavior Sync, Re-entrant

    @pre None

    @param  none

    @retval void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations    This API shall only be called from privileged context.
*/
extern void BCM_SystemHRTimerStart(void);

/** @brief

    This API stops High Resolution Timer

    @behavior Sync, Re-entrant

    @pre None

    @param  none

    @retval void

    @post None

    @trace  #BRCM_SWREQ_BCM_TIME

    @limitations    This API shall only be called from privileged context.
*/
extern void BCM_SystemHRTimerStop(void);

#endif /* BCM_TIME_H */
/** @} */
