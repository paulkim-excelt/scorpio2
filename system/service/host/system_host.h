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
    @defgroup grp_sys_host_ifc SYSTEM Helper Interface
    @ingroup grp_sys_ipc

    @addtogroup grp_sys_host_ifc
    @{

    @file system_host.h
    @brief SYSTEM Helpers Interface

    @version 0.1 Initial version
*/

#ifndef SYSTEM_HOST_H
#define SYSTEM_HOST_H

#include <module_msg.h>

/**
    @name SYSTEM Helper Architecture IDs
    @{
    @brief SYSTEM Helper Architecture IDs
*/
#define BRCM_SWARCH_SYSTEM_GEN_HELPER_CTX_TYPE                (0x8E01U)   /**< @brief #SYSTEM_GenHelperCtxType          */
#define BRCM_SWARCH_SYSTEM_GEN_HELPER_CTX_GLOBAL              (0x8E02U)   /**< @brief #SYSTEM_GenHelperCtx              */
#define BRCM_SWARCH_SYSTEM_GEN_HELPERPREP_CTX_PROC            (0x8E03U)   /**< @brief #SYSTEM_GenHelperPrepCtx          */
#define BRCM_SWARCH_SYSTEM_GEN_VERSION_HELPERHDLR_PROC        (0x8E04U)   /**< @brief #SYSTEM_VersionHelperHdlr         */
#define BRCM_SWARCH_SYSTEM_GEN_REBOOT_HELPERHDLR_PROC         (0x8E05U)   /**< @brief #SYSTEM_RebootHelperHdlr          */
#define BRCM_SWARCH_SYSTEM_GEN_STARTTRAFFIC_HELPERHDLR_PROC   (0x8E06U)   /**< @brief #SYSTEM_GenStartTrafficHelperHdlr */
#define BRCM_SWARCH_SYSTEM_GEN_STOPTRAFFIC_PROC               (0x8E07U)   /**< @brief #SYSTEM_GenStopTrafficHelperHdlr  */
#define BRCM_SWARCH_SYSTEM_GEN_HELPER_GLOBAL                  (0x8E08U)   /**< @brief #SYSTEM_GenHelper                 */
#define BRCM_SWARCH_SYSTEM_HELPER_GLOBAL                      (0x8E09U)   /**< @brief #SYSTEM_Helper                    */
/** @} */

/** @brief Context structure type for System helper

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
typedef struct sSYSTEM_GenHelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context              */
    BCM_CmdType cmd;                  /**< @brief command which is in process   */
    SYS_OSSWVersionType version;      /**< @brief Get Version                   */
    SYS_TrafficType traffic;          /**< @brief Traffic Control               */
} SYSTEM_GenHelperCtxType;

/**
    @brief System Helper Module Context

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern SYSTEM_GenHelperCtxType SYSTEM_GenHelperCtx;

/**
    @brief Prepare System Generic context

    This API initialize the System Generic context

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
extern int32_t SYSTEM_GenHelperPrepCtx(char          *aStr,
                                        uint32_t      *aStrLen,
                                        SYSTEM_GenHelperCtxType *aCtx);

/**
    @brief System Get Version handler

    This API process the Get version request
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
    @param[inout]   aCtx                SYSTEM Generic Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_VersionHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_GenHelperCtxType *aCtx);
/**
    @brief System Reboot Helper handler

    This API process the reboot request
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
    @param[inout]   aCtx                SYSTEM Generic Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_RebootHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_GenHelperCtxType *aCtx);

/**
    @brief System Start Traffic Helper handler

    This API process the start traffic request
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
    @param[inout]   aCtx                SYSTEM Generic Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_GenStartTrafficHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_GenHelperCtxType *aCtx);

/**
    @brief System Stop Traffic Helper handler

    This API process the stop traffic request
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
    @param[inout]   aCtx                SYSTEM Generic Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern int32_t SYSTEM_GenStopTrafficHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         SYSTEM_GenHelperCtxType *aCtx);

/**
    @brief System Generic Helper Module

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern const MODULE_MsgConverterType SYSTEM_GenHelper;

/**
    @brief Host SYSTEM Helper Module

    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
extern const MODULE_MsgConverterType SYSTEM_Helper;
#endif /* SYSTEM_HOST_H */
/** @} */
