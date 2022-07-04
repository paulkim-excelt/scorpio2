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
    @defgroup grp_tftp_ifc Interface
    @ingroup grp_tftp

    @addtogroup grp_tftp_ifc
    @{

    @section sec_tftp_fsm State Machine

    @tagfsm tftp_client_state_machine.svg "TFTP Client state machine"
    @startfsm
    Reset; Init; Read; Write;
    begin -> Reset;
    Reset -> Init [label = "TFTP_Init"];
    Init -> Read [label = "TFTP_ClientRead"];
    Init -> Write [label = "TFTP_ClientWrite"];
    Init -> Reset [label = "TFTP_Deinit"];
    Read -> Init [label = "TFTP_GetDataHandler"];
    Read -> Reset [label = "TFTP_Deinit"];
    Write -> Init [label = "TFTP_PutDataHandler"];
    Write -> Reset [label = "TFTP_Deinit"];
    @endfsm

    @tagfsm tftp_server_state_machine.svg "TFTP Server state machine"
    @startfsm
    Reset; Init; Send; Receive;
    begin -> Reset;
    Reset -> Init [label = "TFTP_Init"];
    Init -> Send [label = "TFTP_ServerAcceptConnection"];
    Init -> Receive [label = "TFTP_ServerAcceptConnection"];
    Init -> Reset [label = "TFTP_Deinit"];
    Send -> Init [label = "TFTP_PutDataHandler"];
    Send -> Reset [label = "TFTP_Deinit"];
    Receive -> Init [label = "TFTP_GetDataHandler"];
    Receive -> Reset [label = "TFTP_Deinit"];
    @endfsm

    @section sec_tftp_seq Sequence Diagrams

    @tagseq tftp_client_seq_diagram.svg "TFTP Client Sequence diagram"
    @startseq
    group {label = "client"; color = "#EFFFFF";  Client;};
    group {label = "TFTP"; color = "#EFFFFF";  TFTP;};
    Client => TFTP [label = "TFTP_Init", rightnote = "Initialize context structure"];
    Client => TFTP [label = "TFTP_ClientRead / TFTP_ClientWrite", rightnote = "Send Read/write request"];
    loop {
        Client => TFTP [label = "TFTP_GetDataHandler/TFTP_PutDataHandler",
                        rightnote = "Read/Write data packets",
                        leftnote = "Repeat until BCM_ERR_OK"];
    };
    Client => TFTP [label = "TFTP_DeInit", rightnote = "De-Initialize context structure"];
    @endseq

    @tagseq tftp_server_seq_diagram.svg "TFTP Server Sequence diagram"
    @startseq
    group {label = "Server Task"; color = "#EFFFFF";  Client;};
    group {label = "TFTP Library"; color = "#EFFFFF";  TFTP;};
    Client => TFTP [label = "TFTP_DetectPacket", rightnote = "On a request at standard UDP port 69"];
    Client => TFTP [label = "TFTP_ServerRejectConnection", rightnote = "If request cannot be serviced"];
    Client => TFTP [label = "TFTP_Init", rightnote = "Initialize context structure"];
    Client => TFTP [label = "TFTP_ServerAcceptConnection", rightnote = "Accept incoming transfer request"];
    loop {
        Client => TFTP [label = "TFTP_PutDataHandler/TFTP_GetDataHandler",
                        rightnote = "Send/Recv data packets",
                        leftnote = "Repeat until BCM_ERR_OK"];
    };
    Client => TFTP [label = "TFTP_DeInit", rightnote = "De-Initialize context structure"];
    @endseq

    @file tftp.h
    @brief Interface for TFTP
    This file provides the interface/APIs which can be used to initialize,
    perform a TFTP client or TFTP server operation and to de-initialize
    the TFTP subsystem.
    @version 0.1 Initial version
*/

#ifndef TFTP_H
#define TFTP_H

#include <bcm_utils.h>
#include <bcm_err.h>
#include <bcm_time.h>
#include <inet.h>

/**
    @name TFTP Library API IDs
    @{
    @brief API IDs for TFTP Library
 */
#define BRCM_SWARCH_TFTP_MAX_FILENAME_LEN_MACRO             (0x8101U)    /**< @brief #TFTP_MAX_FILENAME_LEN          */
#define BRCM_SWARCH_TFTP_MAX_PACKET_SIZE_MACRO              (0x8102U)    /**< @brief #TFTP_MAX_PACKET_SIZE           */
#define BRCM_SWARCH_TFTP_STATE_TYPE                         (0x8103U)    /**< @brief #TFTP_StateType                 */
#define BRCM_SWARCH_TFTP_CONFIG_TYPE                        (0x8104U)    /**< @brief #TFTP_ConfigType                */
#define BRCM_SWARCH_TFTP_REQUEST_TYPE                       (0x8105U)    /**< @brief #TFTP_RequestType               */
#define BRCM_SWARCH_TFTP_CONTEXT_TYPE                       (0x8106U)    /**< @brief #TFTP_ContextType               */
#define BRCM_SWARCH_TFTP_INIT_PROC                          (0x8107U)    /**< @brief #TFTP_Init                      */
#define BRCM_SWARCH_TFTP_CLIENTREAD_PROC                    (0x8108U)    /**< @brief #TFTP_ClientRead                */
#define BRCM_SWARCH_TFTP_CLIENTWRITE_PROC                   (0x8109U)    /**< @brief #TFTP_ClientWrite               */
#define BRCM_SWARCH_TFTP_GETDATAHANDLER_PROC                (0x810AU)    /**< @brief #TFTP_GetDataHandler            */
#define BRCM_SWARCH_TFTP_DEINIT_PROC                        (0x810BU)    /**< @brief #TFTP_DeInit                    */
#define BRCM_SWARCH_TFTP_PACKET_TYPE                        (0x810CU)    /**< @brief #TFTP_PacketType                */
#define BRCM_SWARCH_TFTP_SERVERACCEPTCONN_PROC              (0x810DU)    /**< @brief #TFTP_ServerAcceptConnection    */
#define BRCM_SWARCH_TFTP_DETECTPACKET_PROC                  (0x810EU)    /**< @brief #TFTP_DetectPacket              */
#define BRCM_SWARCH_TFTP_PUTDATAHANDLER_PROC                (0x810FU)    /**< @brief #TFTP_PutDataHandler            */
#define BRCM_SWARCH_TFTP_SERVERREJECTCONN_PROC              (0x8110U)    /**< @brief #TFTP_ServerRejectConnection    */
#define BRCM_SWARCH_TFTP_ERROR_TYPE                         (0x8111U)    /**< @brief #TFTP_ErrorType                 */
#define BRCM_SWARCH_TFTP_MAX_NUM_SUPPORTED_OPTIONS_MACRO    (0x8112U)    /**< @brief #TFTP_MAX_NUM_SUPPORTED_OPTIONS */
#define BRCM_SWARCH_TFTP_OPTION_TYPE                        (0x8113U)    /**< @brief #TFTP_OptionType                */
#define BRCM_SWARCH_TFTP_OPTIONDATA_TYPE                    (0x8114U)    /**< @brief #TFTP_OptionDataType            */
#define BRCM_SWARCH_TFTP_OPTIONCFG_TYPE                     (0x8115U)    /**< @brief #TFTP_OptionCfgType             */
#define BRCM_SWARCH_TFTP_SUPPORTED_MAX_DATA_LEN_MACRO       (0x8116U)    /**< @brief #TFTP_SUPPORTED_MAX_DATA_LEN    */
#define BRCM_SWARCH_TFTP_PACKETSTATE_TYPE                   (0x8117U)    /**< @brief #TFTP_PacketStateType           */
#define BRCM_SWARCH_TFTP_DEFAULT_DATA_LEN_MACRO             (0x8118U)    /**< @brief #TFTP_DEFAULT_DATA_LEN          */
#define BRCM_SWARCH_TFTP_GETSTATE_PROC                      (0x8119U)    /**< @brief #TFTP_GetState                  */
#define BRCM_SWARCH_TFTP_ISTXPENDING_PROC                   (0x811AU)    /**< @brief #TFTP_IsTxPending               */
#define BRCM_SWARCH_TFTP_GET_BLOCK_SIZE_PROC                (0x811BU)    /**< @brief #TFTP_GetBlockSize              */
#define BRCM_SWARCH_TFTP_GETPACKETPROCSTATE_PROC            (0x811CU)    /**< @brief #TFTP_GetPacketProcState        */
/** @} */

/**
    @brief Maximum file name size

    Macro used to define the maximum length of the
    file name in bytes.

    @trace #BRCM_SWREQ_TFTP
*/
#define TFTP_MAX_FILENAME_LEN  (127U)

/**
    @brief Maximum count of TFTP options that are supported

    Macro used to define the maximum count of the
    supported TFTP options.

    @trace #BRCM_SWREQ_TFTP
*/
#define TFTP_MAX_NUM_SUPPORTED_OPTIONS  (1U)

/**
    @brief Max supported TFTP packet payload length

    @trace #BRCM_SWREQ_TFTP
*/
#define TFTP_SUPPORTED_MAX_DATA_LEN        (1428U)

/**
    @brief Default TFTP packet payload length that is used.

    @trace #BRCM_SWREQ_TFTP
*/
#define TFTP_DEFAULT_DATA_LEN              (512U)

/**
    @brief Maximum size of a TFTP packet

    Maximum size would be for a data buffer carrying 'n' bytes
    of configured data length and 4 bytes of TFTP header.

    @trace #BRCM_SWREQ_TFTP
*/
#define TFTP_MAX_PACKET_SIZE   (TFTP_MAX_DATA_LEN + 4U)

/**
    @name TFTP error code values
    @{

    The error values supported by TFTP protocol.

    @trace #BRCM_SWREQ_TFTP
*/
typedef uint16_t TFTP_ErrorType;                 /**< @brief TFTP error code */
#define TFTP_ERROR_NOT_DEFINED             (0U)  /**< @brief Unknown TFTP error */
#define TFTP_ERROR_FILE_NOT_FOUND          (1U)  /**< @brief File not found */
#define TFTP_ERROR_ACCESS_VIOLATION        (2U)  /**< @brief File access violation */
#define TFTP_ERROR_DISK_FULL_ALLOC_EXCEED  (3U)  /**< @brief Disk full */
#define TFTP_ERROR_ILLEGAL_TFTP_OPERATION  (4U)  /**< @brief Illegal TFTP operation */
#define TFTP_ERROR_UNKNOWN_TRNSFR_ID       (5U)  /**< @brief Unknown transfer ID */
#define TFTP_ERROR_FILE_ALRDY_EXISTS       (6U)  /**< @brief File already exists */
#define TFTP_ERROR_NO_SUCH_USER            (7U)  /**< @brief No such user */
#define TFTP_ERROR_OPTIONS                 (8U)  /**< @brief Error during option negotiation : rfc2348 */
/** @} */

/**
    @name TFTP packet type
    @{
    @brief Various packet types of TFTP

    @trace #BRCM_SWREQ_TFTP
*/
typedef uint16_t TFTP_PacketType;     /**< @brief TFTP packet type */
#define TFTP_PACKET_INVALID     (0U)  /**< @brief TFTP invalid packet type */
#define TFTP_PACKET_RRQ         (1U)  /**< @brief TFTP read packet type */
#define TFTP_PACKET_WRQ         (2U)  /**< @brief TFTP write packet type */
#define TFTP_PACKET_DATA        (3U)  /**< @brief TFTP data packet type */
#define TFTP_PACKET_ACK         (4U)  /**< @brief TFTP ack packet type */
#define TFTP_PACKET_ERROR       (5U)  /**< @brief TFTP error packet type */
#define TFTP_PACKET_OACK        (6U)  /**< @brief TFTP optional ACK packet type */
/** @} */

/**
    @name TFTP connection states
    @{
    @brief The internal states of a TFTP connection

    The #TFTP_STATE_READ and #TFTP_STATE_WRITE are used by the TFTP client
    interfaces. States #TFTP_STATE_SEND and #TFTP_STATE_RECV are used
    by the TFTP server interfaces.

    @trace #BRCM_SWREQ_TFTP
*/
typedef uint32_t TFTP_StateType;       /**< @brief TFTP State value */
#define TFTP_STATE_RESET        (0UL)  /**< @brief Reset State */
#define TFTP_STATE_INIT         (1UL)  /**< @brief Init State */
#define TFTP_STATE_READ         (2UL)  /**< @brief TFTP client read state */
#define TFTP_STATE_WRITE        (3UL)  /**< @brief TFTP client write state */
#define TFTP_STATE_SEND         (4UL)  /**< @brief TFTP server send state */
#define TFTP_STATE_RECV         (5UL)  /**< @brief TFTP server receive state */
/** @} */

/**
    @name TFTP packet processing states
    @{
    @brief The internal states of a TFTP packet creation/parsing

    @trace #BRCM_SWREQ_TFTP
*/
typedef uint32_t TFTP_PacketStateType;              /**< @brief TFTP packet state value */
#define TFTP_PACKETSTATE_RESET               (0UL)  /**< @brief Reset state */
#define TFTP_PACKETSTATE_IN_PROCESS          (1UL)  /**< @brief Portion of TFTP packet has been created/parsed */
#define TFTP_PACKETSTATE_LAST_PENDING        (2UL)  /**< @brief Last packet Tx pending due to Tx buffer unavailability */
#define TFTP_PACKETSTATE_LAST_SENT           (3UL)  /**< @brief Last packet sent for TFTP connection */
/** @} */

/**
    @name TFTP Option Types
    @{
    @trace #BRCM_SWREQ_TFTP
*/
typedef uint32_t TFTP_OptionType;      /**< @brief TFTP Option type */
#define TFTP_OPTION_BLKSIZE     (0UL)  /**< @brief @brief Payload block size in bytes.
                                            TFTP uses 512 bytes of payload by default.
                                            In case a client wishes to use a higher size (less than
                                            or equal to TFTP_MAX_DATA_LEN), it needs be configured
                                            using this field. Note that this is the max value and the
                                            finalized value depends on the negotiation from the
                                            remote client/server */
/** @} */

/**
    @brief TFTP Option data encapsulation structure

    This is the structure used to store details about every
    TFTP option.

    @trace #BRCM_SWREQ_TFTP
 */
typedef struct sTFTP_OptionDataType {
    TFTP_OptionType     type;          /**< @brief Option type */
    uint32_t            val;           /**< @brief Option value */
} TFTP_OptionDataType;

/**
    @brief TFTP Option configuration structure

    This is the structure which is used to get/set the TFTP options
    from library.

    @trace #BRCM_SWREQ_TFTP
 */
typedef struct sTFTP_OptionCfgType {
    uint8_t                 count;  /**< @brief Count of options filled */
    TFTP_OptionDataType     list[TFTP_MAX_NUM_SUPPORTED_OPTIONS];
                                    /**< @brief Option information list */
} TFTP_OptionCfgType;

/**
    @brief TFTP initialization config structure

    This is the configuration structure which is used by TFTP to store the
    initialization config values.

    @trace #BRCM_SWREQ_TFTP
 */
typedef struct sTFTP_ConfigType {
    uint64_t            compId;             /**< @brief Component ID of the client */
    INET_PayloadType    payloadId;          /**< @brief payload ID for the connection */
    INET_IPAddressType  remoteIPAddr;       /**< @brief TFTP remote client/server IP address */
    uint32_t            maxRetryCount;      /**< @brief Maximum retry count */
    uint32_t            timeoutInms;        /**< @brief Timeout in milliseconds */
    TFTP_OptionCfgType  options;            /**< @brief TFTP options */
} TFTP_ConfigType;

/**
    @brief TFTP file request information structure

    This is the structure which is used by TFTP to store the read/write
    file name information in the context structure.

    @trace #BRCM_SWREQ_TFTP
 */
typedef struct sTFTP_RequestType {
    uint8_t        fileName[TFTP_MAX_FILENAME_LEN+1U];  /**< @brief Name of the file to be read/written */
} TFTP_RequestType;

/**
    @brief TFTP context structure

    This is the context structure which is ued by TFTP to initiate and
    process read or a write request.

    @trace #BRCM_SWREQ_TFTP
 */
typedef struct sTFTP_ContextType {
    uint32_t                magic;                            /**< @brief Magic for the context structure */
    uint32_t                seed;                             /**< @brief Seed for random number generator */
    TFTP_StateType          state;                            /**< @brief State of the TFTP connection */
    TFTP_ConfigType         cfg;                              /**< @brief Initialization configuration */
    TFTP_RequestType        req;                              /**< @brief File read/write request configuration */
    uint16_t                blockNo;                          /**< @brief Last processed block number */
    uint32_t                procDataBufSize;                  /**< @brief Processed input data size (offset) */
    uint8_t                 txPacketBuf[TFTP_MAX_PACKET_SIZE];/**< @brief Buffer for creating the Tx TFTP packets */
    uint16_t                txPacketBufFilledSize;            /**< @brief Size in bytes of the Tx packet buffer */
    uint8_t                 rxPacketBuf[TFTP_MAX_PACKET_SIZE];/**< @brief Buffer for receiving the Rx TFTP packets.
                                                                    In case of any Rx error packet from TFTP server, this buffer
                                                                    holds the error string at offset of 4 bytes */
    uint16_t                rxPacketBufFilledSize;            /**< @brief Size in bytes of the Rx packet buffer */
    uint16_t                rxPacketBufProcSize;              /**< @brief Size in bytes of the Rx packet buffer which is partially processed */
    uint64_t                lastProcessedTime;                /**< @brief system time at which the last packet
                                                                    was sent out and a response is awaited */
    uint32_t                curRetryCount;                    /**< @brief Current retry count */
    uint32_t                isTxPending;                      /**< @brief Flag to indicate that UDP_Process API is to be invoked */
    TFTP_PacketStateType    packetState;                      /**< @brief State of the packet being processed */
    uint16_t                tftpRemotePort;                   /**< @brief UDP port used by remote end point to service the request */
    uint16_t                blockSizeUsed;                    /**< @brief Payload block size used for request
                                                                    Note: Client needs to monitor this value in case remote server
                                                                    responds with a lower blksize value than requested. The buffer
                                                                    size provided to the data handler APIs need to be adjusted
                                                                    based on this aligned value */
} TFTP_ContextType;

/**
    @brief Function to return the state of the TFTP connection

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aContext                 TFTP context structure.

    @retval          #TFTP_StateType          State of the connection

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
static inline TFTP_StateType TFTP_GetState(TFTP_ContextType* aContext)
{
        return aContext->state;
}

/**
    @brief Function to return if there is a pending buffer for transmission

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aContext                TFTP context structure.

    @retval          uint32_t                Boolean to indicate if there
                                             is a Tx buffer pending
                                             transmission

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
static inline uint32_t TFTP_IsTxPending(TFTP_ContextType* aContext)
{
        return aContext->isTxPending;
}

/**
    @brief Function to return the block size used for file transfer

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aContext                TFTP context structure.

    @retval          uint32_t                TFTP Block size in bytes

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
static inline uint16_t TFTP_GetBlockSize(TFTP_ContextType* aContext)
{
    return aContext->blockSizeUsed;
}

/**
    @brief Function to get the packet processing state

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aContext                  TFTP context structure

    @retval          #TFTP_PacketStateType     State of a TFTP packet creation/parsing

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
static inline TFTP_PacketStateType TFTP_GetPacketProcState(TFTP_ContextType* aContext)
{
    return aContext->packetState;
}

/** @brief Initialize the TFTP connection

    This API initializes the TFTP context structure and updates the state
    such that data can be read or written.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_RESET.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aConfig                  Configuration params for
                                              TFTP library.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Initialization is successfull
    @retval          #BCM_ERR_INVAL_PARAMS    aContext or aConfig is NULL
    @retval          #BCM_ERR_INVAL_PARAMS    For an invalid or unsupported
                                              TFTP option type/value

    @post Component shall move to #TFTP_STATE_INIT on success.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_Init(TFTP_ContextType* const aContext,
                  const TFTP_ConfigType* const aConfig);

/** @brief Send TFTP Read Request

    This API sends a TFTP read request to the remote TFTP server and
    initiates file read operation.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_INIT.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aFileName                Name of the file that needs to read.
                                              Note that the maximum length of the file name
                                              shall be #TFTP_MAX_FILENAME_LEN bytes.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Read request sent successfully
    @retval          #BCM_ERR_INVAL_STATE     If the current state is not #TFTP_Init
    @retval          #BCM_ERR_INVAL_PARAMS    if length of aFileName is greator
                                              than #TFTP_MAX_FILENAME_LEN bytes
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid
    @retval          #BCM_ERR_INVAL_PARAMS    aContext/aFileName is NULL

    @post Component shall move to #TFTP_STATE_READ on success.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_ClientRead(TFTP_ContextType* const aContext,
                        const uint8_t* const aFileName);

/** @brief Send TFTP Write Request

    This API sends a TFTP write request to the remote TFTP server and
    initiates file write operation.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_INIT.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aFileName                Name of the file that needs to
                                              created and written.
                                              Note that the maximum length of the file name
                                              shall be #TFTP_MAX_FILENAME_LEN bytes.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Write request sent successfully
    @retval          #BCM_ERR_INVAL_STATE     If the current state is not #TFTP_Init
    @retval          #BCM_ERR_INVAL_PARAMS    if length of aFileName is greator
                                              than #TFTP_MAX_FILENAME_LEN bytes
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid
    @retval          #BCM_ERR_INVAL_PARAMS    aContext/aFileName is NULL

    @post Component shall move to #TFTP_STATE_WRITE on success.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_ClientWrite(TFTP_ContextType* const aContext,
                         const uint8_t* const aFileName);

/** @brief Accept incoming transfer request at Server

    This API accepts an incoming request from a remote port
    and prepares for the file transfer

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_INIT.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aRemotePort              Remote UDP port for the connection.
    @param[in]       aIsRead                  Flag indicating whether the connection
                                              is for read or write

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              File transfer accepted successfully.
    @retval          #BCM_ERR_INVAL_STATE     If the current state is not #TFTP_STATE_INIT.
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid.

    @post Component shall move to #TFTP_STATE_RECV/#TFTP_STATE_SEND on success

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_ServerAcceptConnection(TFTP_ContextType* const aContext,
                                    const uint16_t aRemotePort,
                                    uint32_t aIsRead);

/** @brief Detect packet at TFTP standard port 69

    This API reads the packet at TFTP server port 69 and detects the
    TFTP request type and returns details on the request to the calling
    client.

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aCompId                  Component identifier used to identify the
                                              client of the end point (maps to port 69).
    @param[in]       aPayloadId               Payload identifier used to identify the
                                              client of the end point (maps to port 69).
    @param[out]      aFileName                File name detected in TFTP packet. It is
                                              expected that the aFileName points to a
                                              buffer of size #TFTP_MAX_FILENAME_LEN+1 bytes.
    @param[out]      aPacketType              TFTP packet type in TFTP packet.
    @param[out]      aClientIPAddr            IP address of the client.
    @param[out]      aClientPort              UDP Port of the client.
    @param[out]      aOptions                 TFTP options as requested by the
                                              remote client.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid input arguments
    @retval          #BCM_ERR_NOSUPPORT       Read packet was not a TFTP packet or
                                              if the file name length was greater
                                              than TFTP_MAX_FILENAME_LEN or
                                              if the mode is not 'octet'
    @retval          #BCM_ERR_OK              TFTP packet was successfully parsed

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_DetectPacket(const uint64_t aCompId,
                          const INET_PayloadType aPayloadId,
                          uint8_t* const aFileName,
                          TFTP_PacketType* const aPacketType,
                          INET_IPAddressType* const aClientIPAddr,
                          INET_PortType* const aClientPort,
                          TFTP_OptionCfgType* const aOptions);

/** @brief Reject any client requests

    This API Sends a TFTP error packet based on the input. It shall be
    used by an implementation of TFTP server to reject any incoming
    client requests. E.g. If the file requested by remote client is not
    present OR if there is no memory available for file write.

    @behavior Sync, Reentrant

    @pre None

    @param[in]       aCompId                  Component identifier used to identify the
                                              client of the end point.
    @param[in]       aPayloadId               Payload identifier used to identify the
                                              client of the end point.
    @param[in]       aClientIPAddr            IP address of the remote client.
    @param[in]       aClientPort              UDP Port of the remote client.
    @param[in]       aErrorValue              TFTP error value to be used while creating
                                              the error packet.
    @param[in]       aErrorString             Error string to be used while creating the
                                              error packet. It is expected that the aErrorString
                                              string lenth shall be less than
                                              #TFTP_MAX_FILENAME_LEN bytes. If not, the error
                                              string shall be truncated to #TFTP_MAX_FILENAME_LEN
                                              bytes.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_INVAL_PARAMS    Invalid input arguments
    @retval          #BCM_ERR_BUSY            Error returned by UDP_Send API. Client shall retry
                                              sending the error packet on ethernet Tx buffer
                                              being available.
    @retval          #BCM_ERR_OK              TFTP error packet was successfully transmitted.

    @post None

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_ServerRejectConnection(const uint64_t aCompId,
                                    const INET_PayloadType aPayloadId,
                                    const INET_IPAddressType aClientIPAddr,
                                    const INET_PortType aClientPort,
                                    const TFTP_ErrorType aErrorValue,
                                    uint8_t* const aErrorString);

/** @brief Function to process and get the status of the pending
    READ request of the TFTP client and the RECEIVE request
    of the TFTP server.

    This API processes receiving the data packets from the remote TFTP
    Client/Server. It is responsible for sending ACK,
    detecting timeout, resending packets and handling detected errors.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_READ/#TFTP_STATE_RECV.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aBuf                     Buffer to which data needs to be read.
    @param[in]       aBufLen                  Length of the data buffer in bytes.
    @param[out]      aFilledBufLen            Size of data read into current #aBuf.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              Operation completed successfully.
    @retval          #BCM_ERR_BUSY            Operation is under progress. Needs to be
                                              called again on an event notification.
    @retval          #BCM_ERR_UNKNOWN         Error from remote end for
                                              1. Not defined error
                                              2. Illegal TFTP operation
                                              3. Unknown transfer ID
                                              4. No such user
    @retval          #BCM_ERR_NOMEM           If the remote end returned data bytes
                                              greater than the buffer size provided. On this
                                              error, the user shall increment the #aFileOffset and
                                              provide a new buffer for further processing.
    @retval          #BCM_ERR_TIME_OUT        If the configured number of retry was done and
                                              no response was received from remote end.
    @retval          #BCM_ERR_NOPERM          No permission to read the specified file.
    @retval          #BCM_ERR_NOT_FOUND       When the File to be read is not found.
    @retval          #BCM_ERR_INVAL_STATE     If this call is made without issuing a
                                              TFTP read/recv request.
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid.
    @retval          #BCM_ERR_INVAL_PARAMS    aContext/aBuf/aFilledBufLen is NULL or
                                              if aBufLen is 0UL.

    @post Component shall remain in #TFTP_STATE_READ/#TFTP_STATE_RECV
    in case of no errors. In case of any error or on successful completion
    of the request, it will move to #TFTP_STATE_INIT.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_GetDataHandler(TFTP_ContextType* const aContext,
                            uint8_t* const aBuf,
                            const uint32_t aBufLen,
                            uint32_t * const aFilledBufLen);

/** @brief Function to process and get the status of the pending
    WRITE request of the TFTP client and the SEND request
    of the TFTP server.

    This API processes sending out the data packets to the remote TFTP
    Client/Server based on the use case. It is responsible for processing
    ACK, detecting timeout, resending packets and handling detected errors.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_WRITE#TFTP_STATE_SEND.

    @param[in]       aContext                 TFTP context structure.
    @param[in]       aBuf                     Buffer to which data needs to be read.
    @param[in]       aBufLen                  Length of the data buffer in bytes.
    @param[out]      aProcLen                 Size of data in bytes which has been
                                              processed from #aBuf.
    @param[in]       aIsEndOfFile             Boolean flag to indicate if this is the last
                                              buffer fragment for the file to be transferred

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              File transfer completed successfully.
    @retval          #BCM_ERR_BUSY            Operation is under progress. Needs to be
                                              called again on an event notification.
    @retval          #BCM_ERR_UNKNOWN         Error from remote end for
                                              1. Not defined error
                                              2. Illegal TFTP operation
                                              3. Unknown transfer ID
                                              4. No such user
    @retval          #BCM_ERR_INVAL_BUF_STATE if the remote end is out of memory to write data.
    @retval          #BCM_ERR_TIME_OUT        If the configured number of retry was done and
                                              no response was received from remote end.
    @retval          #BCM_ERR_NOPERM          1. No permission to write the file
                                              2. no permission to overwrite an existing file
    @retval          #BCM_ERR_INVAL_STATE     If this call is made without issuing a
                                              TFTP write/send request.
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid.
    @retval          #BCM_ERR_INVAL_PARAMS    aContext/aBuf/aProcLen is NULL or
                                              if aBufLen is 0UL.

    @post Component shall remain in #TFTP_STATE_WRITE/#TFTP_STATE_SEND
    in case of no errors. In case of any error or on successful completion
    of the transfer request (file less than block size), it will
    move to #TFTP_STATE_INIT.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_PutDataHandler(TFTP_ContextType* const aContext,
                            const uint8_t* const aBuf,
                            const uint32_t aBufLen,
                            uint32_t* const aProcLen,
                            const uint32_t aIsEndOfFile);


/** @brief De-Initialize the TFTP connection

    This API deinitializes the TFTP context structure by resetting all
    internal variables and state.

    @behavior Sync, Reentrant

    @pre Component shall be in #TFTP_STATE_PROCESS or #TFTP_STATE_INIT.

    @param[in]       aContext                 TFTP context structure.

    Return values are documented in reverse-chronological order
    @retval          #BCM_ERR_OK              De-Initialization is successfull
    @retval          #BCM_ERR_INVAL_MAGIC     Magic in aContext is invalid
    @retval          #BCM_ERR_INVAL_PARAMS    aContext is NULL

    @post Component move to #TFTP_STATE_RESET on success.

    @trace #BRCM_SWREQ_TFTP
*/
int32_t TFTP_DeInit(TFTP_ContextType* const aContext);

_Static_assert(TFTP_MAX_DATA_LEN <= TFTP_SUPPORTED_MAX_DATA_LEN, "TFTP_MAX_DATA_LEN value is out of range and not supported");

#endif /* TFTP_H */

/** @} */
