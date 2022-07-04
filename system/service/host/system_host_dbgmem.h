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
    @defgroup grp_sys_host_debug_ifc SYSTEM Debug Helper Interface
    @ingroup grp_sys_ipc

    @addtogroup grp_sys_host_debug_ifc
    @{

    @file system_host_dbgmem.h
    @brief SYSTEM Debug Helpers Interface

    @version 0.1 Initial version
*/

#ifndef SYSTEM_HOST_DBGMEM_H
#define SYSTEM_HOST_DBGMEM_H

#include <module_msg.h>

/**
    @name SYSTEM Debug Helper Architecture IDs
    @{
    @brief SYSTEM Debug Helper Architecture IDs
*/
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_CTX_TYPE            (0x8F01U)   /**< @brief #SYSTEM_DebugMemHelperCtxType   */
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_CTX_GLOBAL          (0x8F02U)   /**< @brief #SYSTEM_DebugMemHelperCtx       */
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPERPREP_CTX_PROC        (0x8F03U)   /**< @brief #SYSTEM_DebugMemHelperPrepCtx   */
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_READ_HELPER_HDLR_PROC      (0x8F04U)   /**< @brief #SYSTEM_DebugReadHelperHdlr     */
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_WRITE_HELPER_HDLR_PROC     (0x8F05U)   /**< @brief #SYSTEM_DebugMemWriteHelperHdlr */
#define BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_GLOBAL              (0x8F06U)   /**< @brief #SYSTEM_DebugMemHelper          */
/** @} */

/** @brief Context structure type for Memory helper

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
typedef struct sSYSTEM_DebugMemHelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context              */
    BCM_CmdType cmd;                  /**< @brief command which is in process   */
    SYS_MemAccessType   mem;          /**< @brief memory information            */
} SYSTEM_DebugMemHelperCtxType;

/**
    @brief Memory Commands Helper Context

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern SYSTEM_DebugMemHelperCtxType SYSTEM_DebugMemHelperCtx;

/**
    @brief Prepare Memory Commands context

    This API initialize the Memory commands context for read and write

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStr                Input String to process
    @param[in]      aStrLen             Length of input string
    @param[out]     aCtx                System Generic Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Command is identified and processed
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid command request

    @post Context will be initialized

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_DebugMemHelperPrepCtx(char          *aStr,
                                        uint32_t      *aStrLen,
                                        SYSTEM_DebugMemHelperCtxType *aCtx);

/**
    @brief System Memory Read Helper handler

    This API process the Memory read request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                SYSTEM Memory Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_ReadHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_DebugMemHelperCtxType *aCtx);
/**
    @brief System Memory Write Helper handler

    This API process the memory write request
    Update the state to #BCM_STATE_SUB_STATE_DONE on completion

    @behavior Sync, Non-reentrant

    @pre None

    @param[inout]   aMsg                Message ID (group, comp, cmd)
    @param[inout]   aBuff               output buffer for the the command
                                        input for the response
    @param[in]      aInputLen           Length of input response data buffer.
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aMaxLength          Maximum length of the payload
    @param[in]      aResponse           Response error code of the processing message
    @param[inout]   aCtx                SYSTEM Memory Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_DebugMemWriteHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_DebugMemHelperCtxType *aCtx);

/**
    @brief System Memory Helper Module

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern const MODULE_MsgConverterType SYSTEM_DebugMemHelper;
#endif /* SYSTEM_HOST_DBGMEM_H */
/** @} */
