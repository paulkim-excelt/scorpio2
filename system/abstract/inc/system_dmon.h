/*****************************************************************************
 Copyright 2018-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_system_dmon_ifc Device Monitor Interface
    @ingroup grp_system_abstract

    @addtogroup grp_system_dmon_ifc
    @{

    @limitations None

    @file system_dmon.h
    @brief System Device Monitor Interface
    This header file contains the interface functions for System Device Monitor Interface

    @version 1.0 Initial Version
*/


#ifndef SYSTEM_DMON_H
#define SYSTEM_DMON_H

#include <stdint.h>
#include <stdlib.h>
#include <module_msg.h>

/**
    @name System Device Monitor Architecture IDs
    @{
    @brief Architecture IDs for System Device Monitor
*/
#define BRCM_SWARCH_DMON_MAX_MSG_SIZE_MACRO             (0x8200U)   /**< @brief #DMON_MAX_MSG_SIZE       */
#define BRCM_SWARCH_DMON_ID_MACRO                       (0x8201U)   /**< @brief #DMON_ID                 */
#define BRCM_SWARCH_DMON_ID_TYPE                        (0x8202U)   /**< @brief #DMON_IDType             */
#define BRCM_SWARCH_DMON_BOOT_MODE_TYPE                 (0x8203U)   /**< @brief #DMON_BootModeType       */
#define BRCM_SWARCH_DMON_SECURITY_MODE_TYPE             (0x8204U)   /**< @brief #DMON_SecurityModeType   */
#define BRCM_SWARCH_DMON_DEVICE_TYPE                    (0x8205U)   /**< @brief #DMON_DeviceType         */

#define BRCM_SWARCH_DMON_PING_MSG_TYPE                  (0x8240U)   /**< @brief #DMON_PingMsgType        */
#define BRCM_SWARCH_DMON_MEM_ACCESS_MSG_TYPE            (0x8241U)   /**< @brief #DMON_MemAccessMsgType   */
#define BRCM_SWARCH_DMON_SW_VERSION_STRLEN_MACRO        (0x8242U)   /**< @brief #DMON_SW_VERSION_STR_LEN */
#define BRCM_SWARCH_DMON_SW_VERSION_MSG_TYPE            (0x8243U)   /**< @brief #DMON_SwVersionMsgType   */
#define BRCM_SWARCH_DMON_HW_VERSION_MSG_TYPE            (0x8244U)   /**< @brief #DMON_HwVersionMsgType   */
#define BRCM_SWARCH_DMON_REBOOT_MSG_TYPE                (0x8245U)   /**< @brief #DMON_RebootMsgType      */
#define BRCM_SWARCH_DMON_HEART_BEAT_MSG_TYPE            (0x8246U)   /**< @brief #DMON_HeartBeatMsgType   */
#define BRCM_SWARCH_DMON_TIME_TYPE                      (0x8247U)   /**< @brief #DMON_TimeType           */
#define BRCM_SWARCH_DMON_SYNC_MSG_TYPE                  (0x8248U)   /**< @brief #DMON_SyncMsgType        */

#define BRCM_SWARCH_DMON_MSG_UNION_TYPE                 (0x8280U)   /**< @brief #DMON_MsgUnionType      */
#define BRCM_SWARCH_DMON_MSG_TYPE                       (0x8281U)   /**< @brief #DMON_MsgType           */

#define BRCM_SWARCH_DMON_HOST_CONTEXT_TYPE              (0x82C0U)   /**< @brief #DMON_HostContextType   */
#define BRCM_SWARCH_DMON_HOST_CONTEXT_SETUP_PROC        (0x82C1U)   /**< @brief #DMON_HostContextSetup  */
#define BRCM_SWARCH_DMON_HOST_CONTEXT_PROCESS_PROC      (0x82C2U)   /**< @brief #DMON_HostContextProcess*/
#define BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL             (0x82C3U)   /**< @brief #DMON_HostHelper        */
#define BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL         (0x82C4U)   /**< @brief #DMON_HostDbgHelper     */
#define BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL       (0x82C5U)   /**< @brief #DMON_HostAsyncHelper   */
/** @} */

/**
    @brief Device Monitor Max message size

    @trace #BRCM_SWREQ_DMON
*/
#define DMON_MAX_MSG_SIZE   (256UL)
_Static_assert(DMON_MAX_MSG_SIZE <= DMON_RPC_MEM_MSG_PAYLOAD_SZ,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @name DMN ID Macros
    @{
    @brief DMN ID construction macro

    @trace #BRCM_SWREQ_DMON
*/
#define DMON_ID(x)       BCM_CMDID(BCM_GROUPID_SYS, BCM_DMN_ID, (x))
#define DMON_ID_ASYNC(x) BCM_ASYNCID(BCM_GROUPID_SYS, BCM_DMN_ID, (x))
/** @} */

/**
    @name DMN Message IDs
    @{
    @brief Message IDs for exchange on message queues and Host

    These are used for interaction over MSGQ interface and RPC commands.
    Hence, this must be within 8-bit space.

    @trace #BRCM_SWREQ_DMON
*/
typedef BCM_CmdType DMON_IDType;     /**< @brief IMGL message ID Type */
#define DMON_ID_PING             DMON_ID(0x01U)   /**< @brief #DMON_PingMsgType        #None           */
#define DMON_ID_SYNC             DMON_ID(0x02U)   /**< @brief #DMON_SyncMsgType        #None           */

#define DMON_ID_MEM_WRITE        DMON_ID(0x10U)   /**< @brief #DMON_MemAccessMsgType   #DBGMEM_Write   */
#define DMON_ID_MEM_READ         DMON_ID(0x11U)   /**< @brief #DMON_MemAccessMsgType   #DBGMEM_Read    */

#define DMON_ID_SW_VERSION       DMON_ID(0x20U)   /**< @brief #DMON_SwVersionMsgType   #None           */
#define DMON_ID_HW_VERSION       DMON_ID(0x21U)   /**< @brief #DMON_HwVersionMsgType...#MCU_GetVersion */
#define DMON_ID_REBOOT           DMON_ID(0x22U)   /**< @brief #DMON_RebootMsgType      #MCU_RebootReq  */

#define DMON_ID_HEART_BEAT       DMON_ID_ASYNC(0x01U) /**< @brief #DMON_HeartBeatMsgType   #None       */
/** @} */

/**
   @name Device Master Slave ID
   @{
   @trace #BRCM_SWREQ_DMON
 */
typedef uint32_t DMON_DeviceType;
#define DMON_DEVICE_MASTER          (0UL)  /**< @brief Device master mode */
#define DMON_DEVICE_SLAVE_1         (1UL)  /**< @brief Device ID slave_1 mode */
#define DMON_DEVICE_SLAVE_2         (2UL)  /**< @brief Device ID slave_2 mode */
/** @} */

/**
    @brief Memory Access Message

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_MemAccessMsgType {
    uint32_t        addr;
    uint32_t        width;
    uint32_t        len;
    DMON_DeviceType deviceID;
    uint8_t         data[128UL];
} DMON_MemAccessMsgType;
_Static_assert(sizeof(DMON_MemAccessMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Software Version max length

    @trace #BRCM_SWREQ_DMON
*/
#define DMON_SW_VERSION_STR_LEN          (100UL)

/**
    @brief Software Version

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_SwVersionMsgType {
    char      str[DMON_SW_VERSION_STR_LEN];
} DMON_SwVersionMsgType;
_Static_assert(sizeof(DMON_SwVersionMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @name Device Security Mode Type
    @{
    @brief Device security modes

    @trace #BRCM_SWREQ_DMON
*/
typedef uint32_t DMON_SecurityModeType;     /**< @brief typedef for Device Security mode */
#define DMON_SECURITY_MODE_UNKNOWN (0x0UL)  /**< @brief Unknown mode */
#define DMON_SECURITY_MODE_NONE    (0x1UL)  /**< @brief Unsecured */
#define DMON_SECURITY_MODE_ECC     (0x2UL)  /**< @brief Secured through ECC */
#define DMON_SECURITY_MODE_RSA     (0x3UL)  /**< @brief Secured through RSA */
#define DMON_SECURITY_MODE_MAX     (DMON_SECURITY_MODE_RSA) /**< @brief Maximum mode value supported */
/** @} */

/**
    @brief Device Monitor HW version information structure

    @trace #BRCM_SWREQ_DMON
 */
typedef struct sDMON_HwVersionMsgType {
    uint32_t                manuf;  /**< @brief manufacturer ID */
    uint32_t                model;  /**< @brief model number */
    uint32_t                rev;    /**< @brief revision number */
    DMON_SecurityModeType   secMode;/**< @brief Security Mode */
} DMON_HwVersionMsgType;
_Static_assert(sizeof(DMON_HwVersionMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Ping Message (Response only, Command goes with empty payload)

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_PingMsgType {
    BCM_BootModeType        mode;           /**< @brief mode: ROM/BL/FW             */
    DMON_HwVersionMsgType   version;        /**< @brief HW version                  */
} DMON_PingMsgType;
_Static_assert(sizeof(DMON_PingMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Sync Message (Response only, Command goes with empty payload)

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_SyncMsgType {
    BCM_BootModeType        mode;           /**< @brief mode: ROM/BL/FW             */
    BCM_StateType           state;          /**< @brief state: UNINIT/INIT/READY/RUN*/
    DMON_HwVersionMsgType   version;        /**< @brief HW version                  */
} DMON_SyncMsgType;
_Static_assert(sizeof(DMON_PingMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Reboot Message

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_RebootMsgType {
    uint32_t            reserved[2UL];  /**< @brief left for legacy      */
    uint32_t            delayMs;        /**< @brief delay in milliseconds before rebooting */
} DMON_RebootMsgType;
_Static_assert(sizeof(DMON_RebootMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Time info

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_TimeType {
    uint32_t    s;
    uint32_t    ns;
} DMON_TimeType;

/**
    @brief Heartbeat Message

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_HeartBeatMsgType {
    uint32_t        version;
    uint32_t        state;
    DMON_TimeType   upTime;
    uint32_t        count;
    uint32_t        voltage;
    uint32_t        temperature;
    uint32_t        rsvd[57UL];
} DMON_HeartBeatMsgType;
_Static_assert(sizeof(DMON_HeartBeatMsgType) <= DMON_MAX_MSG_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief Device Monitor Union encapsulating all messages

    @trace #BRCM_SWREQ_DMON
*/
typedef union uDMON_MsgUnionType {
    uint32_t                data[DMON_MAX_MSG_SIZE/4UL];
    DMON_PingMsgType        ping;
    DMON_SyncMsgType        sync;
    DMON_MemAccessMsgType   memAccess;
    DMON_SwVersionMsgType   swVersion;
    DMON_HwVersionMsgType   hwVersion;
    DMON_RebootMsgType      reboot;
    DMON_HeartBeatMsgType   heartbeat;
} DMON_MsgUnionType;

/**
    @brief Device Monitor Structure for Message queue

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_MsgType {
    uint32_t                    magic;
    BCM_CmdType                 id;
    int32_t                     status;
    uint32_t                    len;
    DMON_MsgUnionType           u;
} DMON_MsgType;

/**
    @brief Device Monitor Host Context Type

    -# state is expected to be set to UNINT by caller before initiating any
        Setup first time. Later setup calls will expect state to be either UNINIT
        or READY (which happens after processing is complete
    -# subState is used for internal consumption and must not be altered by caller
    -# status contains the result of operation after completion of processing
    -# msg contains any output that is returned for future referencing

    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_HostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< !brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    DMON_MsgUnionType           msg;        /**< @brief Message input/output    */
} DMON_HostContextType;

/**
    @brief Setup Device Monitor Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_DMON

    @limitations None
*/
int32_t DMON_HostContextSetup(DMON_HostContextType *aContext, DMON_IDType aID,
                                    const DMON_MsgUnionType *aMsgPayload);

/**
    @brief Process Device Monitor Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aResponse       Response code received from RPC Message
    @param[in]      aInitMsg        Received message ID
    @param[in]      aInMsgPayload   Received message payload
    @param[out]     aOutMsgId       Next message ID
    @param[out]     aInitMsg        Next message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Process complete
    @retval     BCM_ERR_BUSY            Process is on going
    @retval     BCM_ERR_UNKNOWN         Integration fault
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInMsgPayload is NULL
                                        or aOutMsgId is NULL or aOutMsgPayload is NULL

    @post aContext.state is changes to RUNNING.

    @note aContext.u.status will reflect the error reported by the function referenced
    at @ref CRYPTO_SecYType, and any output will be reflected in the structure represented
    at @ref CRYPTO_SecYType.

    @trace #BRCM_SWREQ_DMON

    @limitations None
*/
int32_t DMON_HostContextProcess(DMON_HostContextType *aContext, int32_t aResponse,
                                        BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                        BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief Device Monitor Host Helper Module

    @trace #BRCM_SWREQ_DMON
*/
extern const MODULE_MsgConverterType DMON_HostHelper;

/**
    @brief Device Monitor Host Helper Module

    @trace #BRCM_SWREQ_DMON
*/
extern const MODULE_MsgConverterType DMON_HostDbgHelper;

/**
    @brief Device Monitor Host Helper Module

    @trace #BRCM_SWREQ_DMON
*/
extern const MODULE_MsgConverterType DMON_HostAsyncHelper;

#endif /* SYSTEM_DMON_H */
/** @} */
