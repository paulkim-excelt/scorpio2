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

 2. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE COMP_MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
******************************************************************************/

/**
    @defgroup grp_rpc_v2_mem_ifc Interface
    @ingroup grp_rpc_v2_mem

    @addtogroup grp_rpc_v2_mem_ifc
    @{
    RPC Memory abstracts memory handles for messages, streams (internal and
    external). The needed memory is allocated in this layer (as part of
    integration layer).

    @section sec_rpc_mem_seq Sequence Diagrams

    @tagseq rpc_mem_cmd_seq_diagram.svg "Command Sequence diagram"
    @startseq
    group {label = "Module"; color = "#EFFFFF"; Module;};
    group {label = "Interfaces"; color = "#FFEFFF"; Interface;};
    group {label = "Memory"; color = "#FFFFEF"; RPC_Mem;};
    Module => RPC_Mem [label = "RPC_MemInit"];
    Module => Interface [label = "SendMsg/RecvMsg/Process"] {
        Interface => RPC_Mem [label = "RPC_MsgAlloc", rightnote="to ensure there is a free message to read to"];
        Interface => RPC_Mem [label = "RPC_MsgScratch"];
        === Recv command into the scratch buffer===
        Interface => RPC_Mem [label = "RPC_MsgGet"];
        === Copy content from scratch to allocated buffer ===
        Interface => RPC_Mem [label = "RPC_Acquire", rightnote="required if the channel is lossy and handle preserved for retransmission"];
        Interface => RPC_Mem [label = "RPC_MsgGet"];
        === Send command to appropriate party===
        === Handle any retransmissions===
        Interface => RPC_Mem [label = "RPC_Release"]
    };
    Module => RPC_Mem [label = "RPC_MemDeinit"];
    @endseq


    @tagseq rpc_mem_strm_seq_diagram.svg "Stream Sequence diagram"
    @startseq
    group {label = "Module"; color = "#EFFFFF"; Module;};
    group {label = "Interfaces"; color = "#FFEFFF"; Interface;};
    group {label = "Memory"; color = "#FFFFEF"; RPC_Mem;};
    Module => RPC_Mem [label = "RPC_MemInit"];
    Module => Interface [label = "DetectStrm/ProcessStrm"] {
        Interface => RPC_Mem [label = "RPC_StrmAlloc"];
        Interface => RPC_Mem [label = "RPC_StrmGetCfg"];
        Interface => RPC_Mem [label = "RPC_StrmGetFreeSz"];
        === Get the actual data from appropriate layer (say IMGL)===
        Interface => RPC_Mem [label = "RPC_StrmWrite"];
        Interface => RPC_Mem [label = "RPC_StrmGetCfg"];
        Interface => RPC_Mem [label = "RPC_StrmGetFilledSz"];
        Interface => RPC_Mem [label = "RPC_StrmRead"];
        === Send the actual data on appropriate layer (say UDP)===
        === Handle any retransmissions===
        Interface => RPC_Mem [label = "RPC_Release"];
    };
    Module => RPC_Mem [label = "RPC_MemDeinit"];
    @endseq

    @limitations None

    @file rpc_mem.h
    @brief RPC Memory interface
    This header file contains the interface functions for RPC Memory
    @version 1.0 Initial Version
*/

#ifndef RPC_MEM_H
#define RPC_MEM_H

#include <stdint.h>
#include <bcm_err.h>
#include <module.h>
#include <pt_utils.h>
#include <mcu.h>

/**
    @name RPC Memory Architecture IDs
    @{
    @brief Architecture IDs for RPC Memory
*/
#define BRCM_SWARCH_RPC_MEM_MAX_CNT_MACRO               (0x8301U)    /**< @brief #RPC_MEM_MAX_CNT_MSG         */
#define BRCM_SWARCH_RPC_MAX_HANDLES_PER_MACRO           (0x8302U)    /**< @brief #RPC_MAX_HANDLES_PER_ASSOC   */
#define BRCM_SWARCH_RPC_INTERFACEID_TYPE                (0x8303U)    /**< @brief #RPC_InterfaceIdType         */
#define BRCM_SWARCH_RPC_ASSOCIATIONINDEX_TYPE           (0x8304U)    /**< @brief #RPC_AssociationIndexType    */
#define BRCM_SWARCH_RPC_MEM_INIT_PROC                   (0x8305U)    /**< @brief #RPC_MemInit                 */
#define BRCM_SWARCH_RPC_HDL_TYPE                        (0x8306U)    /**< @brief #RPC_HdlType                 */
#define BRCM_SWARCH_RPC_MSG_VER_TYPE                    (0x8307U)    /**< @brief #RPC_MsgVerType              */
#define BRCM_SWARCH_RPC_MEM_MSG_TYPE                    (0x8308U)    /**< @brief #RPC_MemMsgType              */
#define BRCM_SWARCH_RPC_MSG_SCRATCH_PROC                (0x8309U)    /**< @brief #RPC_MsgScratch              */
#define BRCM_SWARCH_RPC_MSG_ALLOC_PROC                  (0x830AU)    /**< @brief #RPC_MsgAlloc                */
#define BRCM_SWARCH_RPC_MSG_GET_PROC                    (0x830BU)    /**< @brief #RPC_MsgGet                  */
#define BRCM_SWARCH_RPC_STRM_CONFIG_TYPE                (0x830CU)    /**< @brief #RPC_StrmCfgType             */
#define BRCM_SWARCH_RPC_STRM_ALLOC_PROC                 (0x830DU)    /**< @brief #RPC_StrmAlloc               */
#define BRCM_SWARCH_RPC_STRM_GET_CFG_PROC               (0x830EU)    /**< @brief #RPC_StrmGetCfg              */
#define BRCM_SWARCH_RPC_STRM_FREE_SZ_PROC               (0x830FU)    /**< @brief #RPC_StrmGetFreeSz           */
#define BRCM_SWARCH_RPC_STRM_FILLED_SZ_PROC             (0x8310U)    /**< @brief #RPC_StrmGetFilledSz         */
#define BRCM_SWARCH_RPC_STRM_WRITE_PROC                 (0x8311U)    /**< @brief #RPC_StrmWrite               */
#define BRCM_SWARCH_RPC_STRM_READ_PROC                  (0x8312U)    /**< @brief #RPC_StrmRead                */
#define BRCM_SWARCH_RPC_ACQUIRE_PROC                    (0x8313U)    /**< @brief #RPC_Acquire                 */
#define BRCM_SWARCH_RPC_RELEASE_PROC                    (0x8314U)    /**< @brief #RPC_Release                 */
#define BRCM_SWARCH_RPC_MEM_DEINIT_PROC                 (0x8315U)    /**< @brief #RPC_MemDeinit               */
#define BRCM_SWARCH_RPC_MEM_GETTYPE_PROC                (0x8316U)    /**< @brief #RPC_MemGetType              */
#define BRCM_SWARCH_RPC_MEMSTRMCLIENTINFO_TYPE          (0x8317U)    /**< @brief #RPC_MemStrmClientInfoType   */
#define BRCM_SWARCH_RPC_STRMGETSLAVECLIENTINFO_PROC     (0x8318U)    /**< @brief #RPC_StrmGetSlaveClientInfo  */
#define BRCM_SWARCH_RPC_STRMGETMASTERCLIENTINFO_PROC    (0x8319U)    /**< @brief #RPC_StrmGetMasterClientInfo */
#define BRCM_SWARCH_RPC_MEMMSG_MAGIC_MACRO              (0x831AU)    /**< @brief #RPC_MEMMSG_MAGIC            */
#define BRCM_SWARCH_RPC_MEMPUSHAPPINFO_PROC             (0x831BU)    /**< @brief #RPC_MemPushAppInfo          */
#define BRCM_SWARCH_RPC_MEMPOPAPPINFO_PROC              (0x831CU)    /**< @brief #RPC_MemPopAppInfo           */
#define BRCM_SWARCH_RPC_MEMPEEKAPPINFO_PROC             (0x831DU)    /**< @brief #RPC_MemPeekAppInfo          */
#define BRCM_SWARCH_RPC_MEMGETINDEX_PROC                (0x831EU)    /**< @brief #RPC_MemGetIndex             */
#define BRCM_SWARCH_RPC_GETSTREAMSTATUS_PROC            (0x831FU)    /**< @brief #RPC_GetStreamStatus         */
#define BRCM_SWARCH_RPC_STRM_PEEK_PROC                  (0x8320U)    /**< @brief #RPC_StrmPeek                */
#define BRCM_SWARCH_RPC_STRMSETXFERSIZE_PROC            (0x8321U)    /**< @brief #RPC_StrmSetXferSize         */
#define BRCM_SWARCH_RPC_MSGPUSHPAPPINFO_PROC            (0x8322U)    /**< @brief #RPC_MsgPushAppInfo          */
#define BRCM_SWARCH_RPC_MSGPOPPAPPINFO_PROC             (0x8323U)    /**< @brief #RPC_MsgPopAppInfo           */
#define BRCM_SWARCH_RPC_MSGINIT_PROC                    (0x8324U)    /**< @brief #RPC_MsgInit                 */
#define BRCM_SWARCH_RPC_PING_TYPE                       (0x8325U)  /**< @brief #RPC_PingType            */
#define BRCM_SWARCH_RPC_CMDIDVAL_TYPE                   (0x8326U)  /**< @brief #RPC_CmdIdValType        */
#define BRCM_SWARCH_RPC_STREAM_VERSION_TYPE             (0x8327U)  /**< @brief #RPC_StreamVersionType   */
/** @} */

/**
    @name RPC Command IDs
    @{
    @brief RPC Command IDs

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint8_t RPC_CmdIdValType;
#define RPC_CMDIDVAL_PING                (0x01U)  /**< @brief PING */
#define RPC_CMDIDVAL_DWNLD_IMG_HDR_V1    (0x02U)  /**< @brief Image Header */
#define RPC_CMDIDVAL_DWNLD_IMG_V1        (0x03U)  /**< @brief Image */
#define RPC_CMDIDVAL_DWNLD_IMG_HDR_V2    (0x04U)  /**< @brief Image Header - V2 */
#define RPC_CMDIDVAL_DWNLD_IMG_V2        (0x05U)  /**< @brief Image - V2 */
#define RPC_CMDIDVAL_IMAGE_FETCH_V1      (0x10U)  /**< @brief Fetch */
#define RPC_CMDIDVAL_IMAGE_PART_FETCH_V1 (0x11U)  /**< @brief Part Fetch */
#define RPC_CMDIDVAL_IMAGE_FETCH_V2      (0x12U)  /**< @brief Fetch - V2 */
#define RPC_CMDIDVAL_IMAGE_PART_FETCH_V2 (0x13U)  /**< @brief Part Fetch - V2 */
#define RPC_CMDIDVAL_TABLE_FETCH_V1      (0x20U)  /**< @brief Fetch Image/Partition Table */
#define RPC_CMDIDVAL_DEBUG               (0x40U)  /**< @brief DEBUG    */
#define RPC_CMDIDVAL_EXECUTE             (0x80U)  /**< @brief Execute setup     */
#define RPC_CMDIDVAL_IMGL_HDR_REQ        (0x81U)  /**< @brief Get image headers */
#define RPC_CMDIDVAL_GET_ASYNC_MSG       (0x82U)  /**< @brief Get Async message */
/** @} */

/**
    @name RPC Stream version type
    @{
    @brief RPC Stream version
    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint32_t RPC_StreamVersionType;
#define RPC_STREAM_VERSION_INVALID        (0x0UL)  /**< @brief invalid */
#define RPC_STREAM_VERSION_1              (0x1UL)  /**< @brief Legacy  */
#define RPC_STREAM_VERSION_2              (0x2UL)  /**< @brief V2      */
/** @} */

/**
    @brief RPC Ping Type

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_PingType {
    uint32_t        mode;       /**< mode: Firmware/Bootloader */
    MCU_VersionType version;    /**< MCU version */
} RPC_PingType;

/**
    @name RPC Memory Max counts
    @{
    @brief RPC Memory Max Counts

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define RPC_MEM_MAX_CNT_MSG     (32UL)      /**< @brief Max Messages         */
#define RPC_MEM_MAX_CNT_STRM    (32UL)      /**< @brief Max Streams          */
#define RPC_MEM_MAX_CNT_APPINFO (4UL)       /**< @brief Max Appinfo per hdl  */
/** @} */

/**
    @brief Maximum number of interfaces

    @limitations This is limited to 15 as RPC Mem uses 4-bit field for CLIENT ID

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint32_t RPC_InterfaceIdType;
#define RPC_INTERFACEID_0   (0UL)
#define RPC_INTERFACEID_1   (1UL)
#define RPC_INTERFACEID_2   (2UL)
#define RPC_INTERFACEID_3   (3UL)
#define RPC_INTERFACEID_4   (4UL)
#define RPC_INTERFACEID_5   (5UL)
#define RPC_INTERFACEID_6   (6UL)
#define RPC_INTERFACEID_7   (7UL)
#define RPC_INTERFACEID_MAX (8UL)

/**
    @brief RPC Association Index type

    Interface's association index

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint32_t RPC_AssociationIndexType;
#define RPC_ASSOCIATIONINDEX_0    (0UL)  /**< @brief IPC/UDP Slave , MSGQ(RPC) Master */
#define RPC_ASSOCIATIONINDEX_1    (1UL)  /**< @brief IPC/UDP Master , MSGQ(RPC) Slave */
#define RPC_ASSOCIATIONINDEX_MAX  (2UL)  /**< @brief Max Associations                 */

/**
    @brief Maximum number of handles per Association

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define RPC_MAX_HANDLES_PER_ASSOC   ((RPC_MEM_MSG_COUNT) / (RPC_ASSOCIATIONINDEX_MAX))

/** @brief Initialize RPC Memory

    Initialize RPC Memory block, its internal context and data strcutures

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return void

    @post All internal data structures are initialized to start with a clean slate

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
void RPC_MemInit(void);

/**
    @name RPC Memory Handle Type
    @{
    @brief RPC Memory Handle

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint32_t RPC_HdlType;                 /**< @brief RPC Memory Handle Type      */
#define RPC_HDL_IDX_MASK      (0xFFUL)        /**< @brief Mask for Index in the pool  */
#define RPC_HDL_IDX_SHIFT     (0UL)           /**< @brief Shift for Index in the pool */
#define RPC_HDL_TYPE_MASK     (0xF00UL)       /**< @brief Mask for Type of pool       */
#define RPC_HDL_TYPE_SHIFT    (8UL)           /**< @brief Shift for Type of pool      */
#define RPC_HDL_TYPE_MSG      (1UL)           /**< @brief Msg type pool               */
#define RPC_HDL_TYPE_STRM     (4UL)           /**< @brief Stream type pool            */
#define RPC_HDL_SLAVEID_MASK  (0xF000UL)      /**< @brief Slave ID  (Source ID)       */
#define RPC_HDL_SLAVEID_SHIFT (12UL)          /**< @brief Slave ID  (Source ID)       */
#define RPC_HDL_MASTERID_MASK  (0xF0000UL)    /**< @brief Master ID (Dest ID)         */
#define RPC_HDL_MASTERID_SHIFT (16UL)         /**< @brief Master ID (Dest ID)         */
#define RPC_HDL_KEY_MASK      (0xFFF00000UL)  /**< @brief Uniqueness Key Mask         */
#define RPC_HDL_HASH_SHIFT    (20UL)          /**< @brief Uniqueness Key shift        */
#define RPC_HDL_INVALID       (0x0UL)         /**< @brief Invalid handle              */
/** @} */

/**
    @name RPC Message Version Type
    @{
    @brief RPC Message Version Type

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef uint32_t RPC_MsgVerType;        /**< @brief RPC Message Version Type    */
#define RPC_MSG_VER_MINOR_MASK  (0xFFUL)/**< @brief Mask for Index in the pool  */
#define RPC_MSG_VER_MINOR_SHIFT (0UL)   /**< @brief Shift for Index in the pool */
#define RPC_MSG_VER_MAJOR_MASK  (0xFF00UL)/**< @brief Mask for Index in the pool  */
#define RPC_MSG_VER_MAJOR_SHIFT (8UL)   /**< @brief Shift for Index in the pool */
#define RPC_MSG_VER_LEGACY      (0UL)   /**< @brief Legacy message type         */
#define RPC_MSG_VER_1_0         (0x0100UL)  /**< @brief Version 1.0             */
/** @} */

/**
    @brief Magic for RPC_MemMsgType

    @trace #BRCM_SWREQ_RPC_MEM
*/
#define RPC_MEMMSG_MAGIC        (0x5250434DUL)

/**
    @brief RPC Message Type

    'appinfo' stores the received application magic
    and use the same when it send the response.

    @todo Temporary name to avoid conflict with existing code.
    To be changed to RPC_MsgType later

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemMsgType {
    uint32_t        magic;          /**< @brief magic holding RPCM ASCII    */
    RPC_MsgVerType  version;        /**< @brief Version                     */
    BCM_CmdType     cmd;            /**< @brief Command ID                  */
    uint32_t        timeoutMs;      /**< @brief Timeout value in ms         */
    int32_t         response;       /**< @brief Response Code               */
    uint32_t        len;            /**< @brief Command payload length      */
    uint32_t        appinfoTop;     /**< @brief appinfo top position        */
    uint32_t        appinfo[RPC_MEM_MAX_CNT_APPINFO];
                                    /**< @brief Application Information     */
    uint32_t        rsvd;           /**< @brief Reserved filed used in IPC  */
    uint8_t         payload[RPC_MEM_MSG_PAYLOAD_SZ];  /**< @brief Payload */
} RPC_MemMsgType;

/**
    @brief Handle type

    @trace #BRCM_SWREQ_RPC_MEM
*/
static inline uint8_t RPC_MemGetType(RPC_HdlType aHdl)
{
        return (uint8_t)((aHdl & RPC_HDL_TYPE_MASK) >> RPC_HDL_TYPE_SHIFT);
}

/**
    @brief Memory pool index type

    @trace #BRCM_SWREQ_RPC_MEM
*/
static inline uint8_t RPC_MemGetIndex(RPC_HdlType aHdl)
{
        return (uint8_t)((aHdl & RPC_HDL_IDX_MASK) >> RPC_HDL_IDX_SHIFT);
}


/** @brief Get Scratch Message for temporary use

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return RPC_MemMsgType pointer

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations This is just a scratch message. It shall be used with caution
    as there is no protection on this buffer
*/
RPC_MemMsgType* RPC_MsgScratch(void);

/** @brief Allocate/Clone a Message Handle

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aInHdl      RPC_HDL_INVALID for creating a new handle.
                                If valid handle is provided, it will be cloned
    @param[in]      aSlaveID    Slave Interface ID
    @param[in]      aMasterID   Master Interface ID
    @param[in]      aAssocID    Association ID
    @param[out]     aOutHdl     A cloned msg handle if aHdl is valid,
                                A new msg handle if aHdl is RPC_HDL_INVALID

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success (aOutHdl will be vaild)
    @retVal     #BCM_ERR_NOMEM          No free handles/msgs are available
    @retval     #BCM_ERR_INVAL_PARAMS   (aInHdl is not a valid message handle) or
                                        (aOutHdl is NULL)

    @post describe post condition (status after execution of the function)

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_MsgAlloc(RPC_HdlType aInHdl,
                            RPC_InterfaceIdType aSlaveID,
                            RPC_InterfaceIdType aMasterID,
                            RPC_AssociationIndexType aAssocID,
                            RPC_HdlType *aOutHdl);


/** @brief Get Message content for a handle

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Message Handle

    @return RPC_MemMsgType pointer if aHdl is a valid Message handle,
            NULL otherwise

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
RPC_MemMsgType* RPC_MsgGet(RPC_HdlType aHdl);

/**
    @brief RPC Stream Config Type

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_StrmCfgType {
    PTBL_IdType     pid;        /**< @brief Partition ID            */
    uint16_t        imgId;      /**< @brief Image ID                */
    uint32_t        offset;     /**< @brief Offset within image     */
    uint32_t        isTbl;      /**< @brief Image Table or not      */
    uint32_t        xferSize;   /**< @brief Full Transfer size      */
    uint32_t        blkSize;    /**< @brief Block Size used for xfer*/
    uint32_t        isRead;     /**< @brief Is the module matching
                                    CID0 and CID1 supposed to read
                                    from this stream                */
    RPC_HdlType     peerHdl;    /**< @brief Peer's handle           */
    uint32_t        partial;    /**< @brief FALSE: Full Fetch
                                            TRUE: Partial Fetch     */
} RPC_StrmCfgType;

/**
    @brief RPC Stream client information Type

    @trace #BRCM_SWREQ_RPC_MEM
*/
typedef struct sRPC_MemStrmClientInfoType {
    BCM_SubStateType state;               /**< @brief Stream state (interface should set this to
                                                BCM_STATE_SUB_STATE_DONE after completion/error) */
    int32_t          pendingRespCode;     /**< @brief Response code of the last processed packet */
    RPC_HdlType      pendingMsgHdl;       /**< @brief Message handle of stream packet that
                                               is pending processing */
    RPC_HdlType      peerHdl;             /**< @brief Peer handle */
    RPC_StreamVersionType strmVer;        /**< @brief Stream version */
} RPC_MemStrmClientInfoType;

/** @brief Allocate a stream handle

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aConfig     Stream configuration
    @param[in]      aSlaveID    Slave Interface ID
    @param[in]      aMasterID   Master Interface ID
    @param[in]      aAssocID    Association ID
    @param[out]     aOutHdl     Stream Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success (aOutHdl will be vaild)
    @retVal     #BCM_ERR_NOMEM          No free handles/streams are available
    @retval     #BCM_ERR_INVAL_PARAMS   (aConfig is NULL) or
                                        (aOutHdl is NULL)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmAlloc(RPC_StrmCfgType * aConfig,
                            RPC_InterfaceIdType aSlaveID,
                            RPC_InterfaceIdType aMasterID,
                            RPC_AssociationIndexType aAssocID,
                            RPC_HdlType *aOutHdl);


/** @brief Get Stream configuration

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[out]     aCfg        Stream configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_PARAMS   (aHdl is invalid or stale) or
                                        (aCfg is NULL)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmGetCfg(RPC_HdlType aHdl, RPC_StrmCfgType *aCfg);

/** @brief Set Stream transfer size

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl                 Handle to stream
    @param[in]      aTransferSize        Transfer size in bytes

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is invalid or stale

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmSetXferSize(RPC_HdlType aHdl, uint32_t aTransferSize);

/** @brief Free space in the stream buffer

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[out]     aSize       size available to write
    @param[out]     aTotalSize  Total size written so far

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_STATE    (buffer associated with aIdx is not active)
    @retval     #BCM_ERR_INVAL_PARAMS   (aSize is NULL) or
                                        (aTotalSize is NULL) or
                                        (aHdl is invalid or stale)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmGetFreeSz(RPC_HdlType aHdl, uint32_t *aSize,
                          uint32_t *aTotalSize);

/** @brief Filled size in the stream (that can be read out)

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[out]     aSize       size available to read
    @param[out]     aTotalSize  Total size read so far

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Success
    @retval     #BCM_ERR_INVAL_STATE    (buffer associated with aIdx is not active)
    @retval     #BCM_ERR_INVAL_PARAMS   (aSize is NULL) or
                                        (aTotalSize is NULL) or
                                        (aHdl is invalid or stale)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmGetFilledSz(RPC_HdlType aHdl, uint32_t *aSize,
                            uint32_t *aTotalSize);

/** @brief Get the stream client information for the connected slave

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]       aHdl         Handle to stream

    Return values are documented in reverse-chronological order
    @retval     Client information      On success
                of the slave
    @retval     NULL                    aHdl is 0
                                        aHdl is stale
                                        aHdl is not a stream handle

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
RPC_MemStrmClientInfoType* RPC_StrmGetSlaveClientInfo(RPC_HdlType aHdl);

/** @brief Get the stream client information for the connected master

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]       aHdl         Handle to stream

    Return values are documented in reverse-chronological order
    @retval     Client information      On success
                of the master
    @retval     NULL                    aHdl is 0
                                        aHdl is stale
                                        aHdl is not a stream handle

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
RPC_MemStrmClientInfoType* RPC_StrmGetMasterClientInfo(RPC_HdlType aHdl);


/** @brief Write data to stream

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[in]      aBuffer     input buffer to write the content from
    @param[in]      aSize       Size of aBuffer that can be written

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Write Successful, and xfer completed
    @retval     #BCM_ERR_NOMEM          Write successful, xfer still pending
    @retval     #BCM_ERR_INVAL_STATE    (buffer associated with aIdx is not active)
    @retval     #BCM_ERR_INVAL_PARAMS   (aBuffer is NULL) or
                                        (aHdl is invalid or stale) or
                                        (Total copy size is more than transfer length)
    @retval     #BCM_ERR_UNKNOWN        available space is not enough for aSize

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmWrite(RPC_HdlType aHdl, const uint8_t *aBuffer, uint32_t aSize);

/** @brief Read content from stream

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[out]     aBuffer     Output buffer to read the content to
    @param[in]      aSize       Size of aBuffer that can be read to
    @param[out]     aOutSIze    Size of aBuffer that is actually updated

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Read Successful, and xfer completed
    @retval     #BCM_ERR_NOMEM          Read successful, xfer still pending
    @retval     #BCM_ERR_BUSY           Stream is still being loaded
    @retval     #BCM_ERR_INVAL_STATE    (buffer associated with aIdx is not active)
    @retval     #BCM_ERR_INVAL_PARAMS   (aBuffer is NULL) or
                                        (aOutSize is NULL) or
                                        (aHdl is invalid or stale) or
                                        (Total copy size is more than transfer length)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmRead(RPC_HdlType aHdl, uint8_t *aBuffer,
                        uint32_t aSize, uint32_t *aOutSIze);

/** @brief Peek content from stream

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Handle to stream
    @param[out]     aBuffer     Output buffer to read the content to
    @param[in]      aSize       Size of aBuffer that can be read to
    @param[out]     aOutSIze    Size of aBuffer that is actually updated

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Read Successful, and xfer completed
    @retval     #BCM_ERR_NOMEM          Read successful, xfer still pending
    @retval     #BCM_ERR_BUSY           Stream is still being loaded
    @retval     #BCM_ERR_INVAL_STATE    (buffer associated with aIdx is not active)
    @retval     #BCM_ERR_INVAL_PARAMS   (aBuffer is NULL) or
                                        (aOutSize is NULL) or
                                        (aHdl is invalid or stale)

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_StrmPeek(RPC_HdlType aHdl, uint8_t *aBuffer,
                     uint32_t aSize, uint32_t *aOutSIze);

/** @brief Increment reference count and avoid free up

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Memory handle to acquire

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Acquired
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is invalid or stale

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_Acquire(RPC_HdlType aHdl);

/** @brief Decrement reference count and free upon zero

    Client shall not preserve or access this handle after this call

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Memory handle to release/free

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Released/Freed
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is invalid or stale

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
int32_t RPC_Release(RPC_HdlType aHdl);

/** @brief Deinitialize RPC Memory

    @behavior Sync, Non-reentrant

    @pre RPC Memory is in initialized state

    @param[in]      void

    @return void

    @post RPC Memory is in deinitialized state

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
void RPC_MemDeinit(void);

/** @brief Push AppInfo

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Message handle
    @param[in]      aAppInfo    AppInfo to add

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully added
    @retval     #BCM_ERR_NOMEM          No space left to add
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is RPC_HDL_INVALID

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_MemPushAppInfo(RPC_HdlType aHdl, uint32_t aAppInfo);

/** @brief Peek AppInfo

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMsg        Message pointer
    @param[out]     aAppInfo    Pointer to retrieve AppInfo

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved
    @retval     #BCM_ERR_NOMEM          Nothing left to retrieve
    @retval     #BCM_ERR_INVAL_PARAMS   (aMsg is NULL) or
                                        aAppInfo is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_MemPeekAppInfo(RPC_MemMsgType *aMsg, uint32_t *aAppInfo);

/** @brief Pop AppInfo

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl        Message handle
    @param[out]     aAppInfo    Pointer to retrieve AppInfo

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved
    @retval     #BCM_ERR_NOMEM          Nothing left to retrieve
    @retval     #BCM_ERR_INVAL_PARAMS   (aHdl is RPC_HDL_INVALID) or
                                        aAppInfo is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_MemPopAppInfo(RPC_HdlType aHdl, uint32_t *aAppInfo);

/** @brief Push AppInfo

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMsg        Message Pointer
    @param[in]      aAppInfo    AppInfo to add

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully pushed
    @retval     #BCM_ERR_INVAL_PARAMS   aMsg is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_MsgPushAppInfo(RPC_MemMsgType* aMsg, uint32_t aAppInfo);

/** @brief Pop AppInfo

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMsg        Message Pointer
    @param[out]     aAppInfo    Pointer to retrieve AppInfo

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved
    @retval     #BCM_ERR_INVAL_PARAMS   (aMsg is NULL) or
                                        aAppInfo is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_MsgPopAppInfo(RPC_MemMsgType* aMsg, uint32_t *aAppInfo);

/** @brief Init RPC Message

    @behavior Sync, Non-reentrant

    @pre None

    @param[in/out]      aMsg        Message Pointer

    Return values are documented in reverse-chronological order
    @retval    void

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern void RPC_MsgInit(RPC_MemMsgType* aMsg);

/** @brief Get the stream processing status from slave and master interface

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aHdl            Message handle
    @param[out]     aSlaveState     Slave Stream state
    @param[out]     aMasterState    Master Stream state

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Successfully retrieved
    @retval     #BCM_ERR_INVAL_PARAMS   aHdl is RPC_HDL_INVALID or
                                        aHdl is not a stream handle
                                        aSlaveState is NULL
                                        aMasterState is NULL

    @post None

    @trace #BRCM_SWREQ_RPC_MEM

    @limitations None
*/
extern int32_t RPC_GetStreamStatus(RPC_HdlType aHdl,
                                   BCM_SubStateType *aSlaveState,
                                   BCM_SubStateType *aMasterState);

#endif /* RPC_MEM_H */

/** @} */
