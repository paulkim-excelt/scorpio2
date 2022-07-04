/*****************************************************************************
 Copyright 2018-2021 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_imgl_interface_ifc Module Interface
    @ingroup grp_imgl_interface

    @addtogroup grp_imgl_interface_ifc
    @{
    Components which would like to support loading images over varous interfaces,
    shall expose a structure of @ref IMGL_InterfaceType, and shall be integrated
    into Image Loader according to the static priority of preference for the platform.

    @file imgl_interface.h
    @brief Image Loader Module Interfaces
    @version 0.8 Integrated Loader interface enhancements for executable fetch
    @version 0.1 Initial Version
*/

#ifndef IMGL_INTERFACE_H
#define IMGL_INTERFACE_H

#include <bcm_comp.h>
#include <bcm_err.h>
#include <pt_utils.h>
#include <msg_queue.h>
#include <imgl_version.h>
#include <crypto_common.h>
#include <system_imgl.h>

/**
    @name Image Loader Integration Interface IDs
    @{
    @brief Integration Interface IDs for Image Loader

*/
#define BRCM_SWARCH_IMGL_LOAD_MODE_TYPE       (0x8301U)    /**< @brief #IMGL_ModeType        */
#define BRCM_SWARCH_IMGL_STATE_TYPE           (0x8302U)    /**< @brief #IMGL_StateType       */
#define BRCM_SWARCH_IMGL_CHANNEL_IDX_TYPE     (0x8303U)    /**< @brief #IMGL_ChannelIdxType  */
#define BRCM_SWARCH_IMGL_IMGH_MACRO           (0x8304U)    /**< @brief #IMGL_IMGH_MAGIC      */
#define BRCM_SWARCH_IMGL_IMG_FLAGS_TYPE       (0x8305U)    /**< @brief #IMGL_ImgFlagsType    */
#define BRCM_SWARCH_IMGL_IMG_HDR_TYPE         (0x8306U)    /**< @brief #IMGL_ImgHdrType      */
#define BRCM_SWARCH_IMGL_ENTRY_POINT_TYPE     (0x8307U)    /**< @brief #IMGL_EntryPtType     */
#define BRCM_SWARCH_IMGL_GET_IMG_TBL_TYPE     (0x8308U)    /**< @brief #IMGL_GetImgTblType   */
#define BRCM_SWARCH_IMGL_GET_STATE_TYPE       (0x8309U)    /**< @brief #IMGL_GetStateType    */
#define BRCM_SWARCH_IMGL_READ_PTBL_TYPE       (0x830AU)    /**< @brief #IMGL_ReadPTBLType    */
#define BRCM_SWARCH_IMGL_READ_ITBL_TYPE       (0x830BU)    /**< @brief #IMGL_ReadITBLType    */
#define BRCM_SWARCH_IMGL_READ_IMG_TYPE        (0x830CU)    /**< @brief #IMGL_ReadImgType     */
#define BRCM_SWARCH_IMGL_ERASE_IMG_TYPE       (0x830DU)    /**< @brief #IMGL_EraseImgType    */
#define BRCM_SWARCH_IMGL_WRITE_IMG_TYPE       (0x830EU)    /**< @brief #IMGL_WriteImgType    */
#define BRCM_SWARCH_IMGL_GET_STATUS_TYPE      (0x830FU)    /**< @brief #IMGL_GetStatusType   */
#define BRCM_SWARCH_IMGL_MODE_HANDLER_TYPE    (0x8310U)    /**< @brief #IMGL_InterfaceType   */
/** @} */

/**
    @name Image Loader Modes
    @{
    @brief Image Loader Modes

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef uint32_t IMGL_ModeType;             /**< @brief Load Mode Type               */
#define IMGL_LOAD_MODE_MAX  (0x03UL)        /**< @brief Maximum number of interfaces */
#define IMGL_LOAD_MODE_NONE (0x00UL)        /**< @brief Load Mode None. Must be zero */
#define IMGL_LOAD_MODE_NVM  (0x4E564D20UL)  /**< @brief Load Mode NVM                */
#define IMGL_LOAD_MODE_RPC  (0x52504320UL)  /**< @brief Load Mode RPC                */
/** @} */

/**
    @name IMGL_ChannelIdxType
    @{
    @brief IMGL Channel index

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef uint32_t IMGL_ChannelIdxType;   /**< @brief Loader channel     */
#define IMGL_CHANNEL_IDX0     (0x00UL)  /**< @brief Channel 0          */
#define IMGL_CHANNEL_IDX1     (0x01UL)  /**< @brief Channel 1          */
#define IMGL_CHANNEL_IDX_MAX  (0x02UL)  /**< @brief Number of Channels */
/** @} */

/**
    @name IMGL_StateType
    @{
    @brief Loader State

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef uint32_t IMGL_StateType;            /**< @brief Loader state */
#define IMGL_STATE_UNINIT             (0UL) /**< @brief UNINIT state. This value must be zero   */
#define IMGL_STATE_INIT               (1UL) /**< @brief Initialized State                       */
#define IMGL_STATE_READY              (2UL) /**< @brief Ready to service Firmware load raw Requests*/
#define IMGL_STATE_RUNNING            (3UL) /**< @brief Running state to service Load Config images*/
/** @} */

/**
    @name IMGL_IMGH_Macros
    @{
    @brief IMGL Image macros

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
 */
#define IMGL_IMGH_MAGIC          (0x494D4748UL)  /**< @brief Loader Image header magic [IMGH]*/
#define IMGL_IMGH_IV_SIZE        (0x10UL)        /**< @brief Decryption Initial vector size  */
#define IMGL_IMGH_SIGN_MAX_SIZE  (0x100UL)       /**< @brief Signature size                  */
#define IMGL_IMGH_DWNLD_HDR_SIZE (20UL)          /**< @brief Download Img Hdr Size           */
/** @} */

/**
    @name IMGL_ImgFlagsType
    @{
    @brief IMGL Image Flags

    bits[1:0]: edc flag (0 for no edc / 1 for CRC / 2 for checksum)
    bit[2]: flash id (0 for internal flash or 1 for external flash)
    bits[10:3]: PID (Partition ID)
    bits[26:11]: Image ID (used for config image)
    bits[31:27]: reserved for future use

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
 */
typedef uint32_t IMGL_ImgFlagsType;
#define IMGL_IMG_FLAGS_EDC_MASK       (0x3UL)
#define IMGL_IMG_FLAGS_EDC_SHIFT      (0x0UL)
#define IMGL_IMG_FLAGS_EDC_NONE       (0x0UL)
#define IMGL_IMG_FLAGS_EDC_CRC        (0x1UL)
#define IMGL_IMG_FLAGS_EDC_CHECKSUM   (0x2UL)
#define IMGL_IMG_FLAGS_FLASH_MASK     (0x4UL)
#define IMGL_IMG_FLAGS_FLASH_SHIFT    (0x2UL)
#define IMGL_IMG_FLAGS_PID_MASK       (0xFF0UL)
#define IMGL_IMG_FLAGS_PID_SHIFT      (0x4UL)
#define IMGL_IMG_FLAGS_IMGID_MASK     (0xFFFF000UL)
#define IMGL_IMG_FLAGS_IMGID_SHIFT    (0xCUL)
/** @} */

#pragma pack(push, 4)

/**
    @brief IMGL Image header type

    Total size of this header is 512 bytes. 20 Bytes of IMGL_DwnldHdrType,
    32 byte of IV, 204 bytes of reserved space, 256 bytes of signature.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
 */
typedef struct sIMGL_ImgHdrType {
    uint32_t            magicNum;                       /**< @brief IMGL_IMGH_MAGIC */
    uint32_t            imgSize;                        /**< @brief Size of the image */
    IMGL_ImgFlagsType   flags;                          /**< @brief #IMGL_ImgFlagsType */
    uint64_t            errDetCode;                     /**< @brief Error detection code */
    uint8_t             iv[IMGL_IMGH_IV_SIZE];          /**< @brief Decryption IV   */
    CRYPTO_AlgoType     algo;                           /**< @brief Algorithm       */
    CRYPTO_AlgoType     hash;                           /**< @brief Hash Type       */
    CRYPTO_AlgoType     padding;                        /**< @brief Padding Type    */
    uint32_t            sigLen;                         /**< @brief Signature Length*/
    /* TODO : Keyhdl and keyauth? */
    uint8_t             reserved[76UL];                 /**< @brief reserved space  */
    IMGL_VersionType    version;                        /**< @brief version         */
    uint8_t             signature[IMGL_IMGH_SIGN_MAX_SIZE]; /**< @brief signature       */
} IMGL_ImgHdrType;

#pragma pack(pop)

/** @brief Get Specific Loader state

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return     Loader State as #IMGL_StateType

    @post None

    @trace  #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef IMGL_StateType (*IMGL_GetStateType)(void);

/** @brief get an image table

    This is a synchronous API which retrieves Image Table.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aImgTblID   8-bit Image Table ID

    @return     NULL if aImgTblID is invalid or not found or a valid Image Table pointer

    @post None

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE

    @limitations This API shall be called from the task context.
*/
typedef const ITBL_Type * (*IMGL_GetImgTblType)(uint8_t aImgTblID);

/** @brief Fetch Partition Table

   @behavior Sync, Non-reentrant

   @pre Mode specific loader is configured

   @param[in]       aChannel            Loader Channel ID
   @param[out]      aDownloadAddress    Download area address
   @param[in]       aMaxSize            Download area size
   @param[in]       aClientMask         Client event mask
   @param[out]      aHdr                message handle from server.
                                        Shall be used by the client in #IMGL_GetStatusType
                                        API to query the result of this request

   Return values are documented in reverse-chronological order
   @retval     #BCM_ERR_OK             Success
   @retval     #BCM_ERR_TIME_OUT       Timeout occurred
   @retval     #BCM_ERR_NODEV          Channel does not exist
   @retval     #BCM_ERR_INVAL_PARAMS   (aDownloadAddress is NULL) or
                                       (aHdr is NULL)

   @post Mode specific loader is configured

   @trace  #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef int32_t (*IMGL_ReadPTBLType)(IMGL_ChannelIdxType aChannel,
                                        uint32_t aDevAddr,
                                        uint8_t *aDownloadAddress,
                                        uint32_t aMaxSize,
                                        const uint32_t aClientMask,
                                        const MSGQ_MsgHdrType** const aHdr);

/** @brief Fetch Image Table

   @behavior Sync, Non-reentrant

   @pre Mode specific loader is configured

   @param[in]       aChannel            Loader Channel ID
   @param[in]       aPartID             Partition ID
   @param[in]       aITBLAddress        ITBL address fetched from PTBL
   @param[out]      aDownloadAddress    Download area address
   @param[in]       aMaxSize            Download area size
   @param[in]       aClientMask         Client event mask
   @param[out]      aHdr                message handle from server.
                                        Shall be used by the client in #IMGL_GetStatusType
                                        API to query the result of this request

   Return values are documented in reverse-chronological order
   @retval     #BCM_ERR_OK             Success
   @retval     #BCM_ERR_TIME_OUT       Timeout occurred
   @retval     #BCM_ERR_NODEV          Channel does not exist
   @retval     #BCM_ERR_INVAL_PARAMS   (aDownloadAddress is NULL) or
                                       (aHdr is NULL)

   @post Mode specific loader is configured

   @trace  #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef int32_t (*IMGL_ReadITBLType)(IMGL_ChannelIdxType aChannel,
                                       PTBL_IdType aPartID,
                                       uint32_t aITBLAddress,
                                       uint8_t *aDownloadAddress,
                                       uint32_t aMaxSize,
                                       const uint32_t aClientMask,
                                       const MSGQ_MsgHdrType** const aHdr);

/** @brief Request to fetch an image

    This is an asynchronous API which sends a message to appropriate Server.
    Upon the completion, client is signaled.

    Client shall call @ref IMGL_GetStatus API to get the status of the image load
    request.

    @behavior Async, Re-entrant

    @pre None

    @param[in]      aChannel    Loader Channel ID
    @param[in]      aPID        Partition ID
    @param[in]      aImgID      16-bit Image ID
    @param[in]      aImgAddr    32-bit address for Flash kind of modules
    @param[out]     aAddr       Address where image shall be loaded. It is
                                client's responsibility to ensure that this
                                address is valid until the load request is
                                completed by the server (upon the completion
                                of the load request, client shall be signaled
                                using @c aClientMask)
    @param[in]      aOffset     Offset, within the image, from where to load
    @param[in]      aBufSize    Size of the image
    @param[in]      aClientMask Client event mask
    @param[out]     aHdr        message handle from server.
                                Shall be used by the client in #IMGL_GetStatusType
                                API to query the result of this request

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request to Load image is accepted and
                                        shall be processed asynchronously. Upon
                                        completion of the request, client shall
                                        be signaled using @c aClientMask
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred
    @return     #BCM_ERR_NODEV          No Method to load image
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL or
                                        aBufSize is NULL or
                                        aAddr is NULL

    @post None

    @note To be implemented/used.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE

    @limitations This API shall be called from the task context.
*/
typedef int32_t (*IMGL_ReadImgType)(IMGL_ChannelIdxType aChannel,
                                        PTBL_IdType aPID,
                                        uint16_t    aImgID,
                                        uint32_t    aImgAddr,
                                        uint8_t *const aAddr,
                                        uint32_t    aOffset,
                                        uint32_t    aBufSize,
                                        const uint32_t aClientMask,
                                        const MSGQ_MsgHdrType** const aHdr);

/** @brief Request to erase an image

    This is an asynchronous API which sends a message to appropriate Server.
    Upon the completion, client is signaled.

    Client shall call @ref IMGL_GetStatus API to get the status of the image
    write request.

    @behavior Async, Re-entrant

    @pre None

    @param[in]      aChannel    Loader Channel ID
    @param[in]      aPID        Partition ID
    @param[in]      aImgID      16-bit Image ID
    @param[in]      aDevAddr    Device Address where to erase from
    @param[in]      aSize       Size to erase
    @param[in]      aClientMask Client event mask
    @param[out]     aHdr        message handle from server.
                                Shall be used by the client in #IMGL_GetStatusType
                                API to query the result of this request

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request to Write image is accepted and
                                        shall be processed asynchronously. Upon
                                        completion of the request, client shall
                                        be signaled using @c aClientMask
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred
    @return     #BCM_ERR_NODEV          No Method to erase image
    @return     #BCM_ERR_NOSUPPORT      Channel/Mode does not support erase
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL or
                                        aBufSize is 0 or
                                        aAddr is NULL

    @post None

    @note To be implemented/used.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE

    @limitations This API shall be called from the task context.
*/
typedef int32_t (*IMGL_EraseImgType)(IMGL_ChannelIdxType aChannel,
                                    PTBL_IdType aPID,
                                    uint16_t aImgID,
                                    uint32_t aDevAddr,
                                    uint32_t aSize,
                                    const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr);

/** @brief Request to write an image

    This is an asynchronous API which sends a message to appropriate Server.
    Upon the completion, client is signaled.

    Client shall call @ref IMGL_GetStatus API to get the status of the image
    write request.

    @behavior Async, Re-entrant

    @pre None

    @param[in]      aChannel    Loader Channel ID
    @param[in]      aPID        Partition ID
    @param[in]      aImgID      16-bit Image ID
    @param[in]      aImgAddr    Image address start (for Flash kind of module)
    @param[out]     aAddr       Address where image to be written is present.
                                It is client's responsibility to ensure that this
                                address is valid until the write request is
                                completed by the server (upon the completion
                                of the load request, client shall be signaled
                                using @c aClientMask)
    @param[in]      aOffset     offset within the image where to write to
    @param[in]      aBufSize    Size of the image to write
    @param[in]      aClientMask Client event mask
    @param[out]     aHdr        message handle from server.
                                Shall be used by the client in #IMGL_GetStatusType
                                API to query the result of this request

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request to Write image is accepted and
                                        shall be processed asynchronously. Upon
                                        completion of the request, client shall
                                        be signaled using @c aClientMask
    @retval     #BCM_ERR_TIME_OUT       Timeout occurred
    @return     #BCM_ERR_NODEV          No Method to load image
    @retval     #BCM_ERR_INVAL_PARAMS   aStatus is NULL or
                                        aBufSize is 0 or
                                        aAddr is NULL

    @post None

    @note To be implemented/used.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE

    @limitations This API shall be called from the task context.
*/
typedef int32_t (*IMGL_WriteImgType)(IMGL_ChannelIdxType aChannel,
                                    PTBL_IdType aPID,
                                    uint16_t    aImgID,
                                    uint32_t    aImgAddr,
                                    uint8_t *const aAddr,
                                    uint32_t    aOffset,
                                    uint32_t    aBufSize,
                                    const uint32_t aClientMask,
                                    const MSGQ_MsgHdrType** const aHdr);


/** @brief Get the status of Read/Erase/Write request

    @behavior Sync, Re-entrant

    @pre None

    @param[in]   aHdr               Message Handle
    @param[out]  aProcessedSize     Filled/Written size

    @return     #BCM_ERR_OK             Fetch/Write completed successfully
    @return     #BCM_ERR_BUSY           Fetch/Write is in progress
    @return     #BCM_ERR_NOT_FOUND      Image ID not found in aStatus->mode
    @return     #BCM_ERR_INVAL_STATE    Loader (of that mode) was not initialized
    @return     #BCM_ERR_DATA_INTEG     Data integrity check failed
    @return     #BCM_ERR_NOMEM          Insufficient memory

    @post TBD

    @note To be implemented/used.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE

    @limitations This API shall be called from the task context.
*/
typedef int32_t (*IMGL_GetStatusType)(const MSGQ_MsgHdrType *const aHdr,
                                    uint32_t *const aProcessedSize);

/** @brief Entry Point for loaded executable image

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]    void

    @return void

    @post None

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
*/
typedef void (*IMGL_EntryPtType)(void);

/**
    @brief Image Loader Function table for a specific interface

    Individual interfaces (like NVM, TFTP etc) shall implement a function
    table of this type to be integrated into Image Loader.

    @trace #BRCM_SWREQ_IMGL_FUNCTION_TABLE
 */
typedef struct sIMGL_InterfaceType {
    BCM_CompIDType          comp;       /**< @brief component ID            */
    IMGL_ChannelType        channel[IMGL_CHANNEL_IDX_MAX];
                                        /**< @brief channel identification  */
    uint16_t                maxNumCopies;/**< @brief Max number of copies   */
    IMGL_ModeType           mode;       /**< @brief Mode for this Image Loader
                                                    instance                */
    uint32_t                minEraseSize;/**< @brief minimum erase size     */
    IMGL_GetStateType       getState;   /**< @brief Get State               */
    IMGL_GetImgTblType      getImgTbl;  /**< @brief get Image Table function
                                                pointer of a specific mode  */
    IMGL_ReadPTBLType       readPTBL;    /**< @brief Read PTBL              */
    IMGL_ReadITBLType       readITBL;    /**< @brief Read ITBL              */
    IMGL_ReadImgType        readImg;     /**< @brief Read Image function pointer
                                                    of a specific mode      */
    IMGL_EraseImgType       eraseImg;   /**< @brief Erase Image             */
    IMGL_WriteImgType       writeImg;   /**< @brief Write Image function pointer
                                                    of a specific mode      */
    IMGL_GetStatusType      getStatus;  /**< @brief get status function pointer
                                                    of a specific mode      */
} IMGL_InterfaceType;

#endif /* IMGL_INTERFACE_H */

/** @} */
