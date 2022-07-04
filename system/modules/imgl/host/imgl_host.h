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
    @defgroup grp_imgl_host_ifc Host Helper Interface
    @ingroup grp_imgl

    @addtogroup grp_imgl_host_ifc
    @{

    @file imgl_host.h
    @brief IMGL Helpers Interface

    @version 0.1 Initial version
*/

#ifndef IMGL_HOST_H
#define IMGL_HOST_H

/**
    @name IMGL Helper Architecture IDs
    @{
    @brief IMGL Helper Architecture IDs
*/
#define BRCM_SWARCH_IMGL_HELPER_CTX_TYPE            (0x8A01U)   /**< @brief #IMGL_HelperCtxType         */
#define BRCM_SWARCH_IMGL_HELPER_CTX_GLOBAL          (0x8A02U)   /**< @brief #IMGL_HelperCtx             */
#define BRCM_SWARCH_IMGL_HELPERPREP_CTX_PROC        (0x8A03U)   /**< @brief #IMGL_HelperPrepCtx         */
#define BRCM_SWARCH_IMGL_INSTALLCUSTOMHDLR_PROC     (0x8A04U)   /**< @brief #IMGL_InstallCustomHdlr     */
#define BRCM_SWARCH_IMGL_HELPER_GLOBAL              (0x8A05U)   /**< @brief #IMGL_Helper                */
/** @} */

/** @brief Context structure for IMGL helper

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
typedef struct sIMGL_HelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context              */
    BCM_CmdType cmd;                  /**< @brief command which is in process   */
    SYS_UpdateExecCmdType  info;
    char fileName[100];                /**< @brief Custom image file name       */
} IMGL_HelperCtxType;

/**
    @brief IMGL Helper Module Context

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
extern IMGL_HelperCtxType IMGL_HelperCtx;

/**
    @brief Prepare INGL Helper context

    This API initialize the INGL Helper context

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aStr                Input String to process
    @param[in]      aStrLen             Length of input string
    @param[out]     aCtx                INGL Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Command is identified and processed
    @retval     #BCM_ERR_INVAL_PARAMS    Invalid command request

    @post Context will be initialized

    @limitations None

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
extern int32_t IMGL_HelperPrepCtx(char          *aStr,
                                  uint32_t      *aStrLen,
                                  IMGL_HelperCtxType *aCtx);

/**
    @brief IMGL Custom install handler

    This API process the Custom install request
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
    @param[inout]   aCtx                IMGL Helper Context

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK              Request processed successfully
    @retval     #BCM_ERR_UNKNOWN         Not able to process request

    @post None

    @limitations None

    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
extern int32_t IMGL_InstallCustomHdlr(BCM_CmdType    *aMsg,
                                      uint8_t       *aBuff,
                                      uint32_t       aInputLen,
                                      uint32_t      *aOutLen,
                                      uint32_t       aMaxLength,
                                      int32_t        aResponse,
                                      IMGL_HelperCtxType *aCtx);
#endif /* IMGL_HOST_H */
/** @} */
