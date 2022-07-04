/*****************************************************************************
 Copyright 2020-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_imgl_loader_ifc Loader Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_loader_ifc
    @{

    @file imgl_loader.h
    @brief IMGL Loader Interface

    This header file contains the internal interface functions for image loader.
    @version 0.1 Initial Version
*/

#ifndef IMGL_LOADER_H
#define IMGL_LOADER_H

#include <stdint.h>
#include <bcm_err.h>
#include <pt_utils.h>
#include <imgl_interface.h>
#include <lw_queue.h>
#include <msg_queue.h>
#include <crypto_verify.h>

/**
    @name Image Loader Architecture IDs
    @{
    @brief Architecture IDs for Image Loader
*/
#define BRCM_SWARCH_IMGL_LOAD_STAGE_TYPE            (0x8101U)    /**< @brief #IMGL_LoadStageType     */
#define BRCM_SWARCH_IMGL_LOAD_STAGE_INFO_TYPE       (0x8102U)    /**< @brief #IMGL_LoadStageInfoType */
#define BRCM_SWARCH_IMGL_LOAD_IMG_INFO_TYPE         (0x8103U)    /**< @brief #IMGL_LoadImgInfoType   */
#define BRCM_SWARCH_IMGL_LOAD_CMD_TYPE              (0x8104U)    /**< @brief #IMGL_LoadCmdType       */
#define BRCM_SWARCH_IMGL_LOAD_CONTEXT_TYPE          (0x8105U)    /**< @brief #IMGL_LoadContextType   */
#define BRCM_SWARCH_IMGL_LOAD_PTBL_PROC             (0x8106U)    /**< @brief #IMGL_LoadPTBL          */
#define BRCM_SWARCH_IMGL_LOAD_ITBL_PROC             (0x8107U)    /**< @brief #IMGL_LoadITBL          */
#define BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_PROC    (0x8108U)    /**< @brief #IMGL_LoadStageProcess  */
#define BRCM_SWARCH_IMGL_STAGE_STATE_TYPE           (0x8109U)    /**< @brief #IMGL_StageStateType    */
#define BRCM_SWARCH_IMGL_AUTH_TYPE                  (0x810AU)    /**< @brief #IMGL_AuthType          */
#define BRCM_SWARCH_IMGL_HASH_TYPE                  (0x810BU)    /**< @brief #IMGL_HashType          */
#define BRCM_SWARCH_IMGL_LOAD_STAGE_HANDLER_TYPE    (0x810CU)    /**< @brief #IMGL_StageHandlerType  */
#define BRCM_SWARCH_IMGL_CORE_STAGE_MACRO           (0x810DU)    /**< @brief #IMGL_CORE_STAGE_SET_PENDING */
#define BRCM_SWARCH_IMGL_STAGE_TABLE_GLOBAL         (0x810EU)    /**< @brief #IMGL_StageTable        */
#define BRCM_SWARCH_IMGL_LOAD_STAGE_INFO_SET_PROC   (0x810FU)    /**< @brief #IMGL_CoreEnableStage   */


/** @} */

/**
    @name Loader Authentication types
    @{
    @brief Loader Authentication types

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint8_t IMGL_AuthType;
#define IMGL_AUTH_RSASSA_PSS_V21_2K    (0x00U)    /**< @brief RSASSA-PSS v2.1 based authentication */
#define IMGL_AUTH_CRC_32               (0x01U)    /**< @brief CRC-32 comparison */
#define IMGL_AUTH_MAX_NUM              (0x02U)    /**< @brief Max number of authentication types   */
/** @} */

/**
    @name Loader Hash types
    @{
    @brief Loader Hash types

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint8_t IMGL_HashType;
#define IMGL_HASH_SHA_256             (0x00U)    /**< @brief SHA-256 based hashing         */
#define IMGL_HASH_CRC_32              (0x01U)    /**< @brief CRC-32 based hashing          */
#define IMGL_HASH_MAX_NUM             (0x02U)    /**< @brief Max number of hashing types   */
/** @} */

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_LoadImgInfoType {
    PTBL_IdType         pid;            /**< brief partition ID         */
    uint16_t            imgID;          /**< brief Image ID             */
    uint32_t            maxSize;        /**< @brief Maximum size        */
    uint32_t            readModeIdx;    /**< @brief Read Module Index   */
    IMGL_ChannelIdxType readChannel;    /**< @brief Load Channel        */
    uint32_t            readDevAddr;    /**< @brief Read device address */
    uint32_t            rawReadOffset;  /**< @brief Raw Load Image offset*/
    uint32_t            writeModeIdx;   /**< @brief Write Module Index  */
    IMGL_ChannelIdxType writeChannel;   /**< @brief Write Channel       */
    uint32_t            writeDevAddr;   /**< brief Write device address */
    uint32_t            bufferSize;     /**< @brief Total Buffer size   */
} IMGL_LoadImgInfoType;

/**
    @name IMGL Stage Type
    @{
    @brief IMGL Stage Type

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint16_t IMGL_LoadStageType;
#define IMGL_LOAD_STAGE_ERASE        (0x00U)
#define IMGL_LOAD_STAGE_READ_HDR     (0x01U)
#define IMGL_LOAD_STAGE_WRITE_HDR    (0x02U)
#define IMGL_LOAD_STAGE_FETCH_EXE    (0x03U)
#define IMGL_LOAD_STAGE_READ_DATA    (0x04U)
#define IMGL_LOAD_STAGE_WRITE_DATA   (0x05U)
#define IMGL_LOAD_STAGE_COPY         (0x06U)
#define IMGL_LOAD_STAGE_VERIFY       (0x07U)
#define IMGL_LOAD_STAGE_NUM          (0x08U)
#define IMGL_LOAD_STAGE_INVALID      (0xFFU)
/** @} */

/**
    @name IMGL Stage State Type
    @{
    @brief IMGL Stage State Type

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint16_t IMGL_StageStateType;
#define IMGL_STAGE_STATE_0      (0U)
#define IMGL_STAGE_STATE_1      (1U)
#define IMGL_STAGE_STATE_2      (2U)
#define IMGL_STAGE_STATE_3      (3U)
#define IMGL_STAGE_STATE_4      (4U)
#define IMGL_STAGE_STATE_5      (5U)
#define IMGL_STAGE_STATE_6      (6U)
#define IMGL_STAGE_STATE_7      (7U)
#define IMGL_STAGE_STATE_8      (8U)
/** @} */

/** @brief IMGL Buffer Info Type

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_LoadStageInfoType {
    LWQ_BufferType          procQ;
    uint32_t                size;
    uint32_t                offset;
    IMGL_LoadStageType      next;
    IMGL_StageStateType     state;
    const MSGQ_MsgHdrType   *hdr;
} IMGL_LoadStageInfoType;


/**
    @name IMGL Core cmd type
    @{
    @brief IMGL Core cmd

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint32_t IMGL_LoadCmdType;
#define IMGL_LOAD_CMD_INVALID           (0UL)   /**< @brief Invalid command */
#define IMGL_LOAD_CMD_FETCH_BOOTLOADER  (1UL)   /**< @brief Fetch BL Image  */
#define IMGL_LOAD_CMD_LOAD_NORMAL       (2UL)   /**< @brief Normal Load     */
#define IMGL_LOAD_CMD_LOAD_RAW          (3UL)   /**< @brief Raw Load        */
#define IMGL_LOAD_CMD_FETCH_NORMAL      (4UL)   /**< @brief Fetch Image     */
#define IMGL_LOAD_CMD_FETCH_VERSION     (5UL)   /**< @brief Fetch Version   */
#define IMGL_LOAD_CMD_UPDATE_NORMAL     (6UL)   /**< @brief Update Image    */
#define IMGL_LOAD_CMD_UPDATE_USERIMG    (7UL)   /**< @brief Update UD       */
#define IMGL_LOAD_CMD_ERASE_IMG         (8UL)   /**< @brief Erase User data image*/

/** @} */

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_LoadContextType {
    IMGL_LoadCmdType        cmd;            /**< brief cmd                  */
    int32_t                 status;         /**< brief status               */
    uint32_t                crc;            /**< @brief current CRC         */
    IMGL_AuthType           authType;       /**< @brief Authentication type */
    uint32_t                enStages;       /**< @brief Enabled Stages      */
    uint32_t                chunkMovStages; /**< @brief Chunk Moved Stages  */
    uint32_t                pendStages;     /**< @brief Pending Stages      */
    uint32_t                doneStages;     /**< @brief Done Stages         */
    uint32_t                errorStages;    /**< @brief Done Stages         */
    uint32_t                chunkCnt;       /**< @brief Number of chunks    */
    uint32_t                chunkSize;      /**< @brief Chunk Size          */
    uint32_t                chunkOffset;    /**< @brief Chunk offset        */
    uint32_t                filledSizes[LWQ_BUFFER_MAX_LENGTH];
    uint64_t                loadTime;
    uint64_t                hashTime;
    uint64_t                verifyTime;
    uint8_t                 hashOut[32UL];
                                            /**< @brief Filled sizes        */
    CRYPTO_VerifyMsgType    verifyMsg;      /**< @brief Verify message      */
    MSGQ_HdlType            verifyCtx;      /**< @brief Verify ctx handle   */
    IMGL_ImgHdrType         imgHdr;         /**< @brief Image Header        */
    IMGL_LoadStageInfoType  stageInfo[IMGL_LOAD_STAGE_NUM + 1];
                                        /**< @brief Stage Info          */
} IMGL_LoadContextType;

/** @brief Image Loader from multiple enabled modes

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]       aCore        Core Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Image is successfully loaded and authenticated
    @retval     #BCM_ERR_AUTH_FAILED    Authentication failed
    @return     #BCM_ERR_NOMEM          Insufficient memory to load image
    @return     #BCM_ERR_NOT_FOUND      Image not found
    @return     #BCM_ERR_BUSY           Image loading Busy

    @post Image is loaded into download area upon success

    @trace #BRCM_SWREQ_IMGL_CORE

    @note The caller assumes the responsibility of valid values in aImgInfo
*/
int32_t IMGL_LoadStageProcess(IMGL_LoadCmdType aCmd, const IMGL_LoadImgInfoType *aImgInfo,
                    IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer, uint8_t *aClientBuffer);

/** @brief Load PTBL

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aInterface     IMGL Interface
    @param[in]      aChannel       IMGL Channel
    @param[out]     aAddr          Memory to load PTBL
    @param[inout]   aSize          Memory Size
    @param[inout]   aHdr           MSGQ Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             PTBL Load Completed
    @retval     #BCM_ERR_BUSY           Busy loading PTBL
    @retval     #BCM_ERR_NOMEM          No Memory to load PTBL
    @retval     #BCM_ERR_UNKNOWN        (aModule->readPTBL is NULL)
                                        or (aModule->readPTBL failed)

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE

    @note  aPtbl can not be passed down to imgl interface layer as it
           could be from stack.
*/
int32_t IMGL_LoadPTBL(const IMGL_InterfaceType* const aInterface, IMGL_ChannelIdxType aChannel, uint8_t *aScratch,
                        uint32_t aScrtchSize, const MSGQ_MsgHdrType **aHdr);


/** @brief Load ITBL

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aInterface     IMGL Interface
    @param[in]      aChannel       IMGL Channel
    @param[out]     aAddr          Memory to load ITBL
    @param[inout]   aSize          Memory Size
    @param[inout]   aHdr           MSGQ Handle

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             ITBL Load Completed
    @retval     #BCM_ERR_BUSY           Busy loading ITBL
    @retval     #BCM_ERR_UNKNOWN        (aModule->readITBL is NULL)
                                        or (aModule->readITBL failed)

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE

*/
int32_t IMGL_LoadITBL(const IMGL_InterfaceType* const aInterface, IMGL_ChannelIdxType aChannel, const PTBL_Type *aPtbl,
                        PTBL_IdType aPtblId, ITBL_Type *aItbl, const MSGQ_MsgHdrType **aHdr);

/** @brief IMGL internal function type to handle various stages

    Initiates requests to lower level module and handles completion of
    stage per image

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]   aCore           Core Context
    @param[out]     aCopyBase       Copy Base address

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Stage Completed
    @retval     #BCM_ERR_BUSY           Busy processing stage
    @return     #BCM_ERR_UNKNOWN        Unknown error or integration fault
    @return     #BCM_ERR_DATA_INTEG     CRC check failed
    @return     #BCM_ERR_AUTH_FAILED    Authentication Failed
    @return     #BCM_ERR_NOMEM          Insufficient memory to load image
    @return     #BCM_ERR_NOT_FOUND      Image not found

    @post Erase completed upon success

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef int32_t (*IMGL_StageHandlerType)(const IMGL_LoadImgInfoType *aImgInfo,
                            IMGL_LoadContextType *aCore, uint8_t *aChunkBuffer,
                            uint8_t *aClientBuffer);

/** @name STAGE Penging macros
    @{
    @brief STAGE pending macros

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_CORE_STAGE_SET_PENDING(aCore, aStage)    (aCore)->pendStages |= (1UL << (aStage));
#define IMGL_CORE_STAGE_CLEAR_PENDING(aCore, aStage)    (aCore)->pendStages &= ~(1UL << (aStage));
#define IMGL_CORE_STAGE_IS_PENDING(aCore, aStage)    (0UL != ((aCore)->pendStages & (1UL << (aStage))))
#define IMGL_CORE_STAGE_ERROR(aCore, aStage)        \
    {                                               \
        (aCore)->doneStages |= (1UL << (aStage));   \
        (aCore)->errorStages |= (1UL << (aStage));  \
        (aCore)->pendStages &= ~(1UL << (aStage));  \
        (aCore)->enStages &= ~(1UL << (aStage));    \
    }
/** @} */

/** @brief Global to loader stage handlers

    @trace #BRCM_SWREQ_IMGL_CORE
*/
extern const IMGL_StageHandlerType IMGL_StageTable[];

/** @brief IMGL helper enable stage

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[out]     aInfo           Stage Info
    @param[in]      aOffset         Offset from Flash Address (Or within image)
    @param[in]      aSize           Total Size to process
    @param[in]      aNext           Next Stage

    @reurn     void

    @post Stage Info is set/initialized

    @trace #BRCM_SWREQ_IMGL_CORE

*/
void IMGL_CoreEnableStage(IMGL_LoadContextType *aCore,
                       IMGL_LoadStageType      aStage,
                       uint32_t            aOffset,
                       uint32_t            aSize,
                       IMGL_LoadStageType      aNext);

#endif /* IMGL_LOADER_H */

/** @} */
