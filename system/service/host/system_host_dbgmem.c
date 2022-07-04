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
    @defgroup grp_sys_host_debug_impl SYSTEM Debug Helper Design
    @ingroup grp_sys_ipc

    @addtogroup grp_sys_host_debug_impl
    @{

    @file system_host_dbgmem.c
    @brief SYSTEM Debug Helper Design

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <unistd.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <sys_ipc_cmds.h>
#include <system_host_dbgmem.h>
#include <string.h>

/**
    @name SYSTEM Debug Helper Design IDs
    @{
    @brief SYSTEM Debug Helper Design IDs
*/
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_HELPER_CTX_GLOBAL          (0xBE0BU)   /**< @brief #SYSTEM_DebugMemHelperCtx      */
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_HELPERCMDS_GLOBAL          (0xBE04U)   /**< @brief #SYSTEM_DebugMemHelperCmds     */
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_HELPERPREP_CTX_PROC        (0xBE07U)   /**< @brief #SYSTEM_DebugMemHelperPrepCtx  */
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_READ_HELPER_HDLR_PROC      (0xBE04U)   /**< @brief #SYSTEM_DebugReadHelperHdlr     */
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_WRITE_HELPER_HDLR_PROC     (0xBE05U)   /**< @brief #SYSTEM_DebugMemWriteHelperHdlr */
#define BRCM_SWDSGN_SYSTEM_DEBUG_MEM_HELPER_GLOBAL              (0xBE0CU)   /**< @brief #SYSTEM_DebugMemHelper         */
/** @} */

/**
    @brief System Generic Helper context

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_GLOBAL
    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPERPREP_CTX_PROC
    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
SYSTEM_DebugMemHelperCtxType SYSTEM_DebugMemHelperCtx;

/**
    @brief Supported Memory commands

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
static const char SYSTEM_DebugMemHelperCmds[] =
"read <addr> <width 8|16|32> <0:master|1:slave>\n"
"write <addr> <width 8|16|32> <data> <0:master|1:slave>\n";

/**
    @brief Prepare Memory Commands context

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPERPREP_CTX_PROC
    @trace #BRCM_SWREQ_SYSTEM_TBD

    @code{.unparsed}
    @endcode
*/
int32_t SYSTEM_DebugMemHelperPrepCtx(char          *aStr,
                                uint32_t      *aStrLen,
                                SYSTEM_DebugMemHelperCtxType *aCtx)
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
    DBGMEM_HandleType dest;

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

                if (MCU_DEVICE_SLAVE_1 < destn) {
                    (void)MODULE_HostHelperLog("read <addr> <width 8|16|32> <device ID [0|1]>\n");
                    goto done;
                }

                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->mem.addr = addr;
                aCtx->mem.width = width;
                aCtx->mem.len = 1UL;
                aCtx->mem.deviceID = destn;
                aCtx->cmd = SYS_CMDID_MEM_READ;
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
                if (MCU_DEVICE_SLAVE_1 < destn) {
                    (void)MODULE_HostHelperLog("write <addr> <width 8|16|32> <device ID [0|1]>\n");
                    goto done;
                }

                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                memset(aCtx->mem.data, 0U, sizeof(aCtx->mem.data));
                dest.u8Ptr  = &aCtx->mem.data[0];
                //convert to an array of "width" size starting at &data
                if (width == 8) {
                    *dest.u8Ptr = (uint8_t)data;;
                } else if (width == 16) {
                    *dest.u16Ptr = (uint16_t)data;;
                } else if (width == 32) {
                    *dest.u32Ptr = (uint32_t)data;;
                }
                aCtx->mem.addr = addr;
                aCtx->mem.width = width;
                aCtx->mem.len = 1UL;
                aCtx->mem.deviceID = destn;
                aCtx->cmd = SYS_CMDID_MEM_WRITE;
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

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_WRITE_HELPER_HDLR_PROC
    @trace #BRCM_SWREQ_SYSTEM_TBD

    @code{.unparsed}
    @endcode
*/
int32_t SYSTEM_DebugMemWriteHelperHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   SYSTEM_DebugMemHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    SYS_HandleType cmdMsg;
    DBGMEM_HandleType src;
    DBGMEM_HandleType dest;

    cmdMsg.u8Ptr = aBuff;
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.memAccess->addr = CPU_NativeToLE32(aCtx->mem.addr);
            cmdMsg.memAccess->width = CPU_NativeToLE32(aCtx->mem.width);
            cmdMsg.memAccess->len = CPU_NativeToLE32(aCtx->mem.len);
            cmdMsg.memAccess->deviceID = CPU_NativeToLE32(aCtx->mem.deviceID);
            dest.u8Ptr = &cmdMsg.memAccess->data[0];
            src.u8Ptr  = &aCtx->mem.data[0];
            if (8U == aCtx->mem.width) {
                *dest.u8Ptr = *src.u8Ptr;
            } else if (16U == aCtx->mem.width) {
                *dest.u16Ptr = CPU_NativeToLE16(*src.u16Ptr);
            } else if (32U == aCtx->mem.width) {
                *dest.u32Ptr = CPU_NativeToLE32(*src.u32Ptr);
            }

            *aMsg = BCM_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, SYS_CMDID_MEM_WRITE);
            *aOutLen = sizeof(SYS_MemAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in memory write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(SYS_MemAccessType))) {
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

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_READ_HELPER_HDLR_PROC
    @trace #BRCM_SWREQ_SYSTEM_TBD

    @code{.unparsed}
    @endcode
*/
int32_t SYSTEM_DebugMemReadHelperHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   SYSTEM_DebugMemHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    SYS_HandleType cmdMsg;
    SYS_HandleType respMsg;
    DBGMEM_HandleType src;
    DBGMEM_HandleType dest;

    cmdMsg.u8Ptr = aBuff;
    respMsg.u8Ptr = aBuff;
    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.memAccess->addr = CPU_NativeToLE32(aCtx->mem.addr);
            cmdMsg.memAccess->width = CPU_NativeToLE32(aCtx->mem.width);
            cmdMsg.memAccess->len = CPU_NativeToLE32(aCtx->mem.len);
            cmdMsg.memAccess->deviceID = CPU_NativeToLE32(aCtx->mem.deviceID);
            *aMsg = BCM_CMDID(BCM_GROUPID_SYS, BCM_RSV_ID, SYS_CMDID_MEM_READ);
            *aOutLen = sizeof(SYS_MemAccessType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Error in memory write 0x%x\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(SYS_MemAccessType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                src.u8Ptr = &respMsg.memAccess->data[0];
                dest.u8Ptr = aCtx->mem.data;
                if (8U == aCtx->mem.width) {
                    *dest.u8Ptr = *src.u8Ptr;
                    (void)MODULE_HostHelperLog("0x%02X\n", *dest.u8Ptr);
                } else if (16U == aCtx->mem.width) {
                   *dest.u16Ptr = CPU_LEToNative16(*src.u16Ptr);
                    (void)MODULE_HostHelperLog("0x%04X\n", *dest.u16Ptr);
                } else if (32U == aCtx->mem.width) {
                   *dest.u32Ptr = CPU_LEToNative32(*src.u32Ptr);
                    (void)MODULE_HostHelperLog("0x%08X\n", *dest.u32Ptr);
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

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_TBD

    @code{.unparsed}
    @endcode
*/
static int32_t SYSTEM_DebugMemHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == SYSTEM_DebugMemHelperCtx.modCtx.substate) {
        retVal = SYSTEM_DebugMemHelperPrepCtx(aStr, aStrLen,
                                          &SYSTEM_DebugMemHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            SYSTEM_DebugMemHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(SYSTEM_DebugMemHelperCtx.cmd) {
        case SYS_CMDID_MEM_WRITE:
            retVal = SYSTEM_DebugMemWriteHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &SYSTEM_DebugMemHelperCtx);
            break;
        case SYS_CMDID_MEM_READ:
            retVal = SYSTEM_DebugMemReadHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &SYSTEM_DebugMemHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Memory Command Helper

    @trace #BRCM_SWARCH_SYSTEM_DEBUG_MEM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_SYSTEM_TBD
*/
const MODULE_MsgConverterType SYSTEM_DebugMemHelper = {
    .helpstr = SYSTEM_DebugMemHelperCmds,
    .context = &SYSTEM_DebugMemHelperCtx.modCtx,
    .process = SYSTEM_DebugMemHelperProcess,
};
/** @} */
