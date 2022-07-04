/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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
  @defgroup grp_inet_ifc INET Interface
  @ingroup grp_inet

  @addtogroup grp_inet_ifc
  @{
  @file inet.h
  @brief Common definitions for the Internet Stack

  This file provides the common definitions for the Internet Stack

  @version 0.86 Imported from MS Word document
*/
#ifndef INET_H
#define INET_H

#include <stdint.h>
#include <module.h>

/**
    @name Architecture IDs
    @{
    @brief Architecture IDs for INET Library
 */
#define BRCM_SWARCH_INET_IPADDRESS_TYPE         (0x8601U)    /**< @brief #INET_IPAddressType      */
#define BRCM_SWARCH_INET_PORT_TYPE              (0x8602U)    /**< @brief #INET_PortType           */
#define BRCM_SWARCH_INET_ENDPOINTIPPORT_TYPE    (0x8603U)    /**< @brief #INET_EndPointIPPortType */
#define BRCM_SWARCH_INET_PAYLOAD_TYPE           (0x8604U)    /**< @brief #INET_PayloadType        */
#define BRCM_SWARCH_INET_MODULE_GLOBAL          (0x8605U)    /**< @brief #INET_Module             */
#define BRCM_SWARCH_INET_STARTDHCP_PROC         (0x8606U)    /**< @brief #INET_StartDHCP          */
#define BRCM_SWARCH_INET_BIND_PROC              (0x8607U)    /**< @brief #INET_Bind               */
#define BRCM_SWARCH_INET_UNBIND_PROC            (0x8608U)    /**< @brief #INET_UnBind             */
/** @} */

/**
    @name INET_IPAddressType
    @{
    @brief IP Address

    @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_IPAddressType;              /**< @brief typedef for IP Address */
#define INET_IPADDRESS_INVALID     (0x0UL)        /**< @brief Invalid IP Address */
#define INET_IPADDRESS_BCAST_LOCAL (0xFFFFFFFFUL) /**< @brief Broadcast address for local
                                                        network (not forwarded by routers) */
/** @} */

/**
    @name INET_PortType
    @{
    @brief L4 port number

    @trace #BRCM_SWREQ_INET
*/
typedef uint16_t INET_PortType;             /**< @brief typedef for port number */
#define INET_PORT_INVALID         (0U)      /**< @brief Invalid port number */
#define INET_PORT_EPHEMERAL_START (49152U)  /**< @brief Ephemeral port range start */
#define INET_PORT_MAX             (65535U)  /**< @brief Maximum port number */
/** @} */

/**
    @name Payload IDs
    @{
    @brief Unique identification of endpoints being managed by the
           same component
    @trace #BRCM_SWREQ_INET
*/
typedef uint32_t INET_PayloadType;         /**< @brief Payload type */
#define INET_PAYLOAD_ID0            (0UL)  /**< @brief Payload type 0 */
#define INET_PAYLOAD_ID1            (1UL)  /**< @brief Payload type 1 */
#define INET_PAYLOAD_ID2            (2UL)  /**< @brief Payload type 2 */
#define INET_PAYLOAD_ID3            (3UL)  /**< @brief Payload type 3 */
#define INET_PAYLOAD_ID4            (4UL)  /**< @brief Payload type 4 */
#define INET_PAYLOAD_ID5            (5UL)  /**< @brief Payload type 5 */
#define INET_PAYLOAD_ID6            (6UL)  /**< @brief Payload type 6 */
#define INET_PAYLOAD_ID7            (7UL)  /**< @brief Payload type 7 */
#define INET_PAYLOAD_ID8            (8UL)  /**< @brief Payload type 8 */
#define INET_PAYLOAD_ID9            (9UL)  /**< @brief Payload type 9 */
#define INET_PAYLOAD_ID10           (10UL) /**< @brief Payload type 10 */
#define INET_PAYLOAD_ID11           (11UL) /**< @brief Payload type 11 */
/** @}*/

/**
    @brief IP address and Port for an endpoint

    @trace #BRCM_SWREQ_INET
*/
typedef struct sINET_EndPointIPPortType {
    INET_PortType        localPort;  /**< @brief Local port number */
    INET_PortType        remotePort; /**< @brief Remote port number */
    INET_IPAddressType   remoteAddr; /**< @brief Remote IP address. Provide a valid
                                          unicast/multicast address here */
} INET_EndPointIPPortType;

/**
    @brief Function pointers for the INET module

    @trace #BRCM_SWREQ_INET_MODULE
 */
extern const MODULE_Type INET_Module;

/** @brief Start DHCP

    @pre INET module is initialized

    Start DHCP

    @behavior Sync, Re-entrant

    @retval  #BCM_ERR_OK              DHCP started successfully
    @retval  #BCM_ERR_INVAL_STATE     INET is not initialized

    @post None

    @limitations None

    @trace #BRCM_SWREQ_INET_MODULE
*/
int32_t INET_StartDHCP(void);

/** @brief  Bind the end point to a local port

    @pre None

    This API is used to allocate the input port number to an end point, provided it is
    unused. If no valid port number is provided, the stack will allocate an unused
    ephemeral port to the end point. This API can be invoked at any point for the UDP
    endpoints and results in a change in the source port number in the outgoing UDP header

    @behavior Sync, Non-Reentrant for same end point (identified by aCompId,
              aPayloadId)

    @param[in]    aCompId              Component identifier used to identify the
                                       client of the end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       client of the end point
    @param[in]    aPort                Port number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Local port number successfully allocated
    @retval  #BCM_ERR_INVAL_PARAMS     No end point allocated for this client
    @retval  #BCM_ERR_NOPERM           aPort is already bound to another end point
    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_Bind(const BCM_CompIDType aCompId,
                 const INET_PayloadType aPayloadId,
                 INET_PortType aPort);

/** @brief UnBind the end point to a local port

    @pre None

    This API is used to remove the mapping of the endpoint point indicated
    by <aCompId, aPayloadID> to the UDP local port number.

    @behavior Sync, Non-Reentrant for same end point (identified by aCompId,
              aPayloadId)

    @param[in]    aCompId              Component identifier used to identify the
                                       client of the end point
    @param[in]    aPayloadId           Payload identifier used to identify the
                                       client of the end point

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK               Local port number successfully cleared
    @retval  #BCM_ERR_INVAL_STATE      End point has an active Tx buffer due to which
                                       UnBinding cannot happen. Client shall #UDP_CancelSend
                                       the Tx buffer before UnBinding end point.
    @retval  #BCM_ERR_INVAL_PARAMS     No end point allocated for this client

    @post None

    @trace #BRCM_SWREQ_INET

    @limitations None
*/
int32_t INET_UnBind(const BCM_CompIDType aCompId,
                    const INET_PayloadType aPayloadId);

#endif /* INET_H */
/** @} */
