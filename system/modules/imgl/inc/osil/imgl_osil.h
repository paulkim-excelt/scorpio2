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

/**
    @defgroup grp_imgl_osil_ifc Integration Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_osil_ifc
    @{

    Below image describes a typical flow of fetching and verifying an executable
    image using IMGL APIs and XXX example Loader.

    @tagseq imgl_sync_seq_diagram.svg "Sequence diagram"
    @startseq
    group {label = "client"; color = "#EFFFFF";  Client;};
    group {label = "imgl"; color = "#FFEFFF"; IMGL;};
    group {label = "module"; color = "#FFFFEF"; XXX_Loader;};
    group {label = "imgl_security"; color = "#FFFFEF"; IMGL_SECURITY;};

    Client => IMGL [label = "IMGL_Init", return = "return"] {
        IMGL => IMGL_SECURITY [label = "IMGL_AuthInit"];
    };
    Client => IMGL [label = "IMGL_StateHandler", return = "return"] {
        IMGL => XXX_Loader [label = "XXX_GetState"];
        IMGL => XXX_Loader [label = "XXX_FetchPTBL"];
        IMGL => XXX_Loader [label = "XXX_FetchITBL"];
    };
    Client => IMGL [label = "IMGL_GetState", return = "return"];
    === Initialization Complete ===

    === Load Image Start ===
    Client => IMGL [label = "IMGL_LoadImg", return = "return"];
    Client => IMGL [label = "IMGL_StateHandler", return = "return"] {
        IMGL => IMGL_SECURITY [label = "IMGL_CipherInit"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashInit"];
        IMGL => XXX_Loader [label = "XXX_GetState"];
        IMGL => XXX_Loader [label = "XXX_FetchImg"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthStatus"];
    };
    Client => IMGL [label = "IMGL_GetStatus", return = "return"];
    === Load Image End ===

    === Fetch Executable Start ===
    Client => IMGL [label = "IMGL_FetchExe", return = "return"];
    Client => IMGL [label = "IMGL_StateHandler", return = "return"] {
        IMGL => IMGL_SECURITY [label = "IMGL_CipherInit"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashInit"];
        IMGL => XXX_Loader [label = "XXX_GetState"];
        IMGL => XXX_Loader [label = "XXX_FetchITBL"];
        IMGL => XXX_Loader [label = "XXX_FetchImg"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthStatus"];
    };
    Client => IMGL [label = "IMGL_FetchExeStatus", return = "return"];
    === Fetch Executable End ===

    === Update Partition Start ===
    Client => IMGL [label = "IMGL_UpdatePartition", return = "return"];
    Client => IMGL [label = "IMGL_StateHandler", return = "return"] {
        IMGL => IMGL_SECURITY [label = "IMGL_CipherInit"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashInit"];
        IMGL => XXX_Loader [label = "XXX_GetState"];
        IMGL => XXX_Loader [label = "XXX_FetchPTBL"];
        IMGL => XXX_Loader [label = "XXX_FetchITBL"];
        IMGL => XXX_Loader [label = "XXX_FetchImg"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashStatus"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthReq"];
        IMGL => IMGL_SECURITY [label = "IMGL_AuthStatus"];
        IMGL => XXX_Loader [label = "XXX_WriteImg"];
    };
    Client => IMGL [label = "IMGL_UpdateStatus", return = "return"];
    === Update Partition End ===

    Client => IMGL [label = "IMGL_Deinit", return = "return"] {
        IMGL => IMGL_SECURITY [label = "IMGL_AuthDeinit"];
        IMGL => IMGL_SECURITY [label = "IMGL_CipherDeinit"];
        IMGL => IMGL_SECURITY [label = "IMGL_HashDeinit"];
    }
    === Deinitialization Complete ===
    @endseq

    @limitations None

    @file imgl_osil.h
    @brief IMGL Integration interface
    This header file contains the integration interface functions for IMGL

    @version 0.1 Initial Version
*/

#ifndef IMGL_OSIL_H
#define IMGL_OSIL_H

#include <stdint.h>
#include <imgl.h>
#include <imgl_memory.h>

/**
    @name IMGL Integration Architecture IDs
    @{
    @brief Architecture IDs for IMGL Integration
*/
#define BRCM_SWARCH_IMGL_CMD_TYPE                     (0x9201U)    /**< @brief #IMGL_CmdType             */
#define BRCM_SWARCH_IMGL_LOAD_IMG_MSG_TYPE            (0x9202U)    /**< @brief #IMGL_LoadImgMsgType      */
#define BRCM_SWARCH_IMGL_GET_MSGQ_PROC                (0x9203U)    /**< @brief #IMGL_GetMsgQ             */
#define BRCM_SWARCH_IMGL_GET_EVENT_MASK_PROC          (0x9204U)    /**< @brief #IMGL_GetEventMask        */
#define BRCM_SWARCH_IMGL_GET_MSG_PROC                 (0x9205U)    /**< @brief #IMGL_GetMsg              */
#define BRCM_SWARCH_IMGL_INTERFACES_GLOBAL            (0x9206U)    /**< @brief #IMGL_Interfaces          */
#define BRCM_SWARCH_IMGL_MOD_EVENT_GLOBAL             (0x9207U)    /**< @brief #IMGL_ModEvent            */
#define BRCM_SWARCH_IMGL_GET_BL_ADDR_PROC             (0x9208U)    /**< @brief #IMGL_GetBLAddr           */
#define BRCM_SWARCH_IMGL_GET_SERVER_PROC              (0x9209U)    /**< @brief #IMGL_GetServer           */
/** @} */

/**
    @name IMGL Load Image Cmd
    @{
    @brief IMGL Load Image Cmd

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION
*/
typedef uint32_t IMGL_CmdType;
#define IMGL_CMD_LOAD_NORMAL    (0UL)   /**< @brief Normal Load */
#define IMGL_CMD_LOAD_RAW       (1UL)   /**< @brief Raw Load    */
/** @} */

/**
    @brief Message Type for IMGL load Message Queue

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION
*/
typedef struct sIMGL_LoadImgMsgType {
    IMGL_CmdType        cmd;        /**< @brief Commad                  */
    IMGL_ModeType       mode;       /**< @brief Fetched load mode       */
    PTBL_IdType         pid;        /**< @brief Partition ID            */
    uint16_t            imgID;      /**< @brief Image ID                */
    uint8_t             *loadAddr;  /**< @brief Address buffer where image shall be loaded */
    uint32_t            bufferSize; /**< @brief Length of the buffer    */
    uint32_t            offset;     /**< @brief Offset within the image */
    uint32_t            actSize;    /**< @brief Actual length of the image */
    int32_t             result;     /**< @brief Result of the last request */
} IMGL_LoadImgMsgType;

/** @brief Get IMGL Message Queue

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return     IMGL Message Queue

    @post None

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
const MSGQ_Type* IMGL_GetMsgQ(void);

/** @brief Get IMGL Event

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      void

    @return     IMGL Event Mask

    @post None

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
uint32_t IMGL_GetEventMask(void);

/** @brief Returns the server message

    Returns the server message indexed by @c aIdx. This interface is used by the
    @ref grp_msgq core.

    @behavior Sync, Non-reentrant

    @pre TBD

    @param[in]      aIdx        Index of the message

    Return values are documented in reverse-chronological order
    @retval     void*                   void pointer to message

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
void *IMGL_GetMsg(uint32_t aIdx);

/**
    @brief List of Enabled modes for loading Images

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION
*/
extern const IMGL_InterfaceType* const IMGL_Interfaces[IMGL_LOAD_MODE_MAX];

/** @brief Global to translate the OS event to U32 for Imgl module
    operation

    @trace #BRCM_SWREQ_IMGL_CORE
*/
extern const uint32_t IMGL_ModEvent;

/** @brief Returns the bootloader address

    Returns the boot loader address

    @behavior Sync, Non-reentrant

    @pre TBD

    @param[in]      void

    Return values are documented in reverse-chronological order
    @retval     uint32_t*                Pointer to bootloader

    @post TBD

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
uint32_t* IMGL_GetBLAddr(void);


/** @brief Get IMGL Server details

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aServerTask     Server Task ID
    @param[out]     aServerEvent    Server Event ID

    @return     void

    @post None

    @note This interface shall be implemented by the integrator.

    @trace #BRCM_SWREQ_IMGL_CORE

    @limitations None
*/
void IMGL_GetServer(int32_t *aServerTask, uint32_t *aServerEvent);

#endif /* IMGL_OSIL_H */

/** @} */
