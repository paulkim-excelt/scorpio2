/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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

/** @defgroup grp_nvm_flash_ifc FLASH Abstract Interface
    @ingroup grp_nvm_abstract

    @addtogroup grp_nvm_flash_ifc
    @{

    @file nvm_flash.h
    @brief Interface for FLASH Abstract

    @version 0.1 Initial version
*/

#ifndef NVM_FLASH_H
#define NVM_FLASH_H

#ifdef ENABLE_MODHELPER
#include <module_msg.h>
#include <pt_utils.h>
#endif

/**
    @name NVM FLASH Abstract Interface IDs
    @{
    @brief Interface IDs for NVM FLASH Abstract

*/
#define BRCM_SWARCH_FLASH_RPC_MAX_MACRO                (0x8202U)    /**< @brief #FLASH_RPC_MAX_DATA_SIZE          */
#define BRCM_SWARCH_FLASH_CMD_TYPE                     (0x8203U)    /**< @brief #FLASH_CmdIDType                  */
#define BRCM_SWARCH_FLASH_RPC_READ_INFO_TYPE           (0x8204U)    /**< @brief #FLASH_RpcReadInfoType            */
#define BRCM_SWARCH_FLASH_RPC_WRITE_INFO_TYPE          (0x8205U)    /**< @brief #FLASH_RpcWriteInfoType           */
#define BRCM_SWARCH_FLASH_RPC_ERASE_INFO_TYPE          (0x8206U)    /**< @brief #FLASH_RpcEraseInfoType           */
#define BRCM_SWARCH_FLASH_HANDLE_TYPE                  (0x8207U)    /**< @brief #FLASH_HandleType                 */
#define BRCM_SWARCH_FLASH_MSG_TYPE                     (0x8208U)    /**< @brief #FLASH_MsgType                    */
#define BRCM_SWARCH_FLASH_IMGL_CMD_INFO_TYPE           (0x8209U)    /**< @brief #FLASH_ImglCmdInfoType            */
#define BRCM_SWARCH_FLASH_HELPER_CTX_TYPE              (0x820AU)    /**< @brief #FLASH_HelperCtxType              */
#define BRCM_SWARCH_FLASH_HELPER_GLOBAL                (0x820BU)    /**< @brief #FLASH_Helper                     */
#define BRCM_SWARCH_FLASH_INSTALL_HELPERCTX_TYPE       (0x820CU)    /**< @brief #FLASH_InstallHelperCtxType       */
#define BRCM_SWARCH_FLASH_INSTALL_HELPER_GLOBAL        (0x820DU)    /**< @brief #FLASH_InstallHelper              */
#define BRCM_SWARCH_FLASH_MAX_PAGE_SIZE_MACRO          (0x820EU)    /**< @brief #FLASH_MAX_PAGE_SIZE              */
#define BRCM_SWARCH_FLASH_MAX_FILESIZE_MACRO           (0x820FU)    /**< @brief #FLASH_MAX_FILESIZE               */
#define BRCM_SWARCH_FLASH_MAX_SECTOR_MACRO             (0x8210U)    /**< @brief #FLASH_MAX_SECTOR                 */
#define BRCM_SWARCH_FLASH_MAX_PT_COUNT_MACRO           (0x8211U)    /**< @brief #FLASH_MAX_PT_COUNT               */

/** @} */

/**
    @brief NVM Integer parse status

    @trace #BRCM_SWREQ_FLASH
*/
#define  FLASH_MAX_PAGE_SIZE    (256UL)

/**
    @brief NVM Integer parse status

    @trace #BRCM_SWREQ_FLASH
*/
#define FLASH_MAX_FILESIZE    (2UL*1024UL*1024UL)

/**
    @brief NVM Integer parse status

    @trace #BRCM_SWREQ_FLASH
*/
#define FLASH_MAX_SECTOR           (32UL)
#define FLASH_MAX_SECTOR_SIZE      (0x10000UL)

/**
    @brief NVM maximum count of PT images

    @trace #BRCM_SWREQ_FLASH
*/
#define FLASH_MAX_PT_COUNT         (16UL)


/**
    @brief Flash RPC operation max data size

    @trace #BRCM_SWREQ_FLASH
 */
#define FLASH_RPC_MAX_DATA_SIZE             (256UL)
#define FLASH_RPC_MAX_PAYLOAD_SIZE          (FLASH_RPC_MAX_DATA_SIZE + 32UL)



/**
  @name Flash module supported command
  @{
  @brief Flash module supported command

  @trace #BRCM_SWREQ_FLASH
*/
typedef uint32_t FLASH_CmdIDType;            /**< @brief typedef for flash cmdID */
#define FLASH_CMD_RPC_READ                   BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 1UL) /**< @brief #FLASH_RpcReadInfoType */
#define FLASH_CMD_RPC_WRITE                  BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 2UL) /**< @brief #FLASH_RpcWriteInfoType */
#define FLASH_CMD_RPC_ERASE                  BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 3UL) /**< @brief #FLASH_RpcEraseInfoType */
#define FLASH_CMD_IMGL_READ                  BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 4UL) /**< @brief #FLASH_ImglCmdInfoType */
#define FLASH_CMD_IMGL_WRITE                 BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 5UL) /**< @brief #FLASH_ImglCmdInfoType */
#define FLASH_CMD_IMGL_ERASE                 BCM_CMDID(BCM_GROUPID_NVM, BCM_FLM_ID, 6UL) /**< @brief #FLASH_ImglCmdInfoType */
/** @} */

/**
    @brief Flash Module RPC Read Info structure

    @trace #BRCM_SWREQ_FLASH
 */
typedef struct sFLASH_ImglCmdInfoType {
    uint32_t            hwID;                              /**< @brief  Flash ID */
    uint32_t            addr;                              /**< @brief  Flash Physical address */
    uint32_t            len;                               /**< @brief  Read/wrire/erase length */
    uint8_t             *buf;                              /**< @brief  Input/Output data buffer */
} FLASH_ImglCmdInfoType;
_Static_assert(FLASH_RPC_MAX_PAYLOAD_SIZE >= sizeof(FLASH_ImglCmdInfoType),
    "Size of this structure must be less or equal to FLASH_RPC_MAX_PAYLOAD_SIZE");

/**
    @brief Flash Module RPC Read Info structure

    @trace #BRCM_SWREQ_FLASH
 */
typedef struct sFLASH_RpcReadInfoType {
    uint32_t            hwID;                              /**< @brief  Flash ID */
    uint32_t            addr;                              /**< @brief  Flash Physical address */
    uint32_t            len;                               /**< @brief  Read length */
    uint8_t             bufOut[FLASH_RPC_MAX_DATA_SIZE];  /**< @brief  Input data buffer */
} FLASH_RpcReadInfoType;
_Static_assert(FLASH_RPC_MAX_PAYLOAD_SIZE >= sizeof(FLASH_RpcReadInfoType),
    "Size of this structure must be less or equal to FLASH_RPC_MAX_PAYLOAD_SIZE");

/**
    @brief Flash Module RPC Write Info structure

    @trace #BRCM_SWREQ_FLASH
 */
typedef struct sFLASH_RpcWriteInfoType {
    uint32_t            hwID;                              /**< @brief Flash ID */
    uint32_t            addr;                              /**< @brief operation Physical address */
    uint32_t            len;                               /**< @brief write length */
    uint8_t             bufIn[FLASH_RPC_MAX_DATA_SIZE];   /**< @brief Output data buffer */
} FLASH_RpcWriteInfoType;
_Static_assert(FLASH_RPC_MAX_PAYLOAD_SIZE >= sizeof(FLASH_RpcWriteInfoType),
    "Size of this structure must be less or equal to FLASH_RPC_MAX_PAYLOAD_SIZE");

/**
    @brief Flash Module RPC Erase Info structure

    @trace #BRCM_SWREQ_FLASH
 */
typedef struct sFLASH_RpcEraseInfoType {
    uint32_t            hwID;                             /**< @brief  Flash ID */
    uint32_t            addr;                             /**< @brief  operation Physical address */
    uint32_t            len;                             /**< @brief  Flash sector / sub-sector size */
} FLASH_RpcEraseInfoType;
_Static_assert(FLASH_RPC_MAX_PAYLOAD_SIZE >= sizeof(FLASH_RpcEraseInfoType),
    "Size of this structure must be less or equal to FLASH_RPC_MAX_PAYLOAD_SIZE");

/**
  @brief Flash Module Command Handle

  @trace #BRCM_SWREQ_FLASH
*/
typedef union uFLASH_HandleType {
    FLASH_RpcReadInfoType  rpcReadInfo;
    FLASH_RpcWriteInfoType rpcWriteInfo;
    FLASH_RpcEraseInfoType rpcEraseInfo;
    FLASH_ImglCmdInfoType  imglCmdInfo;
    uint8_t                data[FLASH_RPC_MAX_PAYLOAD_SIZE];
} FLASH_HandleType;

#ifdef ENABLE_MODHELPER
/** @brief Context structure for NVM helper

    @trace #BRCM_SWREQ_FLASH
*/
typedef struct sFLASH_HelperCtxType {
    MODULE_MsgContextType modCtx;      /**< @brief Module's Context     */
    FILE *fp;                          /**< @brief File pointer
                                                   to be used to write the
                                                   data read to file    */
    BCM_CmdType cmd;                   /**< @brief command which is
                                                    in process          */
    uint32_t fileSz;                   /**< @brief Total File Size      */
    uint32_t offset;                   /**< @brief Write Offset         */
    uint32_t sector;                   /**< @brief Erasing secor Number */
    uint32_t numSectors;               /**< @brief Total number of
                                                   sectors to erase     */
    FLASH_RpcReadInfoType readInfo;    /**< @brief Read information     */
    FLASH_RpcWriteInfoType writeInfo;  /**< @brief Write information    */
    FLASH_RpcEraseInfoType eraseInfo;  /**< @brief Erase Information    */
    uint8_t buff[FLASH_MAX_FILESIZE];    /**< @brief Buffer to store
                                                   the file data        */
} FLASH_HelperCtxType;

/** @brief Install Context structure for NVM helper

    @trace #BRCM_SWREQ_FLASH
*/
typedef struct sFLASH_InstallHelperCtxType {
    MODULE_MsgContextType modCtx;        /**< @brief Module's Context      */
    uint32_t offset;                     /**< @brief Offset for write      */
    uint32_t sector;                     /**< @brief Erasing sector Number */
    FLASH_RpcWriteInfoType writeInfo;    /**< @brief Write information     */
    FLASH_RpcEraseInfoType eraseInfo;    /**< @brief Erase Information     */
    PTBL_Type ptbl;                      /**< @brief Partition table       */
    uint32_t ptSize;                     /**< @brief Partition table size  */
    uint32_t ptCount;                    /**< @brief Index for PT write    */
    ITBL_Type itbl;                      /**< @brief Image Table           */
    uint32_t itblSize;                   /**< @brief Image Table size      */
    uint32_t itblCount;                  /**< @brief Index for ITBL        */
    uint32_t imgCount;                   /**< @brief Index for images      */
    uint8_t *image;                      /**< @brief Pointer to image      */
    uint32_t imgSize;                    /**< @brief Image size            */
    uint32_t isCRCRecompute;             /**< @brief CRC recompute flag    */
    uint32_t isSkipBLSign;               /**< @brief Skip BL signature flag*/
    uint64_t startTime;                  /**< @brief Install start time    */
} FLASH_InstallHelperCtxType;


/**
    @brief Host NVM Helper Module

    @trace #BRCM_SWREQ_FLASH
*/
extern const MODULE_MsgConverterType FLASH_Helper;

/**
    @brief Host NVM install Helper Module

    @trace #BRCM_SWREQ_FLASH
*/
extern const MODULE_MsgConverterType FLASH_InstallHelper;
#endif

#endif /* NVM_FLASH_H */
/** @} */
