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
    @defgroup grp_imgl_shared_ifc IMGL shared context Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_shared_ifc
    @{

    IMGL shared context interface

    @limitations None

    @file imgl_shared_context.h
    @brief IMGL shared context interface
    This header file contains the shared context interface functions for IMGL

    @version 0.1 Initial Version
*/

#ifndef IMGL_SHARED_CONTEXT_H
#define IMGL_SHARED_CONTEXT_H

#include <stdint.h>

/**
    @name IMGL shared context Architecture IDs
    @{
    @brief Architecture IDs for IMGL shared context
*/
#define BRCM_SWARCH_IMGL_SHARED_CONTEXTINIT_PROC      (0x8B00U)         /**< @brief  #IMGL_SharedContextInit   */
#define BRCM_SWARCH_IMGL_SHARED_GETIFC_PROC           (0x8B01U)         /**< @brief  #IMGL_SharedGetIfc        */
#define BRCM_SWARCH_IMGL_SHARED_SETIFC_PROC           (0x8B02U)         /**< @brief  #IMGL_SharedSetIfc        */
#define BRCM_SWARCH_IMGL_SHARED_GETPTBL_PROC          (0x8B03U)         /**< @brief  #IMGL_SharedGetPTBL       */
#define BRCM_SWARCH_IMGL_SHARED_SETPTBL_PROC          (0x8B04U)         /**< @brief  #IMGL_SharedSetPTBL       */
#define BRCM_SWARCH_IMGL_SHARED_GETCOPYID_PROC        (0x8B05U)         /**< @brief  #IMGL_SharedGetCopyID     */
#define BRCM_SWARCH_IMGL_SHARED_SETCOPYID_PROC        (0x8B06U)         /**< @brief  #IMGL_SharedSetCopyID     */
#define BRCM_SWARCH_IMGL_SHARED_GETITBL_PROC          (0x8B07U)         /**< @brief  #IMGL_SharedGetITBL       */
#define BRCM_SWARCH_IMGL_SHARED_SETITBL_PROC          (0x8B08U)         /**< @brief  #IMGL_SharedSetITBL       */
#define BRCM_SWARCH_IMGL_SHARED_GETIMGHDR_PROC        (0x8B09U)         /**< @brief  #IMGL_SharedGetImgHdr     */
#define BRCM_SWARCH_IMGL_SHARED_ADDIMGHDR_PROC        (0x8B0AU)         /**< @brief  #IMGL_SharedAddImgHdr     */
#define BRCM_SWARCH_IMGL_SHARED_REMOVEIMGHDRS_PROC    (0x8B0BU)         /**< @brief  #IMGL_SharedRemoveImgHdrs */
#define BRCM_SWARCH_IMGL_SHARED_FINDIMGHDR_PROC       (0x8B0CU)         /**< @brief  #IMGL_SharedFindImgHdr    */
/** @} */

/** @brief Initialize shared context

    Initialize context

    @behavior Sync, Non-reentrant

    @pre None

    @param      None

    @return     None

    @post IMGL shared context is initialized

    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedContextInit(void);

/** @brief Get shared interface details

    Get shared interface mode and channel

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[inout]      aMode     Pointer to store the mode
    @param[inout]      aChannel  Pointer to store the channel

    @retval   None

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedGetIfc(IMGL_ModeType *aMode, IMGL_ChannelType *aChannel);

/** @brief Set shared interface details

    Set shared interface mode and channel

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aMode     Mode
    @param[in]      aChannel  Channel

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request successful
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameters

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetIfc(IMGL_ModeType aMode, IMGL_ChannelType aChannel);

/** @brief Get shared PTBL

    Get shared partition table

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param    None

    @retval   PTBL_Type   Pointer to partition table

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
const PTBL_Type* IMGL_SharedGetPTBL(void);

/** @brief Set shared PTBL

    Set shared partition table

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aAddr     Start address of memory holding table
    @param[in]      aSize     Size of the memory

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request successful
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameters

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetPTBL(uint8_t* aAddr, uint32_t aSize);

/** @brief Get shared partition id with copy id

    Get shared partition id with copy id

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aPid     Partition id

    @retval   PTBL_IdType    Partition id with copy id

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
PTBL_IdType IMGL_SharedGetCopyID(PTBL_IdType aPid);

/** @brief Set shared partition id with copy id

    Set shared partition id with copy id

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aPid      Partition id
    @param[in]      aCopyID   Copy id

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request successful
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameters

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetCopyID(PTBL_IdType aPid, uint16_t aCopyID);

/** @brief Get shared ITBL

    Get shared image table

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]  aPid      Partition id

    @retval   ITBL_Type   Pointer to image table

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
const ITBL_Type* IMGL_SharedGetITBL(PTBL_IdType aPid);

/** @brief Set shared ITBL

    Set shared image table

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aPid      Partition id
    @param[in]      aItbl     Pointer to store image table

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request successful
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameters

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedSetITBL(PTBL_IdType aPid, const ITBL_Type *aItbl);

/** @brief Find and return the image header by index

    Find and return the image header from the stored headers

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aIdx         Header index

    @retval     IMGL_ImgHdrType        Image header

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
const IMGL_ImgHdrType* IMGL_SharedGetImgHdr(uint32_t aIdx);

/** @brief Add image header

    Find emprty slot and add the image header

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aImgHdr     Pointer to image header

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             Request successful
    @retval     #BCM_ERR_NO_MEM         No empty slots
    @retval     #BCM_ERR_INVAL_PARAMS   Invalid parameters


    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
int32_t IMGL_SharedAddImgHdr(IMGL_ImgHdrType *aImgHdr);

/** @brief Find and remove the image header

    Find and remove the image header from the stored headers for
    given partition id.

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aPid         Partition ID

    @retval     None

    @post Removes the corresponding image table

    @trace #BRCM_SWREQ_IMGL_CORE
*/
void IMGL_SharedRemoveImgHdrs(PTBL_IdType aPid);

/** @brief Find and return the image header

    Find and return the image header from the stored headers

    @behavior Sync, Non-reentrant

    @pre IMGL is initialized

    @param[in]      aContext     IMGL Context
    @param[in]      aPid         Partition ID
    @param[in]      aImgID       Image ID

    @retval     IMGL_ImgHdrType        Image header

    @post None

    @trace #BRCM_SWREQ_IMGL_CORE
*/
IMGL_ImgHdrType* IMGL_SharedFindImgHdr(PTBL_IdType aPid, uint16_t aImgID);

#endif /* IMGL_SHARED_CONTEXT_H */
/** @} */
