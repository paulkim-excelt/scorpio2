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
    @defgroup grp_nvm_host_impl Host Command Helper Design
    @ingroup grp_nvm_service

    @addtogroup grp_nvm_host_impl
    @{

    @file nvm_host.c
    @brief NVM Host comamnds Helper Design

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <nvm_flash.h>

/**
    @name NVM Host Helper Design ID's
    @{
    @brief Ethernet switch NVM Helper Design ID's
*/
#define BRCM_SWDSGN_NVM_CMD_INT_PARSE_STATUS_MACRO  (0xB301U)    /**< @brief #NVM_CMD_INT_PARSE_STATUS */
#define BRCM_SWDSGN_NVM_HELPER_CTX_GLOBAL           (0xB302U)    /**< @brief #NVM_HelperCtx            */
#define BRCM_SWDSGN_NVM_HELPCMDS_GLOBAL             (0xB303U)    /**< @brief #NVM_HelpCmds             */
#define BRCM_SWDSGN_NVM_HOSTERASE_PROC              (0xB304U)    /**< @brief #NVM_HostErase            */
#define BRCM_SWDSGN_NVM_HOSTWRITE_PROC              (0xB305U)    /**< @brief #NVM_HostWrite            */
#define BRCM_SWDSGN_NVM_HOSTREAD_PROC               (0xB306U)    /**< @brief #NVM_HostRead             */
#define BRCM_SWDSGN_NVM_HELPER_PREPCTX_PROC         (0xB307U)    /**< @brief #NVM_HelperPrepCtx        */
#define BRCM_SWDSGN_NVM_HELPER_ERASEHANDLER_PROC    (0xB308U)    /**< @brief #NVM_HelperEraseHandler   */
#define BRCM_SWDSGN_NVM_HELPER_WRITEHANDLER_PROC    (0xB309U)    /**< @brief #NVM_HelperWriteHandler   */
#define BRCM_SWDSGN_NVM_HELPER_READHANDLER_PROC     (0xB30AU)    /**< @brief #NVM_HelperReadHandler    */
#define BRCM_SWDSGN_NVM_HELPER_PROCESS_PROC         (0xB30BU)    /**< @brief #NVM_HelperProcess        */
#define BRCM_SWDSGN_NVM_HELPER_GLOBAL               (0xB30CU)    /**< @brief #NVM_Helper               */
/** @} */

/**
    @brief NVM Integer parse status

    @trace #BRCM_SWARCH_NVM_HELPER_PREPCTX_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
#define  NVM_CMD_INT_PARSE_STATUS(status)  if(status != BCM_ERR_OK) {  \
    goto done;                                                         \
}

/**
    @brief NVM Helper Module Context

    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWARCH_NVM_HELPER_PREPCTX_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_ERASEHANDLER_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_WRITEHANDLER_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_READHANDLER_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
FLASH_HelperCtxType NVM_HelperCtx;

/**
    @brief NVM Supported commands

    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL
*/
static const char NVM_HelpCmds[] =
"write <FlashID> <Offset> <Filename>\n"
"read  <FlashID> <Offset> <size> <Filename>\n"
"erase <FlashID> <Offset> <Sector size> <No Of Sectors>\n"
;

/**
    @brief NVM Erase Helper

    This API prepare the erase request

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_HELPER_ERASEHANDLER_PROC
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
static void NVM_HostErase(BCM_CmdType    *aMsg,
                            uint8_t       *aOutBuf,
                            uint32_t      *aOutLen,
                            FLASH_HelperCtxType *aCtx)
{
    FLASH_HandleType cmdMsg;

    cmdMsg.rpcEraseInfo.hwID = CPU_NativeToLE32(aCtx->eraseInfo.hwID);
    cmdMsg.rpcEraseInfo.len = CPU_NativeToLE32(aCtx->eraseInfo.len);
    cmdMsg.rpcEraseInfo.addr = CPU_NativeToLE32(aCtx->eraseInfo.addr);
    memcpy(aOutBuf, cmdMsg.data, FLASH_RPC_MAX_PAYLOAD_SIZE);

    *aMsg = FLASH_CMD_RPC_ERASE;
    *aOutLen = sizeof(FLASH_RpcEraseInfoType);
}

/**
    @brief NVM Write Helper

    This API prepare the write request

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_HELPER_WRITEHANDLER_PROC
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
static void NVM_HostWrite(BCM_CmdType    *aMsg,
                            uint8_t       *aOutBuf,
                            uint32_t      *aOutLen,
                            FLASH_HelperCtxType *aCtx)
{
    FLASH_HandleType cmdMsg;

    cmdMsg.rpcWriteInfo.hwID = CPU_NativeToLE32(aCtx->writeInfo.hwID);
    cmdMsg.rpcWriteInfo.len = CPU_NativeToLE32(aCtx->writeInfo.len);
    cmdMsg.rpcWriteInfo.addr = CPU_NativeToLE32(aCtx->writeInfo.addr + aCtx->offset);
    memcpy((&cmdMsg.rpcWriteInfo.bufIn[0]),&aCtx->buff[aCtx->offset],aCtx->writeInfo.len);
    memcpy(aOutBuf, cmdMsg.data, FLASH_RPC_MAX_PAYLOAD_SIZE);
    *aMsg = FLASH_CMD_RPC_WRITE;
    *aOutLen = sizeof(FLASH_RpcWriteInfoType);
}

/**
    @brief NVM Read Helper

    This API prepare the read request

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_HELPER_READHANDLER_PROC
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
static void NVM_HostRead(BCM_CmdType    *aMsg,
                            uint8_t       *aOutBuf,
                            uint32_t      *aOutLen,
                            FLASH_HelperCtxType *aCtx)
{
    FLASH_HandleType cmdMsg;

    cmdMsg.rpcReadInfo.hwID = CPU_NativeToLE32(aCtx->readInfo.hwID);
    cmdMsg.rpcReadInfo.len = CPU_NativeToLE32(aCtx->readInfo.len);
    cmdMsg.rpcReadInfo.addr = CPU_NativeToLE32(aCtx->readInfo.addr + aCtx->offset);
    memcpy(aOutBuf, cmdMsg.data, FLASH_RPC_MAX_PAYLOAD_SIZE);
    *aMsg = FLASH_CMD_RPC_READ;
    *aOutLen = sizeof(FLASH_RpcReadInfoType);
}

/** @brief Prepare NVM request

    @trace #BRCM_SWARCH_NVM_HELPER_PREPCTX_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_HelperPrepCtx(char           *aStr,
                           uint32_t      *aStrLen,
                           uint8_t       *aOutBuf,
                           uint32_t      *aOutLen,
                           uint32_t       aMaxLength,
                           FLASH_HelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    char fileName[100];
    FILE *fp;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        currStr = remStr;
        currStrLen = remStrLen;
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen > 1UL)) {
                if (0 == strncmp(currStr, "erase", 5)) {
                        currStr = remStr;
                        currStrLen = remStrLen;
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            retVal = BCM_ERR_INVAL_PARAMS;
                            goto done;
                        }
                        aCtx->eraseInfo.hwID = MODULE_MsgParseInt(currStr, &retVal);
                        NVM_CMD_INT_PARSE_STATUS(retVal);

                        currStr = remStr;
                        currStrLen = remStrLen;
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            retVal = BCM_ERR_INVAL_PARAMS;
                            goto done;
                        }
                        aCtx->eraseInfo.addr = MODULE_MsgParseInt(currStr, &retVal);
                        NVM_CMD_INT_PARSE_STATUS(retVal);

                        currStr = remStr;
                        currStrLen = remStrLen;
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr == NULL) || (remStrLen == 0)) {
                            retVal = BCM_ERR_INVAL_PARAMS;
                            goto done;
                        }
                        aCtx->eraseInfo.len = MODULE_MsgParseInt(currStr, &retVal);
                        NVM_CMD_INT_PARSE_STATUS(retVal);

                        currStr = remStr;
                        currStrLen = remStrLen;
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr != NULL) || (remStrLen != 0)) {
                            retVal = BCM_ERR_INVAL_PARAMS;
                            goto done;
                        }
                        aCtx->numSectors = MODULE_MsgParseInt(currStr, &retVal);
                        NVM_CMD_INT_PARSE_STATUS(retVal);
                        NVM_HelperCtx.cmd = FLASH_CMD_RPC_ERASE;
                } else if (0 == strncmp(currStr, "write", 5)) {
                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr == NULL) || (remStrLen == 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }

                    aCtx->writeInfo.hwID = MODULE_MsgParseInt(currStr, &retVal);
                    NVM_CMD_INT_PARSE_STATUS(retVal);

                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr == NULL) || (remStrLen == 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    aCtx->writeInfo.addr = MODULE_MsgParseInt(currStr, &retVal);
                    NVM_CMD_INT_PARSE_STATUS(retVal);

                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr != NULL) || (remStrLen != 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    memcpy(fileName, currStr, currStrLen);
                    fileName[currStrLen] = '\0';

                    retVal = MODULE_BufferFromFile(fileName, FLASH_MAX_FILESIZE, aCtx->buff, &aCtx->fileSz);
                    if (BCM_ERR_OK == retVal) {
                        aCtx->writeInfo.len = FLASH_MAX_PAGE_SIZE;
                        aCtx->offset = 0UL;
                    }
                    NVM_HelperCtx.cmd = FLASH_CMD_RPC_WRITE;
                } else if (0 == strncmp(currStr, "read", 4)) {
                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr == NULL) || (remStrLen == 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }

                    aCtx->readInfo.hwID = MODULE_MsgParseInt(currStr, &retVal);
                    NVM_CMD_INT_PARSE_STATUS(retVal);

                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr == NULL) || (remStrLen == 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    aCtx->readInfo.addr = MODULE_MsgParseInt(currStr, &retVal);
                    NVM_CMD_INT_PARSE_STATUS(retVal);

                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr == NULL) || (remStrLen == 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    aCtx->fileSz = MODULE_MsgParseInt(currStr, &retVal);
                    NVM_CMD_INT_PARSE_STATUS(retVal);

                    if(FLASH_MAX_FILESIZE < aCtx->fileSz) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    currStr = remStr;
                    currStrLen = remStrLen;
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if ((remStr != NULL) || (remStrLen != 0)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                        goto done;
                    }
                    memcpy(fileName, currStr, currStrLen);
                    fileName[currStrLen] = '\0';

                    aCtx->readInfo.len = FLASH_MAX_PAGE_SIZE;
                    fp = fopen(fileName,"wb");
                    aCtx->fp = fp;
                    NVM_HelperCtx.cmd = FLASH_CMD_RPC_READ;
                } else {
                    retVal = BCM_ERR_UNKNOWN;
                }
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        } else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

done:
    return retVal;
}

/** @brief Process NVM Erase request

    @trace #BRCM_SWARCH_NVM_HELPER_ERASEHANDLER_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_HelperEraseHandler(BCM_CmdType    *aMsg,
                              uint8_t       *aBuff,
                              uint32_t       aInputLen,
                              uint32_t      *aOutLen,
                              uint32_t       aMaxLength,
                              int32_t        aResponse,
                              FLASH_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            NVM_HostErase(aMsg, aBuff, aOutLen, aCtx);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                (void)MODULE_HostHelperLog("Failed to erase flash. Response = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(FLASH_RpcEraseInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                (void)MODULE_HostHelperLog("Erasing Sector %d \n",aCtx->sector);
                aCtx->eraseInfo.addr += aCtx->eraseInfo.len;
                aCtx->sector++;
                if(aCtx->sector == aCtx->numSectors) {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                } else {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
                    NVM_HostErase(aMsg, aBuff, aOutLen, aCtx);
                }
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/** @brief Process NVM Write request

    @trace #BRCM_SWARCH_NVM_HELPER_WRITEHANDLER_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_HelperWriteHandler(BCM_CmdType    *aMsg,
                              uint8_t       *aBuff,
                              uint32_t       aInputLen,
                              uint32_t      *aOutLen,
                              uint32_t       aMaxLength,
                              int32_t        aResponse,
                              FLASH_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            NVM_HostWrite(aMsg, aBuff, aOutLen, aCtx);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                (void)MODULE_HostHelperLog("Failed to flash images. Response = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(FLASH_RpcWriteInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->offset += FLASH_MAX_PAGE_SIZE;
                (void)MODULE_HostHelperLog("\r%03u%%", ((aCtx->offset*100)/aCtx->fileSz));
                /* check if this is the last request */
                if(aCtx->offset >= aCtx->fileSz) {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                } else {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
                    NVM_HostWrite(aMsg, aBuff, aOutLen, aCtx);
                }
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }
    return retVal;
}

/** @brief Process NVM Read request

    @trace #BRCM_SWARCH_NVM_HELPER_READHANDLER_PROC
    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_HelperReadHandler(BCM_CmdType    *aMsg,
                              uint8_t       *aBuff,
                              uint32_t       aInputLen,
                              uint32_t      *aOutLen,
                              uint32_t       aMaxLength,
                              int32_t        aResponse,
                              FLASH_HelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t readLen = 0UL;
    FLASH_HandleType respMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            NVM_HostRead(aMsg, aBuff, aOutLen, aCtx);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            memcpy(respMsg.data, aBuff, FLASH_RPC_MAX_PAYLOAD_SIZE);
            if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                (void)MODULE_HostHelperLog("Failed to Read the Data. Response = %d\n",
                                                          aResponse);
                fclose(aCtx->fp);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(FLASH_RpcReadInfoType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
                fclose(aCtx->fp);
            } else {
                if(FLASH_MAX_PAGE_SIZE <= (aCtx->fileSz - aCtx->offset)) {
                    /* Write the data len of #FLASH_MAX_PAGE_SIZE if it is equal or more than #FLASH_MAX_PAGE_SIZE */
                    readLen = aCtx->readInfo.len;
                } else {
                    /* Write the remaining data if remaining is less than #FLASH_MAX_PAGE_SIZE */
                    readLen = (aCtx->fileSz %FLASH_MAX_PAGE_SIZE);
                }
                fwrite(&respMsg.rpcReadInfo.bufOut[0], readLen, 1 , aCtx->fp);
                aCtx->offset += readLen;
                (void)MODULE_HostHelperLog("\r%03u%%", ((aCtx->offset*100)/aCtx->fileSz));
                /* check if this is the last request */
                if((aCtx->offset) >= aCtx->fileSz) {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                } else {
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
                    NVM_HostRead(aMsg, aBuff, aOutLen, aCtx);
                }
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }

    return retVal;
}

/** @brief Process NVM request string or response byte array

    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
static int32_t NVM_HelperProcess(BCM_CmdType    *aMsg,
                                          char          *aStr,
                                          uint32_t      *aStrLen,
                                          uint8_t       *aInOut,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == NVM_HelperCtx.modCtx.substate) {
        retVal = NVM_HelperPrepCtx(aStr, aStrLen,
                                   aInOut, aOutLen, aMaxLength,
                                   &NVM_HelperCtx);
        if(BCM_ERR_OK ==retVal) {
            NVM_HelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(NVM_HelperCtx.cmd) {
        case FLASH_CMD_RPC_ERASE:
            retVal = NVM_HelperEraseHandler(aMsg, aInOut, aInputLen,
                                           aOutLen, aMaxLength, aResponse,
                                           &NVM_HelperCtx);
            break;
        case FLASH_CMD_RPC_WRITE:
            retVal = NVM_HelperWriteHandler(aMsg, aInOut, aInputLen,
                                           aOutLen, aMaxLength, aResponse,
                                           &NVM_HelperCtx);
            break;
        case FLASH_CMD_RPC_READ:
            retVal = NVM_HelperReadHandler(aMsg, aInOut, aInputLen,
                                           aOutLen, aMaxLength, aResponse,
                                           &NVM_HelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief NVM Helper

    @trace #BRCM_SWARCH_NVM_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL
*/
const MODULE_MsgConverterType FLASH_Helper = {
    .helpstr = NVM_HelpCmds,
    .context = &NVM_HelperCtx.modCtx,
    .process = NVM_HelperProcess,
};
/** @} */
