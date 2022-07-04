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
    @defgroup grp_utils_dbg_log_impl Debug Log Implementation
    @ingroup grp_utils

    @addtogroup grp_utils_dbg_log_impl
    @{

    @file dbg_log.c
    @brief Debug Log implementation

    @version 0.1 Initial version
*/

#include <dbg_log.h>
/**
    @name Debug Log Design IDs
    @{
    @brief Design IDs for Debug Log

*/
#define BRCM_SWDSGN_DBG_LOG_BUFFER_GLOBAL    (0xB601U)    /**< @brief #DBG_LogBuffer */
#define BRCM_SWDSGN_DBG_LOG_INDEX_GLOBAL     (0xB602U)    /**< @brief #DBG_LogIndex  */
#define BRCM_SWDSGN_DBG_LOG_STATUS_PROC      (0xB603U)    /**< @brief #DBG_LogStatus */
/** @} */

#ifdef DBG_LOG_BUFFER_SIZE
/**
    @brief Debug Log Buffer

    @trace #BRCM_SWARCH_DBG_LOGSTATUS_PROC
    @trace #BRCM_SWREQ_DBG_LOG
*/
static DBG_LogType DBG_LogBuffer[DBG_LOG_BUFFER_SIZE];
#endif
/**
    @brief Debug Log Index

    @trace #BRCM_SWARCH_DBG_LOGSTATUS_PROC
    @trace #BRCM_SWREQ_DBG_LOG
*/
static uint32_t DBG_LogIndex;

/** @} */

/**
    @addtogroup grp_utils_dbg_log_ifc
    @{
*/

/**
    @trace #BRCM_SWARCH_DBG_LOGSTATUS_PROC
    @trace #BRCM_SWREQ_DBG_LOG

    @code{.c}
    *(volatile uint16_t*)DBG_LOG_REGISTER = aDebugCode;
    if DBG_LogIndex < DBG_LOG_BUFFER_SIZE
        DBG_LogBuffer[DBG_LogIndex++] = aDebugCode;
    @endcode
*/
void DBG_LogStatus(DBG_LogType aDebugCode)
{
#ifdef DBG_LOG_REGISTER
    *((volatile uint16_t*)DBG_LOG_REGISTER) = aDebugCode;
#endif

#ifdef DBG_LOG_BUFFER_SIZE
    (void)DBG_LogBuffer[DBG_LogIndex];
    if (DBG_LogIndex < DBG_LOG_BUFFER_SIZE) {
        DBG_LogBuffer[DBG_LogIndex++] = aDebugCode;
    }
#else
    (void)DBG_LogIndex;
#endif
}
/** @} */
