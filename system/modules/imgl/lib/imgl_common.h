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
    @defgroup grp_imgl_common_ifc IMGL common Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_common_ifc
    @{

    IMGL common interface

    @limitations None

    @file imgl_common.h
    @brief IMGL common interface
    This header file contains the common interface functions for IMGL

    @version 0.1 Initial Version
*/

#ifndef IMGL_COMMON_H
#define IMGL_COMMON_H

#include <stdint.h>
#include <pt_utils.h>
#include <imgl_loader.h>
#include <otp_module.h>

/**
    @name IMGL common Architecture IDs
    @{
    @brief Architecture IDs for IMGL common
*/
#define BRCM_SWARCH_IMGL_USER_IMGID_MACRO             (0x8901U)    /**< @brief #IMGL_USER_IMG_ID           */
#define BRCM_SWARCH_IMGL_FETCH_MEM_CNT_MACRO          (0x8902U)    /**< @brief #IMGL_FETCH_EXE_MAX_MEM_CNT */
#define BRCM_SWARCH_IMGL_INT_STATE_TYPE               (0x8903U)    /**< @brief #IMGL_IntStateType          */
#define BRCM_SWARCH_IMGL_GET_MEMORY_TYPE              (0x8906U)    /**< @brief #IMGL_GetMemoryType         */
#define BRCM_SWARCH_IMGL_INT_STATE_HANDLER_PROC       (0x8907U)    /**< @brief #IMGL_InitStateHandler      */
#define BRCM_SWARCH_IMGL_MEMORY_RESET_PROC            (0x8908U)    /**< @brief #IMGL_MemoryReset           */
#define BRCM_SWARCH_IMGL_MEMORY_GET_PROC              (0x890AU)    /**< @brief #IMGL_MemoryGet             */
#define BRCM_SWARCH_IMGL_TEMPMEMORY_GET_PROC          (0x890BU)    /**< @brief #IMGL_TempMemGet            */
#define BRCM_SWARCH_IMGL_COMMON_INIT_PROC             (0x890CU)    /**< @brief #IMGL_CommonInit            */
#define BRCM_SWARCH_IMGL_FETCHCONTEXT_TYPE            (0x890DU)    /**< @brief #IMGL_FetchContextType      */
#define BRCM_SWARCH_IMGL_MEMORY_TYPE                  (0x890EU)    /**< @brief #IMGL_MemoryType            */
#define BRCM_SWARCH_IMGL_COMMONCONTEXT_TYPE           (0x890FU)    /**< @brief #IMGL_CommonContextType     */
#define BRCM_SWARCH_IMGL_LOAD_STATE_TYPE              (0x8910U)    /**< @brief #IMGL_LoadStateType         */
#define BRCM_SWARCH_IMGL_CFGCONTEXT_TYPE              (0x8911U)    /**< @brief #IMGL_CfgContextType        */
#define BRCM_SWARCH_IMGL_UPDATE_STATE_TYPE            (0x8912U)    /**< @brief #IMGL_UpdateStateType       */
#define BRCM_SWARCH_IMGL_UPDATE_CONTEXT_TYPE          (0x8913U)    /**< @brief #IMGL_UpdateContextType     */
#define BRCM_SWARCH_IMGL_UPDATE_MAX_NUM_IMGS_MACRO    (0x8914U)    /**< @brief #IMGL_UPDATE_MAX_NUM_IMGS   */
#define BRCM_SWARCH_IMGL_UPDATE_REQUEST_TYPE          (0x8915U)    /**< @brief #IMGL_UpdateReqType         */
#define BRCM_SWARCH_IMGL_SEARCH_MODE_IDX_PROC         (0x8916U)    /**< @brief #IMGL_SearchModeIdx         */
#define BRCM_SWARCH_IMGL_SEARCH_CHN_IDX_PROC          (0x8917U)    /**< @brief #IMGL_SearchChannelIdx      */
/** @} */

/**
    @name IMGL Image ID

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_USER_IMG_ID    (0x1000U)   /**< @brief User Img ID*/

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_FETCH_EXE_MAX_MEM_CNT ((2UL*(ITBL_MAX_NUM_ENTRIES + 1U)) + IMGL_MEM_AREA_MAX_CNT)

/**
    @{

    @brief  Init state

    @trace #BRCM_SWREQ_IMGL_CORE
 */
typedef uint32_t IMGL_IntStateType;
#define IMGL_INT_STATE_RESET               (0UL)
#define IMGL_INT_STATE_INIT                (1UL)
#define IMGL_INT_STATE_LOAD_PTBL           (2UL)
#define IMGL_INT_STATE_LOAD_USER_ITBL      (3UL)
#define IMGL_INT_STATE_LOAD_UPDATE_REQUEST (4UL)
#define IMGL_INT_STATE_SET_COPY_ID         (5UL)
#define IMGL_INT_STATE_LOAD_ITBL           (6UL)
#define IMGL_INT_STATE_READ_IMAGE_SETUP    (7UL)
#define IMGL_INT_STATE_READ_IMAGE          (8UL)
#define IMGL_INT_STATE_DONE                (9UL)
#define IMGL_INT_STATE_ERROR               (10UL)
/** @} */

/**
    @brief IMGL Core memory

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_MemoryType {
    uint32_t    index;      /**< @brief index-1 in IMGL_MemoryArea array*/
    uint32_t    start;      /**< @brief memory area address             */
    uint32_t    size;       /**< @brief memory size                     */
    uint32_t    allocated;  /**< @brief allocated (0-Free/1-Allocated)  */
} IMGL_MemoryType;

/** @brief Maximum number of images that can be sent in one update request

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define IMGL_UPDATE_MAX_NUM_IMGS    (16UL)

/** @brief Update Request structure

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_UpdateReqType {
    uint32_t            numImgs;
    IMGL_ChannelIdxType channel;
    PTBL_IdType         pid[IMGL_UPDATE_MAX_NUM_IMGS];
    uint16_t            imgID[IMGL_UPDATE_MAX_NUM_IMGS];
} IMGL_UpdateReqType;

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_CommonContextType {
    IMGL_UpdateReqType      updateRequest;
    uint32_t                updatePending;
    PTU_ImgInfoType         ptuImgInfo;
    uint32_t                tempBuffer[IMGL_MEM_AREA_MIN_SIZE >> 2UL];
    IMGL_LoadImgInfoType    usrImgInfo;
    uint32_t                numImgs;
    uint16_t                imgIDs[ITBL_MAX_NUM_ENTRIES];
    uint32_t                curImgIdx;
    IMGL_MemoryType         mem[IMGL_FETCH_EXE_MAX_MEM_CNT];
    uint32_t                freeIndex;
    const MSGQ_MsgHdrType   *hdr;
    IMGL_LoadContextType    core;
} IMGL_CommonContextType;

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_FetchContextType {
    IMGL_StateType          state;
    PTBL_IdType             initPID;
    IMGL_IntStateType       initState;
    IMGL_LoadImgInfoType    imgInfo;
    IMGL_CommonContextType  commonContext;
    IMGL_ModeType           fetchMode;
    IMGL_ChannelType        fetchChannel;
    OTPM_BootModeType       bootModes;
} IMGL_FetchContextType;

/**
    @name IMGL Stage State Type
    @{
    @brief IMGL Stage State Type

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint32_t IMGL_LoadStateType;
#define IMGL_LOAD_STATE_RESET                   (0UL)
#define IMGL_LOAD_STATE_READ_CHAN_SETUP         (1UL)
#define IMGL_LOAD_STATE_READ                    (2UL)
#define IMGL_LOAD_STATE_DONE                    (3UL)
/** @} */

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_CfgContextType {
    IMGL_StateType          state;
    PTBL_IdType             initPID;
    IMGL_IntStateType       readyState;
    IMGL_LoadStateType      loadState;
    IMGL_LoadContextType    core;
    IMGL_LoadImgInfoType    imgInfo;
    IMGL_CommonContextType  commonContext;
} IMGL_CfgContextType;


/**
    @name IMGL Update State Type
    @{
    @brief IMGL Update State

    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef uint32_t IMGL_UpdateStateType;
#define IMGL_UPDATE_STATE_RESET                 (0UL)   /**< @brief Reset State             */
#define IMGL_UPDATE_STATE_PREPARE_PENDING       (1UL)   /**< @brief Prepare Pending Update  */
#define IMGL_UPDATE_STATE_SETUP_READ            (2UL)   /**< @brief Setup Read Image        */
#define IMGL_UPDATE_STATE_WAIT_READ             (3UL)   /**< @brief perform copy            */
#define IMGL_UPDATE_STATE_COPY                  (4UL)   /**< @brief perform copy            */
#define IMGL_UPDATE_STATE_ERASE_UD              (5UL)   /**< @brief Erase User image        */
#define IMGL_UPDATE_STATE_READY                 (8UL)
#define IMGL_UPDATE_STATE_REQUEST               (9UL)
#define IMGL_UPDATE_STATE_PREPARE_UD            (10UL)   /**< @brief Erase User image        */
#define IMGL_UPDATE_STATE_SETUP_WRITE_IMG       (11UL)
#define IMGL_UPDATE_STATE_WRITE_IMG             (12UL)
#define IMGL_UPDATE_STATE_WRITE_UD_SETUP        (13UL)
#define IMGL_UPDATE_STATE_WRITE_UD_WAIT         (14UL)
#define IMGL_UPDATE_STATE_DONE                  (15UL)
/** @} */


/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef struct sIMGL_UpdateContextType {
    IMGL_ModeType           bootMode;
    uint32_t                bootModeIdx;
    uint32_t                bootChannelIdx;
    IMGL_UpdateStateType    updateState;
    int32_t                 status;
    IMGL_UpdateReqType      request;
    IMGL_VersionType        version;
    uint32_t                curPartIdx;
    uint32_t                curImgIdx;
    uint32_t                readModeIdx;
    IMGL_ChannelIdxType     readChannelIdx;
    uint32_t                writeModeIdx;
    IMGL_ChannelIdxType     writeChannelIdx;
    const MSGQ_MsgHdrType   *hdr;
    IMGL_LoadImgInfoType    imgInfo;
    IMGL_LoadContextType    core;
    uint8_t                 buffer[IMGL_MEM_AREA_MIN_SIZE];
} IMGL_UpdateContextType;

/**
    @trace #BRCM_SWREQ_IMGL_CORE
*/
typedef int32_t (*IMGL_GetMemoryType)(IMGL_CommonContextType *aContext,
                                      uint32_t aLoadAddress,
                                      uint32_t aImgSize,
                                      uint8_t **aMemory,
                                      uint32_t *aSize);

/** @brief Init State Handler (Loads PTBL and ITBL)

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]       aContext        IMGL Context
    @param[in]          aPid            Partition ID
    @param[in]          aCmd            Core Command for loading
    @param[in]          aMemory         Function pointer to get memory
    @param[inout]       aImgInfo        Pointer to update image information

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Patition authentication completed and/or loaded
    @retval     #BCM_ERR_AUTH_FAILED    Authentication failed
    @return     #BCM_ERR_NOMEM          Insufficient memory to load image
    @return     #BCM_ERR_NOT_FOUND      Image not found
    @return     #BCM_ERR_BUSY           Image loading Busy

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_InitStateHandler(IMGL_CommonContextType *aContext,
                              PTBL_IdType aPid,
                              IMGL_IntStateType *aIntState,
                              IMGL_GetMemoryType getMemory,
                              IMGL_LoadImgInfoType *aImgInfo,
                              IMGL_ModeType           aMode,
                              IMGL_ChannelType      aChannel);

/** @brief Initialize memories and related structures

    Memory array in context has been allocated with consideration of 2 chunks
    added for every split (with upto ITBL_MAX_NUM_ENTRIES), and 3 initial chunks

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      void

    @return     void

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_MemoryReset(IMGL_CommonContextType *aContext);

/** @brief Get temporary memory

    Return the temporary memory

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aLoadAddress     Reserved
    @param[in]      aImgSize         Reserved
    @param[in]      aMemory          Pointer to store the buffer address
    @param[in]      aOutSize         Pointer to store the buffer size

    @retval     IMGL_ImgHdrType        Image header

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_TempMemGet(IMGL_CommonContextType *aContext,
                         uint32_t aLoadAddress,
                         uint32_t aImgSize,
                         uint8_t **aMemory,
                         uint32_t *aOutSize);

/** @brief Get memory for the given load address

    Return the memoryfor the given load address

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aLoadAddress     Load address
    @param[in]      aImgSize         Image size
    @param[in]      aMemory          Pointer to store the buffer address
    @param[in]      aOutSize         Pointer to store the buffer size

    @retval     IMGL_ImgHdrType        Image header

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_MemoryGet(IMGL_CommonContextType *aContext,
                         uint32_t aLoadAddress,
                         uint32_t aImgSize,
                         uint8_t **aMemory,
                         uint32_t *aOutSize);

/** @brief Initialize common context

    Initialize context

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aContext   Common context

    @return     void

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_CommonInit(IMGL_CommonContextType *aContext);

/** @brief Search for given mode

    Search for the given mode in imgl interfaces

    @behavior Sync, Non-reentrant

    @pre Imgl interfaces is initialized

    @param[in]      aMode       Mode to search

    @return     Index of the given mode if present
                #IMGL_LOAD_MODE_MAX if absent

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
uint32_t IMGL_SearchModeIdx(IMGL_ModeType aMode);

/** @brief Search for given channel in given mode

    Search for the given channel in imgl interfaces

    @behavior Sync, Non-reentrant

    @pre Imgl interfaces is initialized

    @param[in]      aMode       Mode to search
    @param[in]      aChannel    Channel to search

    @return     Index of the given mode if present
                #IMGL_CHANNEL_IDX_MAX if absent

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
uint32_t IMGL_SearchChannelIdx(IMGL_ModeType aMode, IMGL_ChannelType aChannel);
#endif /* IMGL_COMMON_H */

/** @} */
