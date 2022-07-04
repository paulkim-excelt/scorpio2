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
    @defgroup grp_system_dmon_host_impl DMON Host Helper Design
    @ingroup grp_system_abstract

    @addtogroup grp_system_dmon_host_impl
    @{

    @file system_dmon_host.c
    @brief Device Monitor Host Helper Design

    @version 1.0 Initial version
*/
#include <stdio.h>
#include <unistd.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <system_dmon.h>
#include <string.h>
#include <bcm_utils.h>

/**
    @name Device Monitor Host Helper Design IDs
    @{
    @brief Device Monitor Host Design IDs
*/
#define BRCM_SWDSGN_DMON_GEN_HELPERCMDS_GLOBAL             (0xBD00U)   /**< @brief #DMON_HostHelperCmds            */
#define BRCM_SWDSGN_DMON_GEN_HELPER_CTX_GLOBAL             (0xBD01U)   /**< @brief #DMON_HostHelperCtx             */
#define BRCM_SWDSGN_DMON_GEN_HELPERPREP_CTX_PROC           (0xBD02U)   /**< @brief #DMON_HostHelperPrepCtx         */
#define BRCM_SWDSGN_DMON_GEN_VERSION_HELPERHDLR_PROC       (0xBD03U)   /**< @brief #DMON_HostVersionHelperHdlr     */
#define BRCM_SWDSGN_DMON_GEN_REBOOT_HELPERHDLR_PROC        (0xBD04U)   /**< @brief #DMON_HostRebootHelperHdlr      */
#define BRCM_SWDSGN_DMON_GEN_HELPERPROCESS_PROC            (0xBD05U)   /**< @brief #DMON_HostHelperProcess         */
#define BRCM_SWDSGN_DMON_GEN_HELPER_GLOBAL                 (0xBD06U)   /**< @brief #DMON_HostHelper                */

#define BRCM_SWDSGN_DMON_DBG_HELPER_CTX_GLOBAL             (0xBD20U)   /**< @brief #DMON_HostDbgHelperCtx          */
#define BRCM_SWDSGN_DMON_DBG_HELPERCMDS_GLOBAL             (0xBD21U)   /**< @brief #DMON_HostDbgHelperCmds         */
#define BRCM_SWDSGN_DMON_DBG_HELPERPREP_CTX_PROC           (0xBD22U)   /**< @brief #DMON_HostDbgHelperPrepCtx      */
#define BRCM_SWDSGN_DMON_DBG_HELPER_GLOBAL                 (0xBD23U)   /**< @brief #DMON_HostDbgHelper             */
#define BRCM_SWDSGN_DMON_DBG_WRITE_HELPER_HDLR_PROC        (0xBD24U)   /**< @brief #DMON_HostDbgWriteHelperHdlr    */
#define BRCM_SWDSGN_DMON_DBG_READ_HELPER_HDLR_PROC         (0xBD25U)   /**< @brief #DMON_HostDbgReadHelperHdlr     */
#define BRCM_SWDSGN_DMON_DBG_HELPERPROCESS_PROC            (0xBD26U)   /**< @brief #DMON_HostDbgHelperProcess      */

#define BRCM_SWDSGN_DMON_ASYNC_HELPER_CTX_GLOBAL           (0xBD30U)   /**< @brief #DMON_AsyncHelperCtx            */
#define BRCM_SWDSGN_DMON_ASYNC_HELPERCMDS_GLOBAL           (0xBD31U)   /**< @brief #DMON_AsyncHelperCmds           */
#define BRCM_SWDSGN_DMON_ASYNC_HELPERPREP_CTX_PROC         (0xBD32U)   /**< @brief #DMON_AsyncHelperPrepCtx        */
#define BRCM_SWDSGN_DMON_ASYNC_HEARTBEAT_HELPERHDLR_PROC   (0xBD33U)   /**< @brief #DMON_AsyncHeartBeatHelperHdlr  */
#define BRCM_SWDSGN_DMON_ASYNC_HELPERPROCESS_PROC          (0xBD34U)   /**< @brief #DMON_AsyncHelperProcess        */
#define BRCM_SWDSGN_DMON_ASYNC_HELPER_GLOBAL               (0xBD35U)   /**< @brief #DMON_HostAsyncHelper           */

#define BRCM_SWDSGN_DMON_HOST_CTXINT_TYPE                  (0xBD40U)   /**< @brief #DMON_HostContextIntType        */
/** @} */


/**
    @brief Device Monitor Internal context Type

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
typedef struct sDMON_HostContextIntType {
    MODULE_MsgContextType   modCtx;
    DMON_HostContextType    ctx;
} DMON_HostContextIntType;

/**
    @brief Device Monitor Helper context

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
static DMON_HostContextIntType DMON_HostHelperCtx;

/**
    @brief System Generic Supported commands

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
static const char DMON_HostHelperCmds[] =
 "\n"
 ;


/**
    @brief Prepare Device Monitor Helper context

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostHelperPrepCtx(char          *aStr,
                                uint32_t      *aStrLen,
                                DMON_HostContextIntType *aCtx)
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
        if (0 == strncmp(currStr, "version", 7)) {
            if ((remStr == NULL) && (remStrLen == 0UL)) {
                aCtx->ctx.id = DMON_ID_SW_VERSION;
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else if (0 == strncmp(currStr, "reboot", 6)) {
            if ((remStr == NULL) && (remStrLen == 0UL)) {
                aCtx->ctx.id = DMON_ID_REBOOT;
                retVal = BCM_ERR_OK;
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    return retVal;
}

/**
    @brief System version Handler

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostVersionHelperHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                uint32_t       aInputLen,
                                uint32_t      *aOutLen,
                                uint32_t       aMaxLength,
                                int32_t        aResponse,
                                DMON_HostContextIntType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = DMON_ID_SW_VERSION;
            *aOutLen = 0UL;
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get version, retVal=%d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(DMON_SwVersionMsgType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(aCtx->ctx.msg.swVersion.str, aBuff, sizeof(DMON_SwVersionMsgType));
                (void)MODULE_HostHelperLog("%s\n", aCtx->ctx.msg.swVersion.str);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief System reboot Handler

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostRebootHelperHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                uint32_t       aInputLen,
                                uint32_t      *aOutLen,
                                uint32_t       aMaxLength,
                                int32_t        aResponse,
                                DMON_HostContextIntType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            aCtx->ctx.msg.reboot.delayMs = CPU_NativeToLE32(10UL);
            BCM_MemCpy(aBuff, &aCtx->ctx.msg.reboot, sizeof(DMON_RebootMsgType));
            *aMsg = DMON_ID_REBOOT;
            *aOutLen = sizeof(DMON_RebootMsgType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Reboot Failed\n");
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("Rebooted \n");
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief Process generic system request string or response byte array

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == DMON_HostHelperCtx.modCtx.substate) {
        retVal = DMON_HostHelperPrepCtx(aStr, aStrLen,
                                          &DMON_HostHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            DMON_HostHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(DMON_HostHelperCtx.ctx.id) {
        case DMON_ID_SW_VERSION:
            retVal = DMON_HostVersionHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &DMON_HostHelperCtx);
            break;
        case DMON_ID_REBOOT:
            retVal = DMON_HostRebootHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &DMON_HostHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief System Generic Helper context

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
static DMON_HostContextIntType DMON_HostDbgHelperCtx;

/**
    @brief Supported Memory commands

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
static const char DMON_HostDbgHelperCmds[] =
"read <addr> <width 8|16|32> <0:master|1:slave>\n"
"write <addr> <width 8|16|32> <data> <0:master|1:slave>\n";

/**
    @brief Prepare Memory Commands context

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostDbgHelperPrepCtx(char          *aStr,
                                uint32_t      *aStrLen,
                                DMON_HostContextIntType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    uint32_t isWrite = 0;
    uint32_t addr = 0;
    uint32_t width = 0;
    uint32_t data = 0;
    uint32_t destn;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStr != 0)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            if (!strncmp(currStr, "read", 4)) {
                isWrite = 0;
            } else if (!strncmp(currStr, "write", 5)) {
                isWrite = 1;
            } else {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            /* Fetch the address */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            addr = MODULE_MsgParseInt(currStr, &parseStatus);
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;

            /* Fetch the width */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            width = MODULE_MsgParseInt(currStr, &parseStatus);
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            if ((width != 8) && (width != 16) && (width != 32)) {
                (void)MODULE_HostHelperLog("Unsupported width:%u\n", width);
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;

            if (isWrite == 0) {
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

                destn = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }

                if (DMON_DEVICE_SLAVE_1 < destn) {
                    (void)MODULE_HostHelperLog("read <addr> <width 8|16|32> <device ID [0|1]>\n");
                    goto done;
                }

                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->ctx.msg.memAccess.addr = CPU_NativeToLE32(addr);
                aCtx->ctx.msg.memAccess.width = CPU_NativeToLE32(width);
                aCtx->ctx.msg.memAccess.len = CPU_NativeToLE32(1UL);
                aCtx->ctx.msg.memAccess.deviceID = CPU_NativeToLE32(destn);
                aCtx->ctx.id = DMON_ID_MEM_READ;
                retVal = BCM_ERR_OK;
            } else {
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }
                data = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }

                currStr = remStr;
                currStrLen = remStrLen;

                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

                destn = MODULE_MsgParseInt(currStr, &parseStatus);
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                if (DMON_DEVICE_SLAVE_1 < destn) {
                    (void)MODULE_HostHelperLog("write <addr> <width 8|16|32> <device ID [0|1]>\n");
                    goto done;
                }

                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                memset(aCtx->ctx.msg.memAccess.data, 0U, sizeof(aCtx->ctx.msg.memAccess.data));
                data = CPU_NativeToLE32(data);
                BCM_MemCpy(aCtx->ctx.msg.memAccess.data, &data,sizeof(data));
                aCtx->ctx.msg.memAccess.addr = CPU_NativeToLE32(addr);
                aCtx->ctx.msg.memAccess.width = CPU_NativeToLE32(width);
                aCtx->ctx.msg.memAccess.len = CPU_NativeToLE32(1UL);
                aCtx->ctx.msg.memAccess.deviceID = CPU_NativeToLE32(destn);
                aCtx->ctx.id = DMON_ID_MEM_WRITE;
                retVal = BCM_ERR_OK;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

done:
    return retVal;
}

/**
    @brief Memory write helper Handler

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostDbgWriteHelperHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   DMON_HostContextIntType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            BCM_MemCpy(aBuff, &aCtx->ctx.msg.memAccess, sizeof(DMON_MemAccessMsgType));
            *aMsg = DMON_ID_MEM_WRITE;
            *aOutLen = sizeof(DMON_MemAccessMsgType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in memory write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(DMON_MemAccessMsgType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
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


/**
    @brief Memory Read helper Handler

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostDbgReadHelperHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   DMON_HostContextIntType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t data = 0;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            BCM_MemCpy(aBuff, &aCtx->ctx.msg.memAccess, sizeof(DMON_MemAccessMsgType));
            *aMsg = DMON_ID_MEM_READ;
            *aOutLen = sizeof(DMON_MemAccessMsgType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in memory write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(DMON_MemAccessMsgType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                BCM_MemCpy(&aCtx->ctx.msg.memAccess, aBuff, sizeof(DMON_MemAccessMsgType));
                BCM_MemCpy(&data, aCtx->ctx.msg.memAccess.data,sizeof(data));
                data = CPU_NativeToLE32(data);
                if (8U == aCtx->ctx.msg.memAccess.width) {
                    (void)MODULE_HostHelperLog("0x%02X\n", data);
                } else if (16U == aCtx->ctx.msg.memAccess.width) {
                    (void)MODULE_HostHelperLog("0x%04X\n", data);
                } else if (32U == aCtx->ctx.msg.memAccess.width) {
                    (void)MODULE_HostHelperLog("0x%08X\n", data);
                }
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief Process memory read and write request string or response byte array

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_HostDbgHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == DMON_HostDbgHelperCtx.modCtx.substate) {
        retVal = DMON_HostDbgHelperPrepCtx(aStr, aStrLen,
                                          &DMON_HostDbgHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            DMON_HostDbgHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(DMON_HostDbgHelperCtx.ctx.id) {
        case DMON_ID_MEM_WRITE:
            retVal = DMON_HostDbgWriteHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &DMON_HostDbgHelperCtx);
            break;
        case DMON_ID_MEM_READ:
            retVal = DMON_HostDbgReadHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &DMON_HostDbgHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Async Helper context

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
DMON_HostContextIntType DMON_AsyncHelperCtx;

/**
    @brief Async Supported commands

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
static const char DMON_AsyncHelperCmds[] =
 "\n"
 ;

/**
    @brief Prepare async request context

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_AsyncHelperPrepCtx(char          *aStr,
                                  uint32_t      *aStrLen,
                                  DMON_HostContextIntType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);/* async */
        currStr = remStr;
        currStrLen = remStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (0UL == strncmp(currStr, "count", 5)) {
            if ((remStr != NULL) && (remStrLen != 0UL)) {
                currStr = remStr;
                currStrLen = remStrLen;
                /* skip the first string which is validated in the above layer */
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) && (remStrLen == 0UL)) {
                    if (strncmp(currStr, "heartbeat", 9) == 0UL) {
                        aCtx->ctx.id = DMON_ID_HEART_BEAT;
                        retVal = BCM_ERR_OK;
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @brief Async Heart Beat handler

    Print the alive message with time stamp

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_AsyncHeartBeatHelperHdlr(BCM_CmdType    *aMsg,
                                         uint8_t       *aBuff,
                                         uint32_t       aInputLen,
                                         uint32_t      *aOutLen,
                                         uint32_t       aMaxLength,
                                         int32_t        aResponse,
                                         DMON_HostContextIntType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_SYS, BCM_RPC_ID, BCM_GET_CMDID(DMON_ID_HEART_BEAT));
            *aOutLen = sizeof(DMON_HeartBeatMsgType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to get HeartBeat, retVal=%d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(DMON_HeartBeatMsgType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                BCM_MemCpy(aCtx->ctx.msg.data, aBuff, sizeof(DMON_HeartBeatMsgType));
                aCtx->ctx.msg.heartbeat.upTime.s = CPU_LEToNative32(aCtx->ctx.msg.heartbeat.upTime.s);
                aCtx->ctx.msg.heartbeat.upTime.ns = CPU_LEToNative32(aCtx->ctx.msg.heartbeat.upTime.ns);
                aCtx->ctx.msg.heartbeat.count = CPU_LEToNative32(aCtx->ctx.msg.heartbeat.count);
                (void)MODULE_HostHelperLog("Async heartbeats Count:%u Time:%d.%09d\n",
                                                        aCtx->ctx.msg.heartbeat.count,
                                                        aCtx->ctx.msg.heartbeat.upTime.s,
                                                        aCtx->ctx.msg.heartbeat.upTime.ns);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief Process async comamnd request string or response byte array

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON

    @code{.unparsed}
    @endcode
*/
static int32_t DMON_AsyncHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == DMON_AsyncHelperCtx.modCtx.substate) {
        retVal = DMON_AsyncHelperPrepCtx(aStr, aStrLen,
                                          &DMON_AsyncHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            DMON_AsyncHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(DMON_AsyncHelperCtx.ctx.id) {
        case DMON_ID_HEART_BEAT:
            retVal = DMON_AsyncHeartBeatHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &DMON_AsyncHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief DMON Host Helper

    @trace #BRCM_SWARCH_DMON_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
const MODULE_MsgConverterType DMON_HostHelper = {
    .helpstr = DMON_HostHelperCmds,
    .context = &DMON_HostHelperCtx.modCtx,
    .process = DMON_HostHelperProcess,
};

/**
    @brief DMON Host Debug Helper

    @trace #BRCM_SWARCH_DMON_HOST_DBG_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
const MODULE_MsgConverterType DMON_HostDbgHelper = {
    .helpstr = DMON_HostDbgHelperCmds,
    .context = &DMON_HostDbgHelperCtx.modCtx,
    .process = DMON_HostDbgHelperProcess,
};

/**
    @brief DMON Host Async Helper

    @trace #BRCM_SWARCH_DMON_HOST_ASYNC_HELPER_GLOBAL
    @trace #BRCM_SWREQ_DMON
*/
const MODULE_MsgConverterType DMON_HostAsyncHelper = {
    .helpstr = DMON_AsyncHelperCmds,
    .context = &DMON_AsyncHelperCtx.modCtx,
    .process = DMON_AsyncHelperProcess,
};


/** @} */
