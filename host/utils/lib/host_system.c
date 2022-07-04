/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hipc.h"
#include <rpc_cmds.h>
#include <system_imgl.h>
#include <system_dmon.h>
#include <bcm_err.h>
#include <host_system.h>
#include <host_etherswt.h>
#include <bcm_utils.h>
#include <host_imgl.h>
#include <hlog.h>
#include <time.h>
#include <sys/time.h>
#include <nvm_flash.h>
#include <crc.h>
#include <hipc.h>
#include <unistd.h>
#include <bus_xfer.h>
#include <imgl_interface.h>
#include <dbgmem.h>

static DMON_HeartBeatMsgType LatestKeepAlive[3UL];

#define MGMT_OTP_READ_CMD_SIZE                  (12UL)
#define MGMT_OTP_READ_REPLY_SIZE                (16UL)
#define MGMT_OTP_CMD_DATA_SIZE                  (4UL)
#define MGMT_OTP_WRITE_CMD_SIZE                 (16UL)
#define MGMT_OTP_KEY_WRITE_OTP_INFO_SIZE        (12UL)
#define MGMT_OTP_WRITE_MAC_ADDR_INFO_SIZE       (16UL)
#define MGMT_OTP_READ_MACADDR_REPLY_SIZE        (28UL)

#define NVM_DATA_SIZE        (256UL)

typedef uint32_t HOST_SysFlashFlags;
#define HOST_SYSFLASHFLAGS_LEGACY_BROM      (0x1UL << 0UL)
#define HOST_SYSFLASHFLAGS_SKIP_BL_SIGN     (0x1UL << 1UL)


int32_t HOST_SysPing(MgmtInfoType *info, uint32_t *const mode, uint32_t * const targetFeatures)
{
    return HIPC_Ping(info, mode, targetFeatures);
}

int32_t HOST_SysReboot(MgmtInfoType *info)
{
    return HIPC_Reboot(info);
}

int32_t HOST_SysOSVersionGet(MgmtInfoType *info, char *ver)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t cmdPayload[RPC_CMDPAYLOADSZ];

    SYS_HandleType cmdHdl;
    cmdHdl.u8Ptr = &cmdPayload[0];

    RPC_ResponseType resp;
    SYS_HandleType respHdl;
    respHdl.u8Ptr = &resp.payload[0];

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (ver == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info:%p, ver:%p)\n",
            __FUNCTION__, info, ver);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = DMON_ID_SW_VERSION;

    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            0UL, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(DMON_SwVersionMsgType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        memcpy(ver, &respHdl.osVersion->str[0], sizeof(DMON_SwVersionMsgType));
    }

done:
    return retVal;
}

int32_t HOST_SysMCUInfoGet(MgmtInfoType *info, uint32_t *manuf, uint32_t *model,
                        uint32_t *rev, MCU_SecurityModeType *aSecurityMode)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t cmdPayload[RPC_CMDPAYLOADSZ];

    SYS_HandleType cmdHdl;
    cmdHdl.u8Ptr = &cmdPayload[0];

    RPC_ResponseType resp;
    SYS_HandleType respHdl;
    respHdl.u8Ptr = &resp.payload[0];

    uint32_t replyLen;
    uint32_t cmdId;

    if ((info == NULL) || (manuf == NULL) || (model == NULL) ||
        (rev == NULL)) {
        HOST_Log("%s :: Invalid input parameter(info:%p, manuf:%p model:%p rev:%p)\n",
                __FUNCTION__, info, manuf, model, rev);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = DMON_ID_HW_VERSION;

    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            0UL, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(MCU_VersionType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        *manuf = uswap32(respHdl.mcuVersion->manuf);
        *model = uswap32(respHdl.mcuVersion->model);
        *rev = uswap32(respHdl.mcuVersion->rev);
        *aSecurityMode = uswap32(respHdl.mcuVersion->securityMode);
    }

done:
    return retVal;
}

static int32_t HOST_SysSendCmd(uint32_t cmd, IMGL_UpdateAutoSyncMsgType *sendMsg)
{
    int32_t retVal = -1;
    uint32_t recv_len;
    uint32_t cmdId;
    uint8_t buffer[RPC_CMDPAYLOADSZ];

    cmdId = (BCM_GROUPID_SYS << RPC_CMD_GROUP_SHIFT);
    cmdId |= (cmd << RPC_CMD_ID_SHIFT);

    retVal = HIPC_SendRecv(cmdId, (uint8_t*)sendMsg,
            sizeof(IMGL_UpdateAutoSyncMsgType), (uint8_t*)buffer,
            sizeof(buffer), &recv_len);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (BCM_ERR_OK != uswap32(*(uint32_t*)buffer)) {
        HOST_Log("%s status:%d\n", __func__, uswap32(*(uint32_t*)buffer));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (recv_len != (sizeof(int32_t) + sizeof(IMGL_UpdateAutoSyncMsgType))) {
        HOST_Log("%s len:0x%x %x\n", __func__, recv_len, sizeof(IMGL_UpdateAutoSyncMsgType));
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

static int32_t HOST_SysFlashEraseInt(MgmtInfoType *info)
{
    int32_t retVal;
    uint32_t i;

    for (i = 0UL; i < 32UL; i++) {
        retVal = HOST_NVMErase(info, i * 65536, 65536, 0UL);
        if (BCM_ERR_OK != retVal) {
            HOST_Log("Failed to Erase sector %d\n", i);
            break;
        } else {
            HOST_Log("Erase sector %d completed\n", i);
        }
    }
    return retVal;
}

int32_t HOST_SysFlashUseNVMCmds(MgmtInfoType *info, const uint8_t* tar, HOST_SysFlashFlags aFlags)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t offset, size;
    uint32_t i,j;
    PTBL_IdType pid;
    PTBL_Type ptbl;
    ITBL_Type itbl;
    uint32_t ptblFlashOffset = 0;

    retVal = HOST_SysFlashEraseInt(info);
    if (BCM_ERR_OK != retVal) {
        goto err_sys_use_nvm;
    }

    /* Flash Bootloader */
    if (0UL != (aFlags & HOST_SYSFLASHFLAGS_LEGACY_BROM)) {
        HOST_Log("Flashing bootloader for Legacy BootRom\n");
        /* Retrieve bootloader img tar offset and size */
        retVal = HOST_ImglGetImg(&offset, &size, 1UL, 1UL);

        if (BCM_ERR_OK != retVal) {
            HOST_Log("Failed to get bl img\n");
            goto err_sys_use_nvm;
        } else {
            /* F1 expects an executable at flash offset 0, starting with a header 0x900Dc0DE */
            retVal = HOST_NVMwrite(info, &tar[offset], size, 0UL, 0UL);
            if (BCM_ERR_OK != retVal) {
                HOST_Log("Failed to Write bl image\n");
                goto err_sys_use_nvm;
            }
            ptblFlashOffset += 0x20000UL;
        }
    }

    /* Flash Partition Table */
    retVal = HOST_ImglGetPtbl(&offset, &size);
    if (BCM_ERR_OK != retVal) {
        HOST_Log("Failed to get PTBL offset\n");
        goto err_sys_use_nvm;
    } else {
        memset(&ptbl, 0xFF, sizeof(ptbl));
        memcpy(&ptbl, &tar[offset], size);
        size  = sizeof(ptbl);
    }
    for (i = 0UL; i < 16UL; i++) {
        retVal = HOST_NVMwrite(info, (const uint8_t *)&ptbl, size, ptblFlashOffset + i*size, 0UL);
        if (BCM_ERR_OK != retVal) {
            HOST_Log("Failed to Write PTBL(%d)\n", i);
            goto err_sys_use_nvm;
        }
    }
    HOST_Log("Programmed Partition Table successfully\n");

    /* Flash images and their table */
    for (i = 0UL; i < uswap32(ptbl.hdr.numEntries); i++) {
        if (0UL != uswap16(ptbl.entry[i].pid)) {
            HOST_Log("Flashing PID:%x\n", uswap16(ptbl.entry[i].pid));
            pid = (uswap16(ptbl.entry[i].pid) & PTBL_ID_TYPE_MASK) >> PTBL_ID_TYPE_SHIFT;
            retVal = HOST_ImglGetItbl(&offset, &size, pid);
            if (BCM_ERR_OK != retVal) {
                HOST_Log("Failed to get ITBL offset %x\n", uswap16(ptbl.entry[i].pid));
                goto err_sys_use_nvm;
            } else {
                memcpy(&itbl, &tar[offset], size);
            }

            uint32_t itblRecomputeCrc = 0;

            if ((PTBL_ID_BL == pid) || (PTBL_ID_FW == pid) || (PTBL_ID_SYSCFG == pid)) {
                for (j = 0UL; j < uswap32(itbl.hdr.numImgs); j++) {
                    if (0xFFFF != uswap16(itbl.entry[j].imgType)) {
                        retVal = HOST_ImglGetImg(&offset, &size, pid, uswap16(itbl.entry[j].imgType));
                        if (BCM_ERR_OK != retVal) {
                            HOST_Log("Failed to Get image (%x:%x)\n", uswap16(ptbl.entry[i].pid), uswap16(itbl.entry[j].imgType));
                            goto err_sys_use_nvm;
                        } else {
                            if ((PTBL_ID_BL == pid) && (0UL != (aFlags & HOST_SYSFLASHFLAGS_SKIP_BL_SIGN))) {
                                HOST_Log("Stripping off signature from bootloader image\n");
                                offset += 256;
                                size -= 256;
                                itbl.entry[j].crc = uswap32(BCM_CRC32(&tar[offset], size, ITBL_CRC32_POLY));
                                itbl.entry[j].actualSize = uswap32(size);
                                itblRecomputeCrc = 1;
                            }
                            retVal = HOST_NVMwrite(info, &tar[offset], size,
                                                    uswap32(ptbl.entry[i].addr) + uswap32(itbl.entry[j].flashOffset), 0UL);
                            if (BCM_ERR_OK != retVal) {
                                HOST_Log("Failed to Write image (%x:%x)\n", uswap16(ptbl.entry[i].pid), uswap16(itbl.entry[j].imgType));
                                goto err_sys_use_nvm;
                            }
                        }
                    }
                }
            }

            /* Update ITBL CRC if image was modified */
            if (1 == itblRecomputeCrc) {
                itbl.hdr.crc = uswap32(BCM_CRC32((uint8_t *)&itbl.entry[0], (uswap32(itbl.hdr.numImgs) * ITBL_ENTRY_SIZE), ITBL_CRC32_POLY));
                itbl.hdr.hdrErrDetCode = uswap32(BCM_CRC32((uint8_t *)&itbl.hdr, (ITBL_HDR_SIZE - 4), ITBL_CRC32_POLY));
            }

            retVal = HOST_NVMwrite(info, (const uint8_t *)&itbl, ITBL_HDR_SIZE + ((uswap32(itbl.hdr.numImgs) * ITBL_ENTRY_SIZE)), uswap32(ptbl.entry[i].addr), 0UL);
            if (BCM_ERR_OK != retVal) {
                HOST_Log("Failed to Write ITBL (%x)\n", uswap16(ptbl.entry[i].pid));
                goto err_sys_use_nvm;
            }
        }
    }

err_sys_use_nvm:
    return retVal;
}

int32_t HOST_SysFirmwareUpdate(MgmtInfoType *info, uint32_t mode, const uint8_t *image, uint32_t len)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    struct timeval tv_start;
    struct timeval tv_end, tv_diff;
    const uint8_t *tar = image + 20UL;
    IMGL_UpdateAutoSyncMsgType sendMsgBuf;
    uint32_t manuf = 0UL;
    uint32_t model = 0UL;
    uint32_t rev = 0UL;
    MCU_SecurityModeType securityMode = MCU_SECURITY_MODE_NONE;
    HOST_SysFlashFlags flags = 0UL;

    retVal = HOST_SysFirmwareExecute(info, image, len);
    if (BCM_ERR_OK == retVal) {
        retVal = HOST_SysMCUInfoGet(info, &manuf, &model, &rev, &securityMode);
        HOST_Log("MCU Info- manuf:0x%x model:0x%x rev:0x%x securityMode0x%x\n", manuf, model, rev, securityMode);
        if ((BCM_ERR_OK == retVal) && (MCU_SECURITY_MODE_UNKNOWN != securityMode)) {
            switch (model) {
            case 0x89530UL:
            case 0x89531UL:
            case 0x89535UL:
            case 0x89230UL:
                if (0xCUL > rev) {
                    flags |= HOST_SYSFLASHFLAGS_LEGACY_BROM;
                } else {
                    if (MCU_SECURITY_MODE_NONE == securityMode) {
                        flags |= HOST_SYSFLASHFLAGS_SKIP_BL_SIGN;
                    }
                }
            case 0x89560UL:
            case 0x89561UL:
            case 0x89261UL:
            case 0x89564UL:
                if ((0UL == (rev & 0x1UL)) && (MCU_SECURITY_MODE_NONE == securityMode)) {
                    flags |= HOST_SYSFLASHFLAGS_SKIP_BL_SIGN;
                }
                break;
            default:
                /* No special handling */
                break;
            }

            gettimeofday(&tv_start, NULL);
            if (INSTALL_MODE_ALL == mode) {
                retVal = HOST_SysFlashUseNVMCmds(info, tar, flags);
            } else {
                memset(&sendMsgBuf, 0, sizeof(IMGL_UpdateAutoSyncMsgType));
                retVal = HOST_ImglGetParsedImgHdrs(HIPC_INSTALL_OTA, &sendMsgBuf);
                if (BCM_ERR_OK != retVal) {
                    HOST_Log("%s Couldn't get Parsed Image Headers, \n", __func__);
                } else {
                    sendMsgBuf.flashId = uswap32(0UL);
                    sendMsgBuf.fetchChannel = IMGL_CHANNEL_ID_RPC_IPC;
                    retVal = HOST_SysSendCmd(IMGL_ID_UPDATE_AUTO_SYNC, &sendMsgBuf);
                    if (retVal != BCM_ERR_OK) {
                        HOST_Log("Failed to program the flash memory err=%d\n", retVal);
                    }
                }
            }
            gettimeofday(&tv_end, NULL);
            timersub(&tv_end, &tv_start, &tv_diff);
            if (BCM_ERR_OK != retVal) {
                HOST_Log("\n%s completed with status:%d in %lus\n", __func__, retVal, tv_diff.tv_sec);
            } else {
                /* Note: AT scripts look for this string to determine completion */
                HOST_Log("\nProgrammed flash memory successfully in %lus\n", tv_diff.tv_sec);
            }
        }
    }

    return retVal;
}

/*
 - Setup IMGL layer with image information so that it can service any requests
   from target
 - Transfer bootloader and let it execute
    - BL will eventually request images through RPC and IMGL will service such
      requests
 - Confirm that the target has indeed entered into firmware mode
     - Wait for 60seconds for bootloader to fetch firmware and execute it, which
       will eventually fetch required configuration images boot-up
*/
int32_t HOST_SysFirmwareExecute(MgmtInfoType *info, const uint8_t *image, uint32_t len)
{
    int32_t retVal = -1;
    const uint8_t *tar = image + 20UL;
    BCM_BootModeType mode;
    HIPC_TargetFeatureType features;
    struct timeval tv_start, tv_end, tv_diff;

    gettimeofday(&tv_start, NULL);

    retVal = HIPC_GetTargetSWMode(info, &mode, &features);
    if (BCM_ERR_OK == retVal) {
        retVal = HOST_ImglSet(tar, len);
        if (BCM_ERR_OK != retVal) {
            HOST_Log("Failed to parse the TAR image\n");
            goto err_exit;
        }

        if (BCM_BOOT_MODE_FW == mode) {
            /* retVal will be BCM_ERR_OK */
        } else if (BCM_BOOT_MODE_BROM == mode) {
            /* Initiate BL transfer only if target doesn't have the capability to fetch */
            if (0UL == (features & HIPC_TARGETFEATURE_FETCHIMG)) {
                HOST_Log("%s: Sending Bootloader\n", __func__);
                retVal = HIPC_ExecuteOnTarget(info, HIPC_INSTALL_OTA, tar);
                if (BCM_ERR_OK != retVal) {
                    HOST_Log("%s:%d\n", __func__, __LINE__);
                } else {
                    /* wait for firmware to boot-up */
                    do {
                        retVal = HIPC_GetTargetSWMode(info, &mode, &features);
                        if ((BCM_ERR_OK == retVal) && (BCM_BOOT_MODE_FW == mode)) {
                            break;
                        } else {
                            gettimeofday(&tv_end, NULL);
                            timersub(&tv_end, &tv_start, &tv_diff);
                            retVal = BCM_ERR_UNKNOWN;
                        }
                    } while (tv_diff.tv_sec < 60UL);

                    if (BCM_ERR_OK != retVal) {
                        HOST_Log("%s:%d Firmware boot failed\n", __func__, __LINE__);
                        HOST_Log("start:%lu end:%lu diff:%lu\n", tv_start.tv_sec, tv_end.tv_sec, tv_diff.tv_sec);
                    }
                }
            } else {
                /* retVal will be BCM_ERR_OK */
                HOST_Log("%s: Wait for target to fetch images\n", __func__);
            }
        } else {
            retVal = BCM_ERR_UNKNOWN;
            HOST_Log("%s:%d target mode:0x%x\n", __func__, __LINE__, mode);
        }
    } else {
        HOST_Log("%s Failed to get target SW mode\n", __func__);
    }
err_exit:
    if (BCM_ERR_OK == retVal) {
        gettimeofday(&tv_end, NULL);
        timersub(&tv_end, &tv_start, &tv_diff);
        /* Note: AT scripts look for this string to determine completion */
        HOST_Log("\nExecuted Firmware in %lus\n", tv_diff.tv_sec);
    }
    return retVal;
}

int32_t HOST_SysFlashErase(MgmtInfoType *info, const uint8_t *image, uint32_t len)
{
    int32_t retVal;
    struct timeval tv_start, tv_end, tv_diff;

    retVal = HOST_SysFirmwareExecute(info, image, len);
    if (BCM_ERR_OK == retVal) {
        gettimeofday(&tv_start, NULL);
        retVal = HOST_SysFlashEraseInt(info);
        if (BCM_ERR_OK == retVal) {
            gettimeofday(&tv_end, NULL);
            timersub(&tv_end, &tv_start, &tv_diff);

            /* Note: AT scripts look for this string to determine completion */
            HOST_Log("\nErased flash memory successfully in %lus\n", tv_diff.tv_sec);
        }
    }

    return retVal;
}

int32_t HOST_SysNotificationHandler(uint32_t currentSlave,
            BCM_CompIDType comp, uint8_t notificationId,
            uint8_t *msg, uint32_t size)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    SYS_HandleType notificationHdl;

    notificationHdl.u8Ptr = msg;

    if ((BCM_RSV_ID != comp) && (BCM_SYS_ID != comp) && (BCM_DMN_ID != comp)) {
        HOST_Log("%s SPI-Id:%u Invalid parameter comp:0x%x notificationId:0x%x size=%d\n",
            __func__, currentSlave, comp, notificationId, size);
        goto done;
    }

    if (DMON_ID_HEART_BEAT == BCM_ASYNCID(BCM_GROUPID_SYS, comp, notificationId)) {
        LatestKeepAlive[currentSlave].upTime.s = uswap32(notificationHdl.keepAlive->upTime.s);
        LatestKeepAlive[currentSlave].upTime.ns = uswap32(notificationHdl.keepAlive->upTime.ns);
        LatestKeepAlive[currentSlave].count = uswap32(notificationHdl.keepAlive->count);
        LatestKeepAlive[currentSlave].temperature = uswap32(notificationHdl.keepAlive->temperature);
        LatestKeepAlive[currentSlave].voltage = uswap32(notificationHdl.keepAlive->voltage);
        LatestKeepAlive[currentSlave].state = uswap32(notificationHdl.keepAlive->state);
        retVal = BCM_ERR_OK;
    } else {
        HOST_Log("%s SPI-Id:%u Invalid parameter comp:0x%x notificationId:0x%x size=%d\n",
            __func__, currentSlave, comp, notificationId, size);
    }

done:
    return retVal;
}

int32_t HOST_SysKeepAliveGet(MgmtInfoType *info, uint32_t slaveID,
                    DMON_HeartBeatMsgType *keepAlive)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((info == NULL) || (keepAlive == NULL)) {
        HOST_Log("%s Invalid parameters info:%p keepAlive:%p\n", __func__, info, keepAlive);
        goto done;
    }

    memcpy((uint8_t *)keepAlive, (uint8_t *)&LatestKeepAlive[slaveID], sizeof(DMON_HeartBeatMsgType));
    retVal = BCM_ERR_OK;

done:
    return retVal;
}

#ifdef ENABLE_DBGMEM
int32_t HOST_MemoryWrite(MgmtInfoType *info, MCU_DeviceType destn, uint32_t addr,
                         uint32_t width, uint32_t len, volatile uint8_t *data)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t cmdPayload[RPC_CMDPAYLOADSZ];

    SYS_HandleType cmdHdl;
    cmdHdl.u8Ptr = &cmdPayload[0];

    RPC_ResponseType resp;
    SYS_HandleType respHdl;
    respHdl.u8Ptr = &resp.payload[0];

    uint32_t replyLen;
    uint32_t cmdId;
    DBGMEM_HandleType dstMemHdl, srcMemHdl;
    int i;

    srcMemHdl.u8Ptr = data;
    dstMemHdl.u8Ptr = &cmdHdl.memAccess->data[0];

    if ((info == NULL) || (data == NULL) || (len == 0UL)
        || ((width != 8) && (width != 16) && (width != 32))) {
        HOST_Log("%s Invalid parameters info:%p data:%p len:%u\n", __func__, info, data, len);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = DMON_ID_MEM_WRITE;

    cmdHdl.memAccess->addr = uswap32(addr);
    cmdHdl.memAccess->width = uswap32(width);
    cmdHdl.memAccess->len = uswap32(len);
    cmdHdl.memAccess->deviceID = uswap32(destn);

    for (i = 0; i < len; i++) {
        if (width == 8) {
            *dstMemHdl.u8Ptr = *srcMemHdl.u8Ptr;
            srcMemHdl.u8Ptr++;
            dstMemHdl.u8Ptr++;
        } else if (width == 16) {
            *dstMemHdl.u16Ptr = uswap16(*srcMemHdl.u16Ptr);
            srcMemHdl.u16Ptr++;
            dstMemHdl.u16Ptr++;
        } else if (width == 32) {
            *dstMemHdl.u32Ptr = uswap32(*srcMemHdl.u32Ptr);
            srcMemHdl.u32Ptr++;
            dstMemHdl.u32Ptr++;
        }
    }

    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            sizeof(DMON_MemAccessMsgType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(DMON_MemAccessMsgType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_MemoryRead(MgmtInfoType *info, MCU_DeviceType destn, uint32_t addr,
                        uint32_t width, uint32_t len, volatile uint8_t *data)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint8_t cmdPayload[RPC_CMDPAYLOADSZ];

    SYS_HandleType cmdHdl;
    cmdHdl.u8Ptr = &cmdPayload[0];

    RPC_ResponseType resp;
    SYS_HandleType respHdl;
    respHdl.u8Ptr = &resp.payload[0];

    uint32_t replyLen;
    uint32_t cmdId;
    DBGMEM_HandleType dstMemHdl, srcMemHdl;
    int i;

    dstMemHdl.u8Ptr = data;
    srcMemHdl.u8Ptr = &respHdl.memAccess->data[0];

    if ((info == NULL) || (data == NULL) || (len == 0UL)
        || ((width != 8) && (width != 16) && (width != 32))) {
        HOST_Log("%s Invalid parameters info:%p data:%p len:%u\n", __func__, info, data, len);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = DMON_ID_MEM_READ;

    cmdHdl.memAccess->addr = uswap32(addr);
    cmdHdl.memAccess->width = uswap32(width);
    cmdHdl.memAccess->len = uswap32(len);
    cmdHdl.memAccess->deviceID = uswap32(destn);

    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            sizeof(DMON_MemAccessMsgType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(DMON_MemAccessMsgType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        for (i = 0; i < len; i++) {
            if (width == 8) {
                *dstMemHdl.u8Ptr = *srcMemHdl.u8Ptr;
                srcMemHdl.u8Ptr++;
                dstMemHdl.u8Ptr++;
            } else if (width == 16) {
                *dstMemHdl.u16Ptr = uswap16(*srcMemHdl.u16Ptr);
                srcMemHdl.u16Ptr++;
                dstMemHdl.u16Ptr++;
            } else if (width == 32) {
                *dstMemHdl.u32Ptr = uswap32(*srcMemHdl.u32Ptr);
                srcMemHdl.u32Ptr++;
                dstMemHdl.u32Ptr++;
            }
        }
    }

done:
    return retVal;
}
#endif

int32_t HOST_SysInit(MgmtInfoType *info)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    memset(info, 0, sizeof(MgmtInfoType));

#if defined(HIPC_ENABLE_SPI)
    /* Connect through SPI */
    info->connection_type = MGMT_SPI_CONNECTION;
#elif defined(HIPC_ENABLE_PCIE)
    info->connection_type = MGMT_PCIE_CONNECTION;
#else
    info->connection_type = MGMT_NO_CONNECTION;
#endif

    /*initialize spi*/
    retVal = HIPC_Init();

done:
    return retVal;
}

int32_t HOST_SysDeinit(MgmtInfoType *info)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (info == NULL) {
        HOST_Log("%s :: MgmtInfoType pointer is NULL\n", __FUNCTION__);
        goto done;
    }
    memset(info, 0, sizeof(MgmtInfoType));

    /* Connect through SPI */
    info->connection_type = MGMT_NO_CONNECTION;

    HIPC_Deinit();
    retVal = BCM_ERR_OK;

done:
    return retVal;
}

int32_t HOST_NVMwrite(MgmtInfoType *info, const uint8_t *buff, uint32_t len, uint32_t offset, uint32_t id)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t replyLen;
    uint32_t cmdId;
    uint32_t pkts;
    int32_t index = 0UL;
    int32_t i;

    FLASH_HandleType cmdHdl;

    RPC_ResponseType resp;
    FLASH_RpcWriteInfoType* respHdl;
    respHdl = (FLASH_RpcWriteInfoType*) &resp.payload[0];

    if ((NULL == info) || (NULL == buff) || (0UL == len)) {
        HOST_Log("%s Invalid parameters info:%p data:%p len:%u\n", __func__, info, buff, len);
        goto done;
    }

    memset(cmdHdl.data, 0, FLASH_RPC_MAX_PAYLOAD_SIZE);
    memset(respHdl, 0, RPC_RESPPAYLOADSZ);

    if(0U == (len%NVM_DATA_SIZE)) {
        pkts = len/NVM_DATA_SIZE;
    } else {
        pkts = (len/NVM_DATA_SIZE)+1;
    }

    cmdHdl.rpcWriteInfo.hwID = uswap32(id);
    cmdHdl.rpcWriteInfo.len = uswap32(NVM_DATA_SIZE);
    cmdId = FLASH_CMD_RPC_WRITE;

    for(i=0;i<pkts;i++) {
        cmdHdl.rpcWriteInfo.addr = uswap32(offset+index);
        memcpy((&cmdHdl.rpcWriteInfo.bufIn[0]),&buff[index],NVM_DATA_SIZE);
        retVal = HIPC_SendRecv(cmdId, cmdHdl.data,
                sizeof(FLASH_RpcWriteInfoType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
        if (retVal != BCM_ERR_OK) {
            goto done;
        } else if (uswap32(resp.status) != BCM_ERR_OK) {
            HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        } else if (replyLen != (MGMT_STATUS_LEN + sizeof(FLASH_RpcWriteInfoType))) {
            HOST_Log("%s len:0x%x\n", __func__, replyLen);
            retVal = BCM_ERR_DATA_INTEG;
            goto done;
        }
        HOST_Log("\r%03u%%", ((index*100)/len));
        fflush(stdout);

        index += NVM_DATA_SIZE;
    }

done:
    return retVal;
}

int32_t HOST_NVMErase(MgmtInfoType *info, uint32_t offset, uint32_t size, uint32_t id)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t replyLen;
    uint32_t cmdId;
    FLASH_HandleType cmdHdl;

    RPC_ResponseType resp;
    FLASH_RpcEraseInfoType* respHdl;
    respHdl = (FLASH_RpcEraseInfoType*) &resp.payload[0];

    if ((NULL == info) || (0UL == size)) {
        HOST_Log("%s Invalid parameters info:%p size:%u\n", __func__, info, size);
        goto done;
    }

    memset(cmdHdl.data, 0, FLASH_RPC_MAX_PAYLOAD_SIZE);
    memset(respHdl, 0, RPC_RESPPAYLOADSZ);

    cmdHdl.rpcEraseInfo.hwID = uswap32(id);
    cmdHdl.rpcEraseInfo.addr = uswap32(offset);
    cmdHdl.rpcEraseInfo.len = uswap32(size);

    cmdId = FLASH_CMD_RPC_ERASE;

    retVal = HIPC_SendRecv(cmdId, cmdHdl.data,
            sizeof(FLASH_RpcEraseInfoType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(FLASH_RpcEraseInfoType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HOST_NVMRead(MgmtInfoType *info, uint8_t *buff, uint32_t len, uint32_t offset, uint32_t id)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t replyLen;
    uint32_t cmdId;
    int32_t index = 0UL;
    uint32_t pkts;
    uint32_t lastPktSz;
    int32_t i;
    FLASH_HandleType cmdHdl;

    RPC_ResponseType resp;
    FLASH_RpcReadInfoType* respHdl;
    respHdl = (FLASH_RpcReadInfoType*) &resp.payload[0];


    if ((NULL == info) || (NULL == buff) || (0UL == len)) {
        HOST_Log("%s Invalid parameters info:%p data:%p len:%u\n", __func__, info, buff, len);
        goto done;
    }

    memset(cmdHdl.data, 0, FLASH_RPC_MAX_PAYLOAD_SIZE);
    memset(respHdl, 0, RPC_RESPPAYLOADSZ);

    /* calculate the no of packets w.r.t 256 Bytes pkt size */
    if(0U == (len%NVM_DATA_SIZE)) {
        pkts = len/NVM_DATA_SIZE;
        lastPktSz = NVM_DATA_SIZE;
    } else {
        pkts = (len/NVM_DATA_SIZE)+1;
        lastPktSz = (len%NVM_DATA_SIZE);
    }

    cmdHdl.rpcReadInfo.hwID = uswap32(id);
    cmdHdl.rpcReadInfo.len = uswap32(NVM_DATA_SIZE);
    cmdId = FLASH_CMD_RPC_READ;


    for(i=0;i<pkts;i++) {
        cmdHdl.rpcReadInfo.addr = uswap32(offset+index);
        retVal = HIPC_SendRecv(cmdId, cmdHdl.data,
                sizeof(FLASH_RpcReadInfoType), (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

        if (retVal != BCM_ERR_OK) {
            goto done;
        } else if (uswap32(resp.status) != BCM_ERR_OK) {
            HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        } else if (replyLen != (MGMT_STATUS_LEN + sizeof(FLASH_RpcReadInfoType))) {
            HOST_Log("%s len:0x%x\n", __func__, replyLen);
            retVal = BCM_ERR_DATA_INTEG;
            goto done;
        } else {
            /* Check if it is the last packet */
            if((pkts - 1UL) == i) {
                /* Write up to the max requested size only */
                memcpy(&buff[index], &respHdl->bufOut[0], lastPktSz);
                index += lastPktSz;
            } else {
                memcpy(&buff[index], &respHdl->bufOut[0], NVM_DATA_SIZE);
                index += NVM_DATA_SIZE;
            }
        }
        HOST_Log("\r%03u%%", ((index*100)/len));
        fflush(stdout);
    }

done:
    return retVal;

}

int32_t HOST_RegWrite(MgmtInfoType *info, uint32_t addr, uint32_t width, uint64_t data)
{
    int32_t retVal;
    uint32_t slaveId = 0UL;
    uint8_t *tmp;
    uint8_t u8Data;
    uint16_t u16Data;
    uint32_t u32Data;

    if ((NULL == info)
        || ((8UL != width) && (16UL != width) && (32UL != width) && (64UL != width))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = HIPC_GetSlave(&slaveId);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
            switch (width) {
            case 8UL:
                u8Data = (uint8_t)(data & 0xFFU);
                tmp = &u8Data;
                break;
            case 16UL:
                u16Data = (uint16_t)(data & 0xFFFFU);
                tmp = (uint8_t *)&u16Data;
                break;
            case 32UL:
                u32Data = (uint32_t)(data & 0xFFFFFFFFUL);
                tmp = (uint8_t *)&u32Data;
                break;
            default:
                tmp = (uint8_t *)&data;
                break;
            }
            retVal = HIPC_BusXferWrite(slaveId, HIPC_BUS_ACCESS_INDIRECT, addr, tmp, width);
        }
    }

    return retVal;
}

int32_t HOST_RegRead(MgmtInfoType *info, uint32_t addr, uint32_t width, uint64_t *data)
{
    int32_t retVal;
    uint32_t slaveId = 0UL;
    uint64_t temp;
    uint8_t *ptr;
    ptr = (uint8_t *)&temp;

    if ((NULL == info) || (NULL == data)
        || ((8UL != width) && (16UL != width) && (32UL != width) && (64UL != width))) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        retVal = HIPC_GetSlave(&slaveId);
        if (BCM_ERR_OK != retVal) {
            retVal = BCM_ERR_UNKNOWN;
        } else {
            retVal = HIPC_BusXferRead(slaveId, HIPC_BUS_ACCESS_INDIRECT, addr, ptr, width);
        }
        switch (width) {
        case 8UL:
            *data = *ptr;
            break;
        case 16UL:
            *data = *(uint16_t *)ptr;
            break;
        case 32UL:
            *data = *(uint32_t *)ptr;
            break;
        default:
            *data = temp;
            break;
        }
    }

    return retVal;
}
