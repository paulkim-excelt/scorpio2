/*****************************************************************************
Copyright 2019-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_dhcp_ifc DHCP Interface
    @ingroup grp_inet

    @addtogroup grp_dhcp_ifc
    @{

    @section sec_dhcp_fsm State Machine
    @image html dhcp_client_state.png "DHCP Client State Machine"

    @section sec_dhcp_seq Sequence Diagrams
    @image html dhcp_client_sequence.png "DHCP Client Sequence Diagram"

    @file dhcp.h
    @brief Interface for DHCP
    This file provides the interface/APIs which can be used to initialize,
    perform a DHCP client or DHCP server operation and to de-initialize
    the DHCP subsystem.
    @version 0.1 Initial version
*/

#ifndef DHCP_H
#define DHCP_H

#include <stdint.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include "inet.h"

/**
    @name DHCP Library API IDs
    @{
    @brief API IDs for DHCP Library
 */
#define BRCM_SWARCH_DHCP_MAX_FILENAME_LEN_MACRO     (0x8501U)    /**< @brief #DHCP_MAX_FILENAME_LEN  */
#define BRCM_SWARCH_DHCP_MAX_CLIENTID_LEN_MACRO     (0x8502U)    /**< @brief #DHCP_MAX_CLIENTID_LEN  */
#define BRCM_SWARCH_DHCP_MAX_VENDORID_LEN_MACRO     (0x8503U)    /**< @brief #DHCP_MAX_VENDORID_LEN  */
#define BRCM_SWARCH_DHCP_MAX_SNAME_LEN_MACRO        (0x8504U)    /**< @brief #DHCP_MAX_SNAME_LEN     */
#define BRCM_SWARCH_DHCP_MAX_PKT_LEN_MACRO          (0x8505U)    /**< @brief #DHCP_MAX_PKT_LEN       */
#define BRCM_SWARCH_DHCP_SERVER_PORT_MACRO          (0x8506U)    /**< @brief #DHCP_SERVER_PORT       */
#define BRCM_SWARCH_DHCP_CLIENT_PORT_MACRO          (0x8507U)    /**< @brief #DHCP_CLIENT_PORT       */
#define BRCM_SWARCH_DHCP_INFINITY_TIME_MACRO        (0x8508U)    /**< @brief #DHCP_INFINITY_TIME     */
#define BRCM_SWARCH_DHCP_MAX_OFFERS_CACHED_MACRO    (0x8509U)    /**< @brief #DHCP_MAX_OFFERS_CACHED */
#define BRCM_SWARCH_DHCP_PARAM_TYPE                 (0x850AU)    /**< @brief #DHCP_ParamType         */
#define BRCM_SWARCH_DHCP_CONFIG_TYPE                (0x850BU)    /**< @brief #DHCP_ConfigType        */

#define BRCM_SWARCH_DHCP_INIT_PROC                  (0x850CU)    /**< @brief #DHCP_Init              */
#define BRCM_SWARCH_DHCP_DEINIT_PROC                (0x850DU)    /**< @brief #DHCP_DeInit            */
#define BRCM_SWARCH_DHCP_SELECTOFFER_PROC           (0x850EU)    /**< @brief #DHCP_SelectOffer       */
#define BRCM_SWARCH_DHCP_GETPARAMETER_PROC          (0x850FU)    /**< @brief #DHCP_GetParameter      */
/** @} */

/**
    @brief Maximum file name size

    Macro used to define the maximum length of the
    file name (including the string termination character)
    in bytes.

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_MAX_FILENAME_LEN  (128U)

/**
    @brief Maximum client identifier size

    Macro used to define the maximum length of the
    client identifier in bytes.

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_MAX_CLIENTID_LEN  (32U)

/**
    @brief Maximum vendor class identifier size

    Macro used to define the maximum length of the
    vendor class identifier in bytes.

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_MAX_VENDORID_LEN  (32U)

/**
    @brief Maximum server name size

    Macro used to define the maximum length of the
    server length in bytes.

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_MAX_SNAME_LEN     (64U)

/**
    @brief DHCP server port number

    Macro used to define UDP port used for
    DHCP server operation

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_SERVER_PORT       (67U)

/**
    @brief DHCP client port number

    Macro used to define UDP port used for
    DHCP client operation

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_CLIENT_PORT       (68U)

/**
    @brief DHCP infinity time value

    Macro used to define infinite time for
    leases

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_INFINITY_TIME     (0xFFFFFFFFUL)

/**
    @brief Maximum supported size of DHCP packet

    Macro used to define the maximum size of DHCP packet (in bytes)
    supported by the library. Reception of a larger packet might
    lead to loss of data

    @trace #BRCM_SWREQ_DHCP
*/
#define DHCP_MAX_PKT_LEN      (548U)

/**
    @name DHCP parameter identifier
    @{
    @brief This identifier is used to fetch the parameter using
    the #DHCP_GetParameter API

    @trace #BRCM_SWREQ_DHCP
*/
typedef uint32_t DHCP_ParamType;           /**< @brief Typedef for DHCP parameter identifier */
#define DHCP_PARAM_IPADDR           (1UL)  /**< @brief Host IP address */
#define DHCP_PARAM_ROUTER           (2UL)  /**< @brief Router/Gateway IP address */
#define DHCP_PARAM_SUBNET_MASK      (3UL)  /**< @brief Subnet mask */
#define DHCP_PARAM_SERVER_ID        (4UL)  /**< @brief Server identifier */
#define DHCP_PARAM_LEASE_TIME       (5UL)  /**< @brief Lease time */
#define DHCP_PARAM_TFTP_SERVER_ADDR (6UL)  /**< @brief TFTP server IP address */
#define DHCP_PARAM_BOOT_FILE_NAME   (7UL)  /**< @brief Boot file name */
#define DHCP_PARAM_RENEWAL_TIME     (8UL)  /**< @brief Renewal timer (T1) */
#define DHCP_PARAM_REBINDING_TIME   (9UL)  /**< @brief Rebinding timer (T2) */
#define DHCP_PARAM_VENDOR_INFO      (10UL) /**< @brief Vendor specific information */
/** @} */

/**
    @brief DHCP initialization config structure

    This is the structure containing initialization parameters for DHCP

    @trace #BRCM_SWREQ_DHCP
 */
typedef struct sDHCP_ConfigType {
    BCM_CompIDType          compID;                          /**< @brief Component identifier used to identify the client of the end point */
    INET_PayloadType        payloadID;                       /**< @brief Payload identifier used to identify the client of the end point */
    uint32_t                leaseTime;                       /**< @brief DHCP option: requested lease time in seconds */
    uint8_t                 maxRetries;                      /**< @brief Number of attempts to retransmit a request (when no response is received).
                                                                   The delay between retries is as per the (non random) exponential backoff algorithm
                                                                   e.g. 1s, 2s, 4s. The maximum delay would be bounded by the #maxRetryPeriod parameter */
    uint32_t                selectTimeout;                   /**< @brief Maximum amount of time (in milliseconds) spent in Selecting state */
    uint32_t                initialDelaySeed;                /**< @brief Seed value for the amount of delay (in milliseconds) before sending
                                                                   the first Discover message. If 0, the message will be sent immediately.
                                                                   Note that value less than 1000 i.e. one second will be non compliant with the DHCP specification */
    uint32_t                initialRetryPeriod;              /**< @brief Initial retry period (in milliseconds) between retrying a message (if no reply is received) */
    uint32_t                maxRetryPeriod;                  /**< @brief Maximum amount of time (in milliseconds) between retrying a message (if no reply is received) */
    uint8_t                 clientIdLen;                     /**< @brief Length (in bytes) of the clientId field. If greater than 1, it
                                                                  shall be used to populate the client identifier option */
    uint8_t                 vendorIdLen;                     /**< @brief Length (in bytes) of the vendorId field. If greater than 0, it
                                                                  shall be used to populate the vendor class identifier option */
    uint8_t                 clientId[DHCP_MAX_CLIENTID_LEN]; /**< @brief DHCP option: client identifier */
    uint8_t                 hintFile[DHCP_MAX_FILENAME_LEN]; /**< @brief Hint file name for BOOTP */
    uint8_t                 vendorId[DHCP_MAX_VENDORID_LEN]; /**< @brief DHCP option: vendor class identifier */
} DHCP_ConfigType;

/** @brief Initialize DHCP client

    This API initializes DHCP client and transitions it to the init state

    @behavior Sync, Non-reentrant

    @param[in]       aConfig                  Configuration params for
                                              DHCP library.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Initialization is successfull
    @retval          #BCM_ERR_INVAL_PARAMS    #aConfig is NULL
    @retval          #BCM_ERR_NOT_FOUND       No end point found corresponding to compID+payloadID in #aConfig
    @retval          #BCM_ERR_INVAL_PARAMS    End point is not configured for UDP
    @retval          #BCM_ERR_INVAL_PARAMS    Interface corresponding to endPtNum in #aConfig
                                              is not configured for DHCP (e.g. has static address
                                              assigned)
    @retval          #BCM_ERR_INVAL_STATE     DHCP is already in initialized state

    @trace #BRCM_SWREQ_DHCP
*/
int32_t DHCP_Init(const DHCP_ConfigType* const aConfig);

/** @brief De-Initialize the DHCP client

    This API deinitializes the DHCP client. It also releases
    any IP address if assigned. The state transitions to reset

    @behavior Sync, Non-reentrant

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              De-Initialization is successfull
    @retval          #BCM_ERR_INVAL_STATE     DHCP is already de-initialized

    @trace #BRCM_SWREQ_DHCP
*/
int32_t DHCP_DeInit(void);

/** @brief Select a DHCP offer

    Select an offer (identified by the #aOfferNum parameter previously received in a
    #DHCP_OfferReceivedCallback() from a DHCP server. This API shall transition the client
    from the selecting to the requesting state

    @behavior Sync, Non-reentrant

    @param[in]       aOfferNum                Number identifying the offer

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Operation is successfull
    @retval          #BCM_ERR_INVAL_STATE     DHCP is not in selecting state
    @retval          #BCM_ERR_INVAL_PARAMS    #aOfferNum does not correspond to a valid offer

    @trace #BRCM_SWREQ_DHCP
*/
int32_t DHCP_SelectOffer(uint32_t aOfferNum);

/** @brief Get the value for a DHCP parameter

    This API is used to fetch the value of a parameter identifier by
    the #DHCP_ParamType input. It can be used in the following ways:
     -# In the selecting state, this can be used to fetch the parameter
        value for an offer (identified by the #aOfferNum argument). This
        can be used to make a decision regarding which offer to select
     -# In the bound state, this can be used to fetch the parameter value
        for the binding. The #aOfferNum shall only accept the value 0UL in
        this situation
    @note The library converts the parameters (wherever applicable) to the
    Host endianness format

    @behavior Sync, Non-reentrant

    @param[in]       aOfferNum                Number identifying the offer
    @param[in]       aKey                     DHCP parameter identifier
    @param[out]      aValue                   Buffer to store the value of the parameter
    @param[inout]    aValueLen                Length of the buffer in the input, length of the
                                              stored value in the output

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Parameter value fetched successfully
    @retval          #BCM_ERR_INVAL_PARAMS    #aOfferNum does not correspond to a valid offer
    @retval          #BCM_ERR_INVAL_PARAMS    #aKey is invalid
    @retval          #BCM_ERR_INVAL_PARAMS    #aValue or aValueLen is NULL
    @retval          #BCM_ERR_INVAL_STATE     DHCP has no valid offers or bindings

    @trace #BRCM_SWREQ_DHCP
*/
int32_t DHCP_GetParameter(uint32_t aOfferNum, DHCP_ParamType aKey, uint8_t *const aValue, uint32_t *const aValueLen);

#endif /* DHCP_H */

/** @} */

