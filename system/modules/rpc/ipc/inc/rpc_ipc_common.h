/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_rpc_ipc_common_ifc IPC Common Interface
    @ingroup grp_rpc_v2_ipc

    @addtogroup grp_rpc_ipc_common_ifc
    @{

    @file rpc_ipc_common.h
    @brief RPC IPC common interface for stream structures
    used by both IPC Master and IPC Slave Interfaces

    @version 0.1 Initial Version
*/

#ifndef RPC_IPC_COMMON_H
#define RPC_IPC_COMMON_H

#include <stdint.h>
#include <rpc_mem.h>

/**
    @name RPC IPC Common Architecture IDs
    @{
    @brief Architecture IDs for RPC IPC Common
*/
#define BRCM_SWARCH_RPC_RESPONSEMSG_TYPE               (0x8901U)    /**< @brief #RPC_ResponseMsgType         */
#define BRCM_SWARCH_RPC_IMGREQV2_TYPE                  (0x8902U)    /**< @brief #RPC_ImgReqV2Type            */
#define BRCM_SWARCH_RPC_DWNLDHDRV2_TYPE                (0x8903U)    /**< @brief #RPC_DwnldHdrV2Type          */
#define BRCM_SWARCH_RPC_DWNLDIMAGE_TYPE                (0x8904U)    /**< @brief #RPC_DwnldImageType          */
#define BRCM_SWARCH_RPC_RESPONSECODE_TYPE              (0x8905U)    /**< @brief #RPC_ResponseCodeType        */
#define BRCM_SWARCH_RPC_STREAMDATA_PAYLOAD_SIZE_MACRO  (0x8906U)    /**< @brief #RPC_STREAMDATA_PAYLOAD_SIZE */
#define BRCM_SWARCH_RPC_IPC_STREAM_MAGIC_MACRO         (0x8907U)    /**< @brief #RPC_IPC_STREAM_MAGIC        */
#define BRCM_SWARCH_RPC_IMGREQV1_TYPE                  (0x8908U)    /**< @brief #RPC_ImgReqV1Type            */
#define BRCM_SWARCH_RPC_IMGPARTREQV1_TYPE              (0x8909U)    /**< @brief #RPC_ImgPartReqV1Type        */
#define BRCM_SWARCH_RPC_DWNLDHDRV1_TYPE                (0x890AU)    /**< @brief #RPC_DwnldHdrV1Type           */
/** @} */

/**
    @brief RPC IMGL Magic keyword

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
#define RPC_IPC_STREAM_MAGIC             (0x49504353UL) /**< @brief 'I''P''C''S' */

/**
    @brief RPC stream packet maximum payload length

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
#define RPC_STREAMDATA_PAYLOAD_SIZE      (384UL)        /**< @brief Max Stream payload length */

/**
    @brief RPC legacy response error code type

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef int32_t RPC_ResponseCodeType;

/**
    @brief RPC legacy response structure

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_ResponseMsgType {
    RPC_ResponseCodeType status;      /**< @brief Response error code */
    uint8_t              payload[sizeof(RPC_MemMsgType) - sizeof(RPC_ResponseCodeType)];
                                      /**< @brief Response payload */
} RPC_ResponseMsgType;

#pragma pack(push, 4)

/**
    @brief Image request identifying an image

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_ImgReqV1Type {
    uint8_t  isImgHdr;  /**< @brief set to TRUE if image is only entires and optional signature */
    uint8_t  pid;       /**< @brief Partition ID                                                */
    uint16_t imgID;     /**< @brief Image ID                                                    */
    uint32_t imgMaxSize;/**< @brief Image max size that can be downloaded                       */
} RPC_ImgReqV1Type;

/**
    @brief Image request identifying an image

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_ImgPartReqV1Type {
    uint8_t  isImgHdr;  /**< @brief set to TRUE if image is only entires and optional signature */
    uint8_t  pid;       /**< @brief Partition ID                                                */
    uint16_t imgID;     /**< @brief Image ID                                                    */
    uint32_t imgMaxSize;/**< @brief Image max size that can be downloaded                       */
    uint32_t offset;    /**< @brief offset                                                      */
} RPC_ImgPartReqV1Type;

/**
    @brief Image request identifying an image

    Used when sending an ASYNC message with RPC_CMDIDVAL_IMAGE_FETCH_V2 OR
    RPC_CMDIDVAL_IMAGE_PART_FETCH_V2 from IPC Slave to connected master

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_ImgReqV2Type {
    uint8_t           isTbl;          /**< @brief set to TRUE if image is only
                                           entires and optional signature */
    uint8_t           pid;            /**< @brief Partition ID */
    uint16_t          imgID;          /**< @brief Image ID */
    uint32_t          imgMaxSize;     /**< @brief Image max size that can
                                           be downloaded */
    uint32_t          targetStrmHdl;  /**< @brief Stream handle got from RPC MEM on the target device */
    uint32_t          offset;         /**< @brief offset is zero for full image fetch
                                           Valid offset to be specified for part image fetch */
} RPC_ImgReqV2Type;

/**
    @brief RPC Download image header type

    Used by IPC Master to send the image header details only
    on the image request from the IPC slave

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_DwnldHdrV2Type {
    uint32_t          magicNum;      /**< @brief IMGL_IMGH_MAGIC */
    uint8_t           pid;           /**< @brief Partition ID */
    uint8_t           rsv;           /**< @brief Reserved */
    uint16_t          imgID;         /**< @brief Image ID */
    uint32_t          imgSize;       /**< @brief Size of the image */
    RPC_HdlType       targetStrmHdl; /**< @brief Stream handle got from RPC MEM on the target device */
    RPC_HdlType       hostStrmHdl;   /**< @brief Stream handle got from RPC MEM on the host device */
    int32_t           response;      /**< @brief Response code from slave device */
} RPC_DwnldHdrV2Type;

/**
    @brief RPC Download image header type- v1

    Used by IPC Master to send the image header details only
    on the image request from the IPC slave

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_DwnldHdrV1Type {
    uint32_t          magicNum;      /**< @brief IMGL_IMGH_MAGIC */
    uint32_t          imgSize;       /**< @brief Size of the image */
    uint32_t          flags;         /**< @brief #IMGL_ImgFlagsType */
    uint64_t          errDetCode;    /**< @brief Error detection code */
} RPC_DwnldHdrV1Type;

/**
    @brief RPC Download image type

    Used to send one or more stream packets from IPC master to
    IPC slave to transfer the requested image

    @trace #BRCM_SWREQ_RPC_INTERFACE
 */
typedef struct sRPC_DwnldImageType {
    uint32_t          magicNum;      /**< @brief RPC_IPC_STREAM_MAGIC */
    uint8_t           pid;           /**< @brief Partition ID */
    uint8_t           rsv1;          /**< @brief Reserved */
    uint16_t          imgID;         /**< @brief Image ID */
    uint32_t          offset;        /**< @brief Offset of packet content in actual file */
    uint32_t          targetStrmHdl; /**< @brief Stream handle got from RPC MEM on the target device */
    uint32_t          hostStrmHdl;   /**< @brief Stream handle got from RPC MEM on the host device */
    uint32_t          len;           /**< @brief Length of stream data in payload - imgData */
    int32_t           response;      /**< @brief Response code from slave device */
    uint32_t          rsv2;          /**< @brief Reserved */
    uint8_t           imgData[RPC_STREAMDATA_PAYLOAD_SIZE];
                                     /**< @brief IMG data TODO : Macro usage for 384 */
} RPC_DwnldImageType;
#pragma pack(pop)

#endif /* RPC_IPC_COMMON_H */
/** @} */
