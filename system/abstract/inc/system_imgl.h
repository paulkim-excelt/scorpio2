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
    @defgroup grp_system_imgl_ifc Image Loader Interface
    @ingroup grp_system_abstract

    @addtogroup grp_system_imgl_ifc
    @{

    @limitations None

    @file system_imgl.h
    @brief System Image Loader Interface
    This header file contains the interface functions for System Image Loader Interface

    @version 1.0 Initial Version
*/

#ifndef SYSTEM_IMGL_H
#define SYSTEM_IMGL_H

#include <bcm_comp.h>
#include <module_msg.h>

/**
    @name System IMGL Architecture IDs
    @{
    @brief Architecture IDs for System IMGL
*/
#define BRCM_SWARCH_IMGL_ID_TYPE                        (0x8300U) /**< @brief #IMGL_IDType              */
#define BRCM_SWARCH_IMGL_ID_MACRO                       (0x8301U) /**< @brief #IMGL_ID                  */
#define BRCM_SWARCH_IMGL_MAX_SZ_MACRO                   (0x8302U) /**< @brief #IMGL_MSG_MAX_SIZE        */
#define BRCM_SWARCH_IMGL_CHANNEL_TYPE                   (0x8303U) /**< @brief #IMGL_ChannelType         */

#define BRCM_SWARCH_IMGL_UPDATE_AUTOSYNC_MSG_TYPE       (0x8340U) /**< @brief #IMGL_UpdateAutoSyncMsgType */
#define BRCM_SWARCH_IMGL_INFO_TYPE                      (0x8341U) /**< @brief #IMGL_ImgInfoType         */

#define BRCM_SWARCH_IMGL_MSG_UNION_TYPE                 (0x8380U) /**< @brief #IMGL_MsgUnionType        */
#define BRCM_SWARCH_IMGL_MSG_TYPE                       (0x8381U) /**< @brief #IMGL_MsgType             */

#define BRCM_SWARCH_IMGL_HOST_CONTEXT_TYPE              (0x83C0U) /**< @brief #IMGL_HostContextType     */
#define BRCM_SWARCH_IMGL_HOST_CONTEXT_SETUP_PROC        (0x83C1U) /**< @brief #IMGL_HostContextSetup    */
#define BRCM_SWARCH_IMGL_HOST_CONTEXT_PROCESS_PROC      (0x83C2U) /**< @brief #IMGL_HostContextProcess  */
#define BRCM_SWARCH_IMGL_HOST_HELPER_GLOBAL             (0x83C3U) /**< @brief #IMGL_HostHelper          */

/** @} */


/**
    @trace #BRCM_SWREQ_IMGL
*/
#define IMGL_MSG_MAX_SIZE  (256UL)
_Static_assert(IMGL_MSG_MAX_SIZE <= IMGL_RPC_MEM_MSG_PAYLOAD_SZ,
    "Ease of debug will be broken if the size is not properly aligned");

/**
    @brief IMGL ID construction macro

    @trace #BRCM_SWREQ_IMGL
*/
#define IMGL_ID(x) BCM_CMDID(BCM_GROUPID_SYS, BCM_IMG_ID, (x))

/**
    @name IMGL Message IDs
    @{
    @brief Message IDs for exchange on message queues and Host

    These are used for interaction over MSGQ interface and RPC commands.
    Hence, this must be within 8-bit space.

    @trace #BRCM_SWREQ_IMGL
*/
typedef BCM_CmdType IMGL_IDType;     /**< @brief IMGL message ID Type */
#define IMGL_ID_UPDATE_AUTO_SYNC        IMGL_ID(0x01U) /**< @brief #IMGL_UpdateAutoSyncMsgType  #FunctionRef            */
/** @} */

/**
    @name IMGL_ChannelType
    @{
    @brief IMGL Channel ID

    @trace #BRCM_SWREQ_IMGL
*/
typedef uint32_t IMGL_ChannelType;               /**< @brief Loader channel ID */
#define IMGL_CHANNEL_ID_INVALID  (0x00UL)        /**< @brief Invalid           */
#define IMGL_CHANNEL_ID_NVM_0    (0x4E564D30UL)  /**< @brief NVM 0             */
#define IMGL_CHANNEL_ID_NVM_1    (0x4E564D31UL)  /**< @brief NVM 1             */
#define IMGL_CHANNEL_ID_RPC_IPC  (0x52495043UL)  /**< @brief RPC IPC           */
#define IMGL_CHANNEL_ID_RPC_UDP  (0x52554450UL)  /**< @brief RPC UDP           */
/** @} */

#pragma pack(push, 4)

/**
    @brief Image info

    @trace #BRCM_SWREQ_IMGL
 */
typedef struct sIMGL_ImgInfoType {
    uint8_t  isImgHdr;  /**< @brief set to TRUE if image is only entires and optional signature */
    uint8_t  pid;       /**< @brief Partition ID                                                */
    uint16_t imgID;     /**< @brief Image ID                                                    */
    uint32_t imgMaxSize;/**< @brief Image max size that can be downloaded                       */
} IMGL_ImgInfoType;

/**
    @brief Image loader update with auto sync structure

    @trace #BRCM_SWREQ_IMGL
 */
typedef struct sIMGL_UpdateAutoSyncMsgType {
    uint32_t            flashId;
    uint32_t            flashAddr;
    uint32_t            numImgs;
    uint32_t            fetchChannel;
    IMGL_ImgInfoType    imgHdr[ITBL_MAX_NUM_ENTRIES];
} IMGL_UpdateAutoSyncMsgType;
_Static_assert(sizeof(IMGL_UpdateAutoSyncMsgType) <= IMGL_MSG_MAX_SIZE,
    "Ease of debug will be broken if the size is not properly aligned");

#pragma pack(pop)


/**
    @brief IMGL Union encapsulating all messages

    @trace #BRCM_SWREQ_IMGL
*/
typedef union uIMGL_MsgUnionType {
    uint32_t                        data[IMGL_MSG_MAX_SIZE/4UL];
    IMGL_UpdateAutoSyncMsgType      updateAutoSync;
} IMGL_MsgUnionType;

/**
    @brief Verity Union encapsulating all messages

    @trace #BRCM_SWREQ_IMGL
*/
typedef struct sIMGL_MsgType {
    uint32_t                    magic;
    BCM_CmdType                 id;
    int32_t                     status;
    uint32_t                    len;
    IMGL_MsgUnionType           u;
} IMGL_MsgType;


/**
    @brief IMGL Host Context Type

    -# state is expected to be set to UNINT by caller before initiating any
        Setup first time. Later setup calls will expect state to be either UNINIT
        or READY (which happens after processing is complete
    -# subState is used for internal consumption and must not be altered by caller
    -# status contains the result of operation after completion of processing
    -# msg contains any output that is returned for future referencing

    @trace #BRCM_SWREQ_IMGL
*/
typedef struct sIMGL_HostContextType {
    BCM_StateType               state;      /**< @brief Context State           */
    BCM_SubStateType            subState;   /**< @brief Context Sub State       */
    BCM_CmdType                 id;         /**< !brief Command/Response ID     */
    int32_t                     status;     /**< @brief final status of command */
    IMGL_MsgUnionType           msg;        /**< @brief Message input/output    */
} IMGL_HostContextType;

/**
    @brief Setup IMGL Host context

    @behavior Sync, Non-Rentrant

    @pre None

    @param[inout]   aContext        Context to be setup
    @param[in]      aSecYID         Command/Message Type
    @param[in]      aMsgPayload     Command/Message payload

    Return values are documented in reverse-chronological order
    @retval     BCM_ERR_OK              Setup for initialization complete
    @retval     BCM_ERR_INVAL_PARAMS    aContext is NULL or aInitMsg is NULL

    @post aContext.state is changes to RUNNING.

    @trace #BRCM_SWREQ_IMGL

    @limitations None
*/
int32_t IMGL_HostContextSetup(IMGL_HostContextType *aContext, IMGL_IDType aID,
                                    const IMGL_MsgUnionType *aMsgPayload);

/**
    @brief Process IMGL Host context

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

    @trace #BRCM_SWREQ_IMGL

    @limitations None
*/
int32_t IMGL_HostContextProcess(IMGL_HostContextType *aContext, int32_t aResponse,
                                        BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                        BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload);

/**
    @brief IMGL Host Helper Module

    @trace #BRCM_SWREQ_IMGL
*/
extern const MODULE_MsgConverterType IMGL_HostHelper;


#endif /* SYSTEM_IMGL_H */
/** @} */
