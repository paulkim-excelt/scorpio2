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
/** @defgroup grp_pchdrv_il Integration Guide
    @ingroup grp_pchdrv

    @addtogroup grp_pchdrv_il
    @{
    @section sec_pchdrv_integration Integration Guide
    This section serves as the integration guide to integrate this driver into
    the system. This section describes Patch Driver IL in more detail.

    @file pchdrv_osil.h
    @brief Patch Integration Interfaces
    This header file contains the integration interface for Patch driver.
    @version 0.1 Initial revision
*/
#ifndef PCHDRV_OSIL_H
#define PCHDRV_OSIL_H

#include <pchdrv.h>
#include <svc.h>

/**
    @name Patch driver interface IDs
    @{
    @brief Patch driver integration interface IDs.
*/
#define BRCM_SWARCH_PATCH_CMD_TYPE              (0x9101U)    /**< @brief #PATCH_CmdType           */
#define BRCM_SWARCH_PATCH_PATCH_FUNC_TYPE       (0x9102U)    /**< @brief #PATCH_PatchFuncType     */
#define BRCM_SWARCH_PATCH_SYS_CMD_REQ_PROC      (0x9103U)    /**< @brief #PATCH_SysCmdReq         */
#define BRCM_SWARCH_PATCH_CMD_HANDLER_PROC      (0x9104U)    /**< @brief #PATCH_CmdHandler        */
#define BRCM_SWARCH_PATCH_CMD_DEF_ISR_PROC      (0x9105U)    /**< @brief #PATCH_DefaultInterruptHandler */
#define BRCM_SWARCH_PATCH_IO_TYPE               (0x9106U)    /**< @brief #PATCH_IOType            */
/** @} */

/**
    @name Patch Driver commands
    @{
    @brief List of Patch Driver commands

    Patch Driver specific commands handled by PATCH_CmdHandler

    @trace #BRCM_SWREQ_PATCH_KERNEL_INTERFACE
*/
typedef uint32_t PATCH_CmdType;
#define PATCH_CMD_INIT              (1UL)   /**< @brief Execute Patch routine */
#define PATCH_CMD_EXEC              (2UL)   /**< @brief Execute Patch routine */
#define PATCH_CMD_DEINIT            (3UL)   /**< @brief Execute Patch routine */
/** @} */

/**
    @brief Patch Driver IO structure passed from SysCmdReq
    to SysCmdHandler (for privileged access)

    @trace #BRCM_SWREQ_PATCH_KERNEL_INTERFACE
 */
typedef struct sPATCH_IOType {
    int32_t         retVal;             /**< @brief Return value from PATCH_CmdHandler */
    uint16_t        compId;             /**< @brief Component id param                  */
    uint16_t        patchId;            /**< @brief Patch id param                      */
    uint32_t const *patchImg;           /**< @brief Patch image data                    */
    uint32_t        patchImgSize;       /**< @brief Patch image size in words           */
} PATCH_IOType;

/**
    @brief Patch routine function prototype

    The patch routines shall be implemented based on this prototype.

    @behavior Sync/Async, Re-entrant/Non-reentrant

    @pre None

    @param[in]      aArg0  0th argument for the patch routine
    @param[in]      aArg1  1st argument for the patch routine
    @param[in]      aArg2  2nd argument for the patch routine
    @param[in]      aArg3  3rd argument for the patch routine

    @return void

    @post None

    @trace #BRCM_SWREQ_PATCH

    @limitations None
*/

typedef void (*PATCH_PatchFuncType)(uint32_t aArg0, uint32_t aArg1, uint32_t aArg2, uint32_t aArg3);

/**
    @brief Patch Driver command requestor

    Interface to raise System Command Request for Patch driver.

    @behavior Sync/Async, Re-entrant/Non-reentrant

    @pre None

    @param[in]      aCmd        Command requested by user
    @param[inout]   aPchdrvIO   In-Out structure containing request parameters

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            System command request completed successfully
    @retval  #BCM_ERR_INVAL_PARAMS  aCmd is invalid or aPchdrvIO is NULL
    @retval  #BCM_ERR_UNKNOWN       Integration error

    @post None

    @note To be implemented by Integrator.

    @trace #BRCM_SWREQ_PATCH_KERNEL_INTERFACE

    @limitations None
*/
int32_t PATCH_SysCmdReq(PATCH_CmdType aCmd, PATCH_IOType *aPchdrvIO);

/**
    @brief Patch Driver command handler

    This interface handles all the Patch driver commands requested from system
    command request. This interface shall be implemented by the integrator and
    shall hook it to SVC layer as per Architecture.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aMagic      Patch Driver magic number
    @param[inout]   aCmd        Command requested by SysCmdReq
    @param[out]     aPchSysIO   uint8_t * request to be interpreted as PATCH_IOType

    @return void (for void functions)

    @post None

    @note To be implemented by Integrator.

    @trace #BRCM_SWREQ_PATCH_KERNEL_HANDLER

    @limitations None
*/
void PATCH_CmdHandler(uint32_t aMagic, uint32_t aCmd, uint8_t *aPchSysIO);

/**
    @brief Default interrupt handler hook

    This function should be invoked for all the un-handled interrupts.
    This function calls the corresponding interrupt patch routine
    if available as part of the patch binary.

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aIntNum      Current Interrupt number

    @return void (for void functions)

    @post None

    @trace #BRCM_SWREQ_PATCH_KERNEL_HANDLER

    @limitations None
*/
void PATCH_DefaultInterruptHandler(uint32_t aIntNum);

#endif /* PCHDRV_OSIL_H */
/** @} */
