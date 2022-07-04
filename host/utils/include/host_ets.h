/*****************************************************************************
 Copyright 2017-2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_host_ets Host ETS
    @ingroup grp_host

    @addtogroup grp_host_ets
    @{

    @file host_ets.h
    @brief Host ETS Group API
    This header file contains the host interface functions for ETS Group

    @version 1.0 Initial Version
*/
#ifndef HOST_ETS_H
#define HOST_ETS_H

#include <host_system.h>
#include <ets_osil.h>

/**
    @brief Number of event records per interface

*/
#define ETS_NUM_RECORDS_PER_INTF      (5UL)

/** @brief Get ETS global status

    This API is used to obtain the global status of ETS

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     globalStatus    Pointer to #ETS_GlobalStatusType to be filled

    @return     #BCM_ERR_OK             ETS global status obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid globalStatus pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSGetGlobalStatus(MgmtInfoType *info, ETS_GlobalStatusType *globalStatus);

/** @brief Get ETS port status

    This API is used to obtain the port status from ETS

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     portStatus      Pointer to #ETS_PortNumAndStatusType to be filled

    @return     #BCM_ERR_OK             ETS port status successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid portStatus pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSGetPortStatus(MgmtInfoType *info, ETS_PortNumAndStatusType *portStatus);

/** @brief Clear ETS port statistics

    This API is used to clear ETS statistics specific to a particular port

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number

    @return     #BCM_ERR_OK             ETS port statistics cleared successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSClearPortStats(MgmtInfoType *info, uint32_t port, ETS_DomainType domain);

/** @brief Set Network time

    This API is used to set the network time

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      sec_high        Most significant word of seconds value
    @param[in]      sec_high        Least significant word of seconds value
    @param[in]      nanosec         Nanoseconds value

    @return     #BCM_ERR_OK             Network time set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSSetTime(MgmtInfoType *info, uint32_t sec_high, uint32_t sec_low, uint32_t nanosec);

/** @brief Set ETS global enable

    This API is used to set the global enable of ETS

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      globalEnable    TRUE: Enabled, FALSE: Disabled

    @return     #BCM_ERR_OK             Admin mode set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid globalEnable
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSSetGlobalEnable(MgmtInfoType *info, uint32_t globalEnable);

/** @brief Enable/disable a port

    This API is used to enable/disable a port

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      port            Port number
    @param[in]      portEnable      TRUE: Enabled, FALSE: Disabled
    @param[in]      domain          Domain number

    @return     #BCM_ERR_OK             Port enable set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid portEnable value
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSSetPortEnable(MgmtInfoType *info, uint32_t port, uint32_t portEnable, ETS_DomainType domain);

/** @brief Start/Stop transferring ETS  records

    This API is meant to Start/Stop transferring ETS records

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      isStart         boolean start(1) or stop(0)

    @return     #BCM_ERR_OK             ETS send record started/stoped successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_DATA_INTEG     Invalid response length
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations This API is avaialable only when ENABLE_RECORD_NOTIFICATION is enabled
*/
extern int32_t HOST_ETSStartStopSendingRecord(MgmtInfoType *info, uint8_t isStart);

/** @brief Get records corresponding to a port

    This API is meant to obtain the  Records for a port

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      portIdx         Pointer to #port index
    @param[out]     records         Pointer to #ETS_RecordType
    @param[in]      size            Pointer to #size of array records

    @return     #BCM_ERR_OK             Records retrieved successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid records pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid port number

    @post None

    @limitations This API is avaialable only when ENABLE_RECORD_NOTIFICATION is enabled
*/
extern int32_t HOST_ETSGetRecord(uint32_t portIdx, ETS_RecordType *records, uint32_t size);

/** @brief ETS Group Notification Handler

    This API is meant to handle asynchronous notifications sent by the ETS group on target

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      currentSlave    Slave ID
    @param[in]      comp            Component ID
    @param[in]      notificationId  Notification ID
    @param[in]      msg             Message buffer pointer
    @param[in]      size            Size of the message buffer "msg" in bytes

    @return     #BCM_ERR_OK             Notification handled successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid comp
    @return     #BCM_ERR_INVAL_PARAMS   Invalid notificationId
    @return     #BCM_ERR_INVAL_PARAMS   Invalid msg pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid size

    @post None

    @limitations None
*/
extern int32_t HOST_ETSNotificationHandler(uint32_t currentSlave,
                ETS_EventType notificationId, uint8_t *msg, uint32_t size);

/** @brief Get ETS domain status

    This API is used to obtain the domain status of ETS

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      domain          Domain number
    @param[out]     domainStatus    Pointer to #ETS_DomainStatusType to be filled

    @return     #BCM_ERR_OK             ETS domain status obtained successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid domainStatus pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSGetDomainStatus(MgmtInfoType *info,
                                       ETS_DomainType domain,
                                       ETS_DomainStatusType *domainStatus);

/** @brief Get ETS domain dependent port status

    This API is used to obtain the domain dependent port status from ETS

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[out]     status      Pointer to #ETS_PerDomainPortStatusType to be filled

    @return     #BCM_ERR_OK             ETS per domain port status successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_INVAL_PARAMS   Invalid status pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSGetPerDomainPortStatus(MgmtInfoType *info,
                                              ETS_PerDomainPortStatusType *status);

/** @brief Set ETS domain enable

    This API is used to set the domain enable

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      info            Pointer to #MgmtInfoType handle
    @param[in]      domain          Domain number
    @param[out]     domainEnable    TRUE: Enabled, FALSE: Disabled

    @return     #BCM_ERR_OK             ETS enable set successfully
    @return     #BCM_ERR_INVAL_PARAMS   Invalid info pointer
    @return     #BCM_ERR_UNKNOWN        Error reported by target

    @post None

    @limitations None
*/
extern int32_t HOST_ETSSetDomainEnable(MgmtInfoType *info,
                                       ETS_DomainType domain,
                                       uint32_t  domainEnable);

#endif /* HOST_ETS_H */

/** @} */
