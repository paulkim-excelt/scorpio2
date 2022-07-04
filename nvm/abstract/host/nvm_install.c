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
    @defgroup grp_nvm_host_install_impl Host Install Helper Design
    @ingroup grp_nvm_service

    @addtogroup grp_nvm_host_install_impl
    @{

    @file nvm_install.c
    @brief NVM Host Helper Design

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <nvm_flash.h>
#include <rpc_hosthelper.h>
#include <crc.h>
#include <system_dmon.h>
#include <bcm_time.h>

/**
    @name NVM Host Helper Design ID's
    @{
    @brief Ethernet switch NVM Helper Design ID's
*/
#define BRCM_SWDSGN_NVM_INSTALL_HELPERCTX_GLOBAL         (0xB401U)    /**< @brief #NVM_InstallHelperCtx         */
#define BRCM_SWDSGN_NVM_INSTALL_HELPCMDS_GLOBAL          (0xB402U)    /**< @brief #NVM_InstallHelpCmds          */
#define BRCM_SWDSGN_NVM_INSTALL_ERASE_PROC               (0xB403U)    /**< @brief #NVM_InstallErase             */
#define BRCM_SWDSGN_NVM_INSTALL_WRITE_PROC               (0xB404U)    /**< @brief #NVM_InstallWrite             */
#define BRCM_SWDSGN_NVM_INSTALL_HELPER_PREPCTX_PROC      (0xB405U)    /**< @brief #NVM_InstallHelperPrepCtx     */
#define BRCM_SWDSGN_NVM_INSTALL_HELPER_PROCESSCTX_PROC   (0xB406U)    /**< @brief #NVM_InstallHelperProcessCtx  */
#define BRCM_SWDSGN_NVM_INSTALL_HELPER_PROCESS_PROC      (0xB407U)    /**< @brief #NVM_InstallHelperProcess     */
#define BRCM_SWDSGN_NVM_INSTALL_HELPER_GLOBAL            (0xB408U)    /**< @brief #NVM_InstallHelper            */
#define BRCM_SWDSGN_NVM_INSTALLIMAGEFETCHANDWRITE_PROC   (0xB409U)    /**< @brief #NVM_InstallImageFetchandWrite*/
#define BRCM_SWDSGN_NVM_INSTALLITBLFETCH_PROC            (0xB40AU)    /**< @brief #NVM_InstallITBLFetch         */
/** @} */

/**
    @brief NVM install Helper Module Context

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL
*/
FLASH_InstallHelperCtxType NVM_InstallHelperCtx;

/**
    @brief NVM Install Supported commands

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL
*/
static const char NVM_InstallHelpCmds[] =
"<img>\n"
;

/**
    @brief Install Erase Helper

    This API prepare the erase request before install

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

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPROCESSCTX_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
static void NVM_InstallErase (BCM_CmdType    *aMsg,
                              uint8_t       *aOutBuf,
                              uint32_t      *aOutLen,
                              FLASH_InstallHelperCtxType *aCtx)
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
    @brief Install Write Helper

    This API process the install request

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aInBuf              Input buffer with data to be written
    @param[in]      aAddrOffset         Address offset where data needs to be written
    @param[inout]   aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPROCESSCTX_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
static void NVM_InstallWrite (BCM_CmdType   *aMsg,
                              uint8_t       *aOutBuf,
                              uint32_t      *aOutLen,
                              uint8_t       *aInBuf,
                              uint32_t       aAddrOffset,
                              FLASH_InstallHelperCtxType *aCtx)
{
    FLASH_HandleType cmdMsg;

    cmdMsg.rpcWriteInfo.hwID = CPU_NativeToLE32(aCtx->writeInfo.hwID);
    cmdMsg.rpcWriteInfo.len = CPU_NativeToLE32(aCtx->writeInfo.len);
    cmdMsg.rpcWriteInfo.addr = CPU_NativeToLE32(aCtx->writeInfo.addr + aCtx->offset + aAddrOffset);
    memcpy((&cmdMsg.rpcWriteInfo.bufIn[0]),&aInBuf[aCtx->offset],aCtx->writeInfo.len);
    memcpy(aOutBuf, cmdMsg.data, FLASH_RPC_MAX_PAYLOAD_SIZE);
    aCtx->offset += aCtx->writeInfo.len;
    *aMsg = FLASH_CMD_RPC_WRITE;
    *aOutLen = sizeof(FLASH_RpcWriteInfoType);
}

/** @brief Process NVM Install request

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPREPCTX_PROC
    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_InstallHelperPrepCtx(char        *aStr,
                                 uint32_t    *aStrLen,
                                 uint8_t     *aOutBuf,
                                 uint32_t    *aOutLen,
                                 uint32_t     aMaxLength,
                                 FLASH_InstallHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    char fileName[100];

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                memcpy(fileName, currStr, currStrLen);
                fileName[currStrLen] = '\0';
                retVal = RPC_HostImglSet(fileName);
                if (BCM_ERR_OK == retVal) {
                    BCM_MemSet(aCtx, 0U, sizeof(FLASH_InstallHelperCtxType));
                    aCtx->eraseInfo.len = FLASH_MAX_SECTOR_SIZE;
                    aCtx->writeInfo.len = FLASH_MAX_PAGE_SIZE;
                }
            }
        }
    }

    return retVal;
}

/**
    @brief Fetch image and initiate write

    This API fetches the actual image and starts the image write

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aTarImage           Input buffer with tar image
    @param[inout]   aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPROCESSCTX_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
static int32_t NVM_InstallImageFetchandWrite(BCM_CmdType *aMsg,
                                             uint8_t *aOutBuf,
                                             uint32_t *aOutLen,
                                             uint8_t *aTarImage,
                                             FLASH_InstallHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_NOT_FOUND;
    uint32_t offset = 0UL;
    PTBL_IdType pid;
    uint32_t size = 0UL;

    while ((aCtx->imgCount < CPU_LEToNative32(aCtx->itbl.hdr.numImgs)) &&
           (0xFFFFU == CPU_LEToNative16(aCtx->itbl.entry[aCtx->imgCount].imgType))){
        aCtx->imgCount++;
    }

    if (aCtx->imgCount < CPU_LEToNative32(aCtx->itbl.hdr.numImgs)) {
        pid = (CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid) &
                       PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT;

        retVal = RPC_HOSTImglGetImg(&offset, &size, pid,
                                    CPU_LEToNative16(aCtx->itbl.entry[aCtx->imgCount].imgType));
        if (BCM_ERR_OK != retVal) {
            (void)MODULE_HostHelperLog("Failed to Get image (%x:%x)\n",
                      CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid),
                      CPU_LEToNative16(aCtx->itbl.entry[aCtx->imgCount].imgType));
            goto done;
        }

        if ((PTBL_ID_BL == pid) && (1UL == aCtx->isSkipBLSign)) {
            (void)MODULE_HostHelperLog("Stripping off signature from bootloader image\n");
            offset += 256UL;
            size -= 256UL;
            aCtx->itbl.entry[aCtx->imgCount].crc = CPU_NativeToLE32(BCM_CRC32(&aTarImage[offset], size, ITBL_CRC32_POLY));
            aCtx->itbl.entry[aCtx->imgCount].actualSize = CPU_NativeToLE32(size);
            aCtx->isCRCRecompute = 1UL;
        }

        aCtx->image = &aTarImage[offset];
        aCtx->imgSize = size;
        aCtx->offset = 0UL;
        /* Start the image write */
        NVM_InstallWrite(aMsg, aOutBuf, aOutLen, aCtx->image,
                        CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr) +
                        CPU_NativeToLE32(aCtx->itbl.entry[aCtx->imgCount].flashOffset), aCtx);
    }

done:
    return retVal;
}

/**
    @brief Fetch Image table

    This API fetches the Image table

    @behavior Sync, Non-reentrant

    @pre None

    @param[out]     aMsg                Message ID (group, comp, cmd)
    @param[out]     aOutBuf             output buffer for the the command
    @param[out]     aOutLen             Ouput length of command
    @param[in]      aTarImage           Input buffer with tar image
    @param[inout]   aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPROCESSCTX_PROC
    @trace #BRCM_SWREQ_NVM_IMGL
*/
int32_t NVM_InstallITBLFetch(BCM_CmdType *aMsg,
                             uint8_t *aOutBuf,
                             uint32_t *aOutLen,
                             uint8_t *aTarImage,
                             FLASH_InstallHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_NOT_FOUND;
    uint32_t offset = 0UL;
    PTBL_IdType pid;
    uint32_t size = 0UL;

    while ((aCtx->itblCount < CPU_LEToNative32(aCtx->ptbl.hdr.numEntries)) &&
           (0UL == CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid))) {
        aCtx->itblCount++;
    }

    if (aCtx->itblCount < CPU_LEToNative32(aCtx->ptbl.hdr.numEntries)) {
        pid = (CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid) &
                       PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT;
        retVal = RPC_HOSTImglGetItbl(&offset, &size, pid);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
            (void)MODULE_HostHelperLog("Failed to get ITBL offset %x\n", CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid));
        } else {
            memcpy(&aCtx->itbl, &aTarImage[offset], size);
            aCtx->itblSize = ITBL_HDR_SIZE + ((CPU_LEToNative32(aCtx->itbl.hdr.numImgs) * ITBL_ENTRY_SIZE));
            aCtx->isCRCRecompute = 0UL;
            aCtx->imgCount = 0UL;
            aCtx->offset = 0UL;
        }
    }
    return retVal;
}

/** @brief Process NVM request string or response byte array

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPERPROCESSCTX_PROC
    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
int32_t NVM_InstallHelperProcessCtx(BCM_CmdType   *aMsg,
                                    uint8_t       *aBuff,
                                    uint32_t       aInputLen,
                                    uint32_t      *aOutLen,
                                    uint32_t       aMaxLength,
                                    int32_t        aResponse,
                                    FLASH_InstallHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    BCM_CmdType respcmd;
    uint8_t *tarImage = &HOST_TarBase[20UL];
    uint32_t offset = 0UL;
    PTBL_IdType pid;
    DMON_MsgUnionType respHdl;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            aCtx->startTime = BCM_GetTimeNs();
            /* Detect the taret security mode */
            *aMsg = DMON_ID_HW_VERSION;
            *aOutLen = sizeof(MCU_VersionType);
            BCM_MemSet(aBuff, 0U, aInputLen);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            respcmd = *aMsg;
            if(DMON_ID_HW_VERSION == respcmd) {
                if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                    (void)MODULE_HostHelperLog("Failed to read target state. Response = %d\n",
                                                              aResponse);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else if (aInputLen != (sizeof(MCU_VersionType))) {
                    (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    BCM_MemCpy(respHdl.data, aBuff, sizeof(DMON_HwVersionMsgType));
                    /* Parse the target details and determine if BL signature needs to be skipped */
                    if (MCU_SECURITY_MODE_UNKNOWN != CPU_LEToNative32(respHdl.hwVersion.secMode)) {
                        switch (CPU_LEToNative32(respHdl.hwVersion.model)) {
                            case 0x89560UL:
                            case 0x89561UL:
                            case 0x89261UL:
                            case 0x89564UL:
                                if ((0UL == (CPU_LEToNative32(respHdl.hwVersion.rev) & 0x1UL)) &&
                                    (MCU_SECURITY_MODE_NONE == CPU_LEToNative32(respHdl.hwVersion.secMode))) {
                                    aCtx->isSkipBLSign = 1UL;
                                }
                                break;
                            default:
                                /* No special handling */
                                break;
                            }
                    }
                    (void)MODULE_HostHelperLog("Target security state read (skipping BL signature = %d) \n",aCtx->isSkipBLSign);
                    /* Initiate flash erase */
                    NVM_InstallErase(aMsg, aBuff, aOutLen, aCtx);
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            respcmd = *aMsg;
            if((FLASH_CMD_RPC_ERASE) == respcmd) {
                if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                    (void)MODULE_HostHelperLog("Failed to erase flash. Response = %d\n",
                                                              aResponse);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else if (aInputLen != (sizeof(FLASH_RpcEraseInfoType))) {
                    (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    (void)MODULE_HostHelperLog("Erasing Sector %d \n",aCtx->sector);
                    /* Update the next address to Erase */
                    aCtx->eraseInfo.addr += aCtx->eraseInfo.len;
                    aCtx->sector++;
                    if(FLASH_MAX_SECTOR == aCtx->sector) {
                        /* Erase is completed. Start writing the PT table */
                        retVal = RPC_HOSTImglGetPtbl(&offset, &aCtx->ptSize);
                        if (BCM_ERR_OK != retVal) {
                            retVal = BCM_ERR_UNKNOWN;
                            (void)MODULE_HostHelperLog("Failed to get PTBL offset\n");
                            goto done;
                        }
                        memset(&aCtx->ptbl, 0xFF, sizeof(PTBL_Type));
                        memcpy(&aCtx->ptbl, &tarImage[offset], aCtx->ptSize);
                        aCtx->ptSize = sizeof(PTBL_Type);
                        aCtx->offset = 0UL;
                        aCtx->writeInfo.addr = 0UL;
                        /* Write the first copy of PT table */
                        NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->ptbl, 0UL, aCtx);
                        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE3;
                    } else {
                        /* flash erase all sectors */
                        NVM_InstallErase(aMsg, aBuff, aOutLen, aCtx);
                        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                    }
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE3:
            respcmd = *aMsg;
            if((FLASH_CMD_RPC_WRITE) == respcmd) {
                if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                    (void)MODULE_HostHelperLog("Failed to write PTBL to flash. Response = %d\n",
                                                              aResponse);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else if (aInputLen != (sizeof(FLASH_RpcWriteInfoType))) {
                    (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    if (aCtx->offset >= aCtx->ptSize) {
                        aCtx->offset = 0UL;
                        aCtx->ptCount++;
                    }
                    if(FLASH_MAX_PT_COUNT == aCtx->ptCount) {
                        (void)MODULE_HostHelperLog("Programmed Partition table successfully\n");
                        /* ITBL write */
                        aCtx->itblCount = 0UL;
                        aCtx->imgCount = 0UL;
                        aCtx->isCRCRecompute = 0UL;
                        NVM_InstallITBLFetch(aMsg, aBuff, aOutLen, tarImage, aCtx);
                        pid = (CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid) &
                                       PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT;
                        (void)MODULE_HostHelperLog("Flashing PID:%x\n",CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid));

                        if ((PTBL_ID_BL == pid) || (PTBL_ID_FW == pid) || (PTBL_ID_SYSCFG == pid)) {
                            /* Fetch first image */
                            NVM_InstallImageFetchandWrite(aMsg, aBuff, aOutLen, tarImage, aCtx);
                            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE4;
                        } else {
                            /* Write ITBL as there is no image */
                            NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->itbl,
                                             CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr), aCtx);
                            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE5;
                        }
                    } else {
                        /* Write PTBL */
                        NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->ptbl,
                                        (sizeof(PTBL_Type) * aCtx->ptCount), aCtx);
                        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE3;
                    }
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE4:
            respcmd = *aMsg;
            /* Process image write */
            if((FLASH_CMD_RPC_WRITE) == respcmd) {
                if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                    (void)MODULE_HostHelperLog("Failed to write to flash. Response = %d\n",
                                                              aResponse);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else if (aInputLen != (sizeof(FLASH_RpcWriteInfoType))) {
                    (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    if (aCtx->offset < aCtx->imgSize) {
                        (void)MODULE_HostHelperLog("\r%03u%%", ((aCtx->offset*100)/aCtx->imgSize));
                        NVM_InstallWrite(aMsg, aBuff, aOutLen, aCtx->image,
                                         CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr) +
                                         CPU_NativeToLE32(aCtx->itbl.entry[aCtx->imgCount].flashOffset), aCtx);
                        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE4;
                    } else {
                        /* Pick next image and write */
                        aCtx->imgCount++;
                        retVal = NVM_InstallImageFetchandWrite(aMsg, aBuff,aOutLen, tarImage, aCtx);
                        if (BCM_ERR_NOT_FOUND == retVal) {
                            /* Update ITBL CRC if image was modified */
                            if (1UL == aCtx->isCRCRecompute) {
                                aCtx->itbl.hdr.crc = CPU_NativeToLE32(BCM_CRC32((uint8_t *)&aCtx->itbl.entry[0],
                                                        (CPU_NativeToLE32(aCtx->itbl.hdr.numImgs) * ITBL_ENTRY_SIZE),
                                                        ITBL_CRC32_POLY));
                                aCtx->itbl.hdr.hdrErrDetCode = CPU_NativeToLE32(BCM_CRC32((uint8_t *)&aCtx->itbl.hdr,
                                                        (ITBL_HDR_SIZE - 4),
                                                        ITBL_CRC32_POLY));
                            }
                            aCtx->offset = 0UL;
                            /* Write ITBL header with updated CRC */
                            NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->itbl,
                                             CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr), aCtx);
                            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE5;
                        } else {
                            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE4;
                        }
                    }
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE5:
            respcmd = *aMsg;
            /* Process ITBL header write */
            if((FLASH_CMD_RPC_WRITE) == respcmd) {
                if (CPU_LEToNative32(aResponse) != BCM_ERR_OK) {
                    (void)MODULE_HostHelperLog("Failed to write to flash. Response = %d\n",
                                                              aResponse);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else if (aInputLen != (sizeof(FLASH_RpcWriteInfoType))) {
                    (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                } else {
                    if (aCtx->offset < aCtx->itblSize) {
                        NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->itbl,
                                        CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr), aCtx);
                        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE5;
                    } else {
                        /* Pick next ITBL */
                        aCtx->itblCount++;
                        retVal = NVM_InstallITBLFetch(aMsg, aBuff, aOutLen, tarImage, aCtx);
                        if (BCM_ERR_NOT_FOUND == retVal) {
                            (void)MODULE_HostHelperLog("Install all successfully completed in %llus \n",(BCM_GetTimeNs()-aCtx->startTime)/1000000000ULL);
                            retVal = BCM_ERR_OK;
                            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                            goto done;
                        } else {
                            pid = (CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid) &
                                           PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT;
                            (void)MODULE_HostHelperLog("\nFlashing PID:%x\n",CPU_LEToNative16(aCtx->ptbl.entry[aCtx->itblCount].pid));

                            if ((PTBL_ID_BL == pid) || (PTBL_ID_FW == pid) || (PTBL_ID_SYSCFG == pid)) {
                                NVM_InstallImageFetchandWrite(aMsg, aBuff, aOutLen, tarImage, aCtx);
                                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE4;
                            } else {
                                /* Write ITBL as there is no image */
                                NVM_InstallWrite(aMsg, aBuff, aOutLen, (uint8_t*)&aCtx->itbl,
                                                 CPU_NativeToLE32(aCtx->ptbl.entry[aCtx->itblCount].addr), aCtx);
                                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE5;
                            }

                        }
                    }
                    retVal = BCM_ERR_OK;
                }
            }
            break;
        default:
            break;
    }

done:
    return retVal;
}

/** @brief Process NVM request string or response byte array

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL

    @code{.unparsed}
    @endcode
*/
static int32_t NVM_InstallHelperProcess(BCM_CmdType   *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == NVM_InstallHelperCtx.modCtx.substate) {
        retVal = NVM_InstallHelperPrepCtx(aStr, aStrLen,
                                   aInOut, aOutLen, aMaxLength,
                                   &NVM_InstallHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            NVM_InstallHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }
    retVal = NVM_InstallHelperProcessCtx(aMsg, aInOut, aInputLen,
                                   aOutLen, aMaxLength, aResponse,
                                   &NVM_InstallHelperCtx);

    return retVal;
}

/**
    @brief  Install Helper

    @trace #BRCM_SWARCH_NVM_INSTALL_HELPER_GLOBAL
    @trace #BRCM_SWREQ_NVM_IMGL
*/
const MODULE_MsgConverterType FLASH_InstallHelper = {
    .helpstr = NVM_InstallHelpCmds,
    .context = &NVM_InstallHelperCtx.modCtx,
    .process = NVM_InstallHelperProcess,
};
/** @} */
