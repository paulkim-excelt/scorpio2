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
    @defgroup grp_imgl_host_impl  Host Helper Design
    @ingroup grp_imgl

    @addtogroup grp_imgl_host_impl
    @{

    @file imgl_host.c
    @brief IMGL Helper Implementation

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <unistd.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <sys_ipc_cmds.h>
#include <imgl_host.h>
#include <string.h>
#include <imgl_interface.h>

/**
    @name IMGL Helper Design IDs
    @{
    @brief IMGL Helper Design IDs
*/
#define BRCM_SWDSGN_IMGL_HELPER_CTX_GLOBAL       (0xBE01U)     /**< @brief #IMGL_HelperCtx             */
#define BRCM_SWDSGN_IMGL_HELP_GLOBAL             (0xBE02U)     /**< @brief #IMGL_HelpCmds              */
#define BRCM_SWDSGN_IMGL_HELPERPREP_CTX_PROC     (0xBE03U)     /**< @brief #IMGL_HelperPrepCtx         */
#define BRCM_SWDSGN_IMGL_INSTALLCUSTOMHDLR_PROC  (0xBE04U)     /**< @brief #IMGL_InstallCustomHdlr     */
#define BRCM_SWDSGN_IMGL_HELPERPROCESS_PROC      (0xBE05U)     /**< @brief #IMGL_HelperProcess         */
#define BRCM_SWDSGN_IMGL_HELPER_GLOBAL           (0xBE06U)     /**< @brief #IMGL_HostHelper            */
#define BRCM_SWDSGN_IMGL_PRINT_HELPER_PROC       (0xBE07U)     /**< @brief #IMGL_PrintHelper           */
#define BRCM_SWDSGN_IMGL_COMPNAMELEN_MACRO       (0xBE08U)     /**< @brief #IMGL_COMP_STR_MAX_LEN      */
#define BRCM_SWDSGN_IMGL_CMDIDVAL_DEBUG_MACRO    (0xBE09U)     /**< @brief #IMGL_CMDIDVAL_DEBUG        */
/** @} */

/**
    @brief IMGL Helper Module Context

    @trace #BRCM_SWARCH_IMGL_HELPERPREP_CTX_PROC
    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
IMGL_HelperCtxType IMGL_HelperCtx;

/**
    @brief IMGL Supported commands

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
static const char IMGL_HelpCmds[] = "<img>\n"
"\r\"This command valid only after 30Sec of PowerOn\"\n";

/**
    @brief IMGL Component Name Length

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
#define IMGL_COMP_STR_MAX_LEN    (13U)

/**
    @brief IMGL CMDID value for Debug

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
#define IMGL_CMDIDVAL_DEBUG      (0x40U)

/**
    @brief Prepare IMGL Helper context

    @trace #BRCM_SWARCH_IMGL_HELPERPREP_CTX_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    @endcode
*/
int32_t IMGL_HelperPrepCtx(char          *aStr,
                          uint32_t      *aStrLen,
                          IMGL_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) && (remStrLen == 0)) {
                    memcpy(aCtx->fileName, currStr, currStrLen);
                    aCtx->fileName[currStrLen] = '\0';
                    aCtx->cmd = SYS_CMDID_FLASH_UPDATE;
                    retVal = BCM_ERR_OK;
                }
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @brief IMGL Install custom Handler

    @trace #BRCM_SWARCH_IMGL_INSTALLCUSTOMHDLR_PROC
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    @endcode
*/
int32_t IMGL_InstallCustomHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                uint32_t       aInputLen,
                                uint32_t      *aOutLen,
                                uint32_t       aMaxLength,
                                int32_t        aResponse,
                                IMGL_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    SYS_HandleType respMsg;

    respMsg.u8Ptr = aBuff;
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            strcpy((char*)aBuff, &aCtx->fileName[0]);
            *aMsg = BCM_CMDID(BCM_GROUPID_SYS, BCM_RPC_ID, SYS_CMDID_IMGL_HDR_REQ);
            *aOutLen = sizeof(aCtx->fileName);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to program the flash memory err=%d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(SYS_UpdateExecCmdType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(respMsg.update, aBuff, sizeof(SYS_UpdateExecCmdType));
                respMsg.update->flashId = CPU_NativeToLE32(0UL);
                respMsg.update->fetchChannel = IMGL_CHANNEL_ID_RPC_IPC;
                *aMsg = BCM_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, SYS_CMDID_FLASH_UPDATE);
                *aOutLen = sizeof(SYS_UpdateExecCmdType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to program the flash memory err=%d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief Process IMGL request string or response byte array

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    @endcode
*/
static int32_t IMGL_HelperProcess(BCM_CmdType    *aMsg,
                                  char          *aStr,
                                  uint32_t      *aStrLen,
                                  uint8_t       *aInOut,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == IMGL_HelperCtx.modCtx.substate) {
        retVal = IMGL_HelperPrepCtx(aStr, aStrLen,
                                          &IMGL_HelperCtx);
        if(BCM_ERR_OK ==retVal) {
            IMGL_HelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(IMGL_HelperCtx.cmd) {
        case SYS_CMDID_FLASH_UPDATE:
            retVal = IMGL_InstallCustomHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &IMGL_HelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief IMGL Print Helper

    Print IMGL Responses to console

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE

    @code{.unparsed}
    @endcode
*/
static int32_t IMGL_PrintHelper(BCM_CmdType aCmd,
                                uint8_t     *aMsg,
                                uint32_t    aSize)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint8_t notificationId;
    BCM_DbgMsgType *dbg;
    BCM_DbgMsgType *dbgMsgs;
    uint32_t i;
    char compName[IMGL_COMP_STR_MAX_LEN];

    if (NULL != aMsg) {
        if (0UL != (aCmd & BCM_CMD_ASYNC_MASK)) {
            notificationId = BCM_GET_CMDID(aCmd);
            switch(notificationId) {
                case IMGL_CMDIDVAL_DEBUG:
                    retVal = BCM_ERR_OK;
                    dbgMsgs = (BCM_DbgMsgType*)aMsg;
                    for (i = 0UL; i < (aSize/sizeof(BCM_DbgMsgType)); i++) {
                        dbg = &dbgMsgs[i];
                        BCM_ConvertCompToStr(dbg->comp,compName);
                        /* String NULL Termination */
                        compName[IMGL_COMP_STR_MAX_LEN - 1U]= '\0';
                        (void)MODULE_HostHelperLog("[%u.%03u] [bootMode[0x%x](0-NONE,1-ROM, 2-BL, 3-FW) [dev:0x%03x] [%s] [inst:0x%02x] [id:0x%04x] ",
                                                dbg->timeMS/1000,
                                                (dbg->timeMS %1000),
                                                dbg->bootMode,
                                                dbg->devInfo,
                                                compName,
                                                dbg->instance,
                                                dbg->api);
                        (void)MODULE_HostHelperLog("[line:%05u] [state:0x%02x] [error:0x%02x] [custom:0x%08x,0x%08x,0x%08x,0x%08x]\n",
                                                dbg->line,
                                                dbg->state,
                                                dbg->error,
                                                dbg->custom[0UL],
                                                dbg->custom[1UL],
                                                dbg->custom[2UL],
                                                dbg->custom[3UL]);

                    }
                    break;
                default:
                    break;
            }
        }
    }

    return retVal;
}

/**
    @brief Switch IMGL Helper

    @trace #BRCM_SWARCH_IMGL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_IMGL_ABSTRACTION_CORE
*/
const MODULE_MsgConverterType IMGL_HostHelper = {
    .helpstr = IMGL_HelpCmds,
    .context = &IMGL_HelperCtx.modCtx,
    .process = IMGL_HelperProcess,
    .print   = IMGL_PrintHelper,
};

/** @} */
