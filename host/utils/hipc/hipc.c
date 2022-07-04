/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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

#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <ipc.h>
#include "hipc.h"
#include "bus_xfer.h"
#include "spi.h"
#include "spi_xfer.h"
#include <bcm_err.h>
#include "bl_downloader.h"
#include "bl_ipc_downloader.h"
#include "mcu.h"
#include "bcm_utils.h"
#include <rpc_cmds.h>
#include <hipc_plat.h>
#include <system_dmon.h>
#include <crc.h>
#include <hlog.h>
#include <rpc_cmds.h>
#include <host_imgl.h>
#include <rpc_ipc_common.h>

#ifdef HOST_PROCESSOR_X86
#include "jlink_xfer.h"
#else
#include <gpio.h>
#endif

#ifdef HOST_ENABLE_PCIE
#include "pcie_xfer.h"
#endif

#define SPI_SPEED                   (12500000) /* Minimum 80ns as per DS */
#define USEC_PER_MSEC               (1000)

#define HIPC_TARGET_REBOOT_DELAY_MS      (10UL)    /* 10ms */
#define HIPC_BOOTLOADER_BOOTUP_TIME_MS   (1000UL)  /* 1sec */
#define CRC32_POLY                       (0x04C11DB7UL)

/* SPI_ID */
typedef uint32_t SPI_ID_t;
#define SPI_ID_0            (0UL)
#define SPI_ID_1            (1UL)
#define SPI_ID_2            (2UL)
#define SPI_ID_3            (3UL)
#define SPI_ID_MIN          (SPI_ID_0)
#define SPI_ID_MAX          (SPI_ID_3) /* Limited by the two bits[7:6] in OpCode */
#define SPI_ID_INVAL        (0xFFFFFFFFUL)
#define SPI_ID_DEFAULT      (SPI_ID_2)

#define SPI_SLAVES_MAX      (3UL) /* Limited by light-stacking */

#define BOOT_INFO_SPARE_REG             (MISC_SPARE_SW_REG3)

#define BL_IMG_SIGNATURE_SIZE   (256UL)
#define MSG_BUF_SIZE    (512UL - 128UL)

#define HIPC_INTERFACE_MODE_IDX_JLINK     0UL   /* Default Interface for x86 is Jlink */
#define HIPC_INTERFACE_MODE_IDX_SPI       0UL   /* Default Interface for NS2 is SPI   */
#define HIPC_INTERFACE_MODE_IDX_PCIE      1UL

static uint8_t send_msg_buf[RPC_CMDPAYLOADSZ];
static uint8_t *snd_msg = send_msg_buf;
static uint8_t recv_msg_buf[RPC_CMDPAYLOADSZ];
static uint8_t *recv_msg = recv_msg_buf;


/* All IDs which have been probed during start-up gets registered here */
static uint32_t ActiveSpiId[SPI_SLAVES_MAX];

MCU_VersionType HIPC_McuVersion;
uint32_t HIPC_McuVersionReady;

/* HIPC Interface related structure and function pointers */
static uint32_t HIPC_IfcModeIdx;

static const uint32_t HIPC_InterfaceDefaultId[] = {
#ifdef HOST_PROCESSOR_X86
    0UL,
#else
    SPI_ID_DEFAULT,
#endif
#ifdef HOST_ENABLE_PCIE
    0UL,
#endif
};

static const uint32_t HIPC_InterfaceDefaultClk[] = {
#ifdef HOST_PROCESSOR_X86
    5000000UL,
#else
    SPI_SPEED,
#endif
#ifdef HOST_ENABLE_PCIE
    0xFFFFFFFUL,
#endif
};

static const int32_t (*HIPC_BusInitFunc[])(uint32_t busSerial, uint32_t chip, uint32_t devId, uint32_t speed) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_Init,
#else
    SPI_Init,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_Init,
#endif
};

static const int32_t (*HIPC_BusXferReadFunc[])(uint32_t slaveId,
                                                       HIPC_BusAccessType access,
                                                       uint32_t addr,
                                                       uint8_t *data,
                                                       uint32_t width) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_XferRead,
#else
    SPI_XferRead,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_XferRead,
#endif
};

static const int32_t (*HIPC_BusXferBulkReadFunc[])(uint32_t slaveId,
                                                       HIPC_BusAccessType access,
                                                       uint32_t addr,
                                                       uint8_t *data,
                                                       uint32_t size) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_XferBulkRead,
#else
    SPI_XferBulkRead,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_XferBulkRead,
#endif
};

static const int32_t (*HIPC_BusXferWriteFunc[])(uint32_t slaveId,
                                                            HIPC_BusAccessType access,
                                                            uint32_t addr,
                                                            uint8_t *data,
                                                            uint32_t width) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_XferWrite,
#else
    SPI_XferWrite,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_XferWrite,
#endif
};

static const int32_t (*HIPC_BusXferBulkWriteFunc[])(uint32_t slaveId,
                                                            HIPC_BusAccessType access,
                                                            uint32_t addr,
                                                            uint8_t *data,
                                                            uint32_t size) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_XferBulkWrite,
#else
    SPI_XferBulkWrite,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_XferBulkWrite,
#endif
};

static const void (*HIPC_BusDeInitFunc[])(void) = {
#ifdef HOST_PROCESSOR_X86
    JLINK_DeInit,
#else
    SPI_Deinit,
#endif
#ifdef HOST_ENABLE_PCIE
    PCIE_DeInit,
#endif
};

int32_t HIPC_GetMcuVersion(MCU_VersionType *aVersion)
{
    int32_t retVal;
    if (NULL == aVersion) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (1UL != HIPC_McuVersionReady) {
        retVal = BCM_ERR_NOT_FOUND;
    } else {
        memcpy(aVersion, &HIPC_McuVersion, sizeof(MCU_VersionType));
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

#define HIPC_NUM_RESPONSES  (16UL)
uint32_t HIPC_ResponseId[HIPC_NUM_RESPONSES];
uint32_t HIPC_ResponseLength[HIPC_NUM_RESPONSES];
uint8_t HIPC_Response[HIPC_NUM_RESPONSES][RPC_CMDPAYLOADSZ];
uint32_t  HIPC_ResponsesFree;

static int32_t HIPC_AddResonse(uint32_t aRespId, uint8_t *aResp, uint32_t aRespLen)
{
    int32_t retVal = BCM_ERR_NOMEM;
    uint32_t i;
    for (i = 0UL; i < HIPC_NUM_RESPONSES; i++) {
        if (0UL == (HIPC_ResponsesFree & (1UL << i))) {
            HIPC_ResponsesFree |= (1UL << i);
            memcpy(HIPC_Response[i], aResp, aRespLen);
            HIPC_ResponseId[i] = aRespId;
            HIPC_ResponseLength[i] = aRespLen;
            retVal = BCM_ERR_OK;
            break;
        }
    }
    return retVal;
}

static int32_t HIPC_FindResponse(uint32_t aRespId, uint8_t *aResp, uint32_t aRespLen, uint32_t *aActRespLen)
{
    int32_t retVal = BCM_ERR_NOT_FOUND;
    uint32_t i;
    for (i = 0UL; i < HIPC_NUM_RESPONSES; i++) {
        if ((0UL != (HIPC_ResponsesFree & (1UL << i)))
            && (HIPC_ResponseId[i] == aRespId)) {
            HIPC_ResponsesFree &= ~(1UL << i);
            memcpy(aResp, HIPC_Response[i], HIPC_ResponseLength[i]);
            *aActRespLen = HIPC_ResponseLength[i];
            retVal = BCM_ERR_OK;
            break;
        }
    }
    return retVal;
}

static int32_t HIPC_PingInternal(MgmtInfoType *info, uint32_t *const mode, uint32_t * const targetFeatures, uint8_t aGroupId)
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

    if ((info == NULL) || (NULL == mode) || (NULL == targetFeatures)) {
        HOST_Log("%s :: Invalid input parameter(info:%p) mode:%p targetFeatures:%p\n",
            __FUNCTION__, info, mode, targetFeatures);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    if (BCM_GROUPID_SYS == aGroupId) {
        cmdId = DMON_ID_PING;
    } else {
        cmdId = BCM_CMDID(aGroupId, BCM_RSV_ID, RPC_CMDIDVAL_PING);
    }
    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            0UL, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(DMON_PingMsgType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        *mode = uswap32(respHdl.ping->mode);
        HIPC_McuVersion.manuf = uswap32(respHdl.ping->version.manuf);
        HIPC_McuVersion.model = uswap32(respHdl.ping->version.model);
        HIPC_McuVersion.rev = uswap32(respHdl.ping->version.rev);
        HIPC_McuVersion.securityMode = uswap32(respHdl.ping->version.secMode);
        HIPC_McuVersionReady = 1UL;

        retVal = HIPC_PlatGetTargetFeature(&HIPC_McuVersion, targetFeatures);
        if (retVal != BCM_ERR_OK) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

done:
    return retVal;
}

int32_t HIPC_Ping(MgmtInfoType *info, uint32_t *const mode, uint32_t * const targetFeatures)
{
    return HIPC_PingInternal(info, mode, targetFeatures, BCM_GROUPID_SYS);
}

#ifdef __BCM8953X__
static int32_t HIPC_PingRom(MgmtInfoType *info)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t replyId = 0;
    uint8_t cmdPayload[RPC_CMDPAYLOADSZ];

    SYS_HandleType cmdHdl;
    cmdHdl.u8Ptr = &cmdPayload[0];

    RPC_ResponseType resp;
    SYS_HandleType respHdl;
    respHdl.u8Ptr = &resp.payload[0];

    uint32_t replyLen;
    uint32_t cmdId;

    if (info == NULL) {
        HOST_Log("%s :: Invalid input parameter(info:%p)\n",
            __FUNCTION__, info);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, BCM_CMDIDVAL_PING);

    /*
        - Send a PING message to target
        - In response, if the target responds with a replyId =
          BCM_ERR_INVAL_MAGIC, then it is a BCM89559 board in ROM mode
        - However if the replyId matches asynchronous messages, then process
          them as usual
    */

    retVal = HIPC_Send(cmdId, cmdHdl.u8Ptr, 4UL);
    if (retVal != BCM_ERR_OK) {
        HOST_Log("%s Failed to send command, err:%d\n", __func__, retVal);
        goto done;
    }

    /* Check for response */
    do {
        retVal = HIPC_FindResponse(cmdId, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
        if (BCM_ERR_OK != retVal) {
            retVal = HIPC_Recv(&replyId, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
            if (retVal == BCM_ERR_OK) {
                if (RPC_CMD_ASYNC_MASK == (RPC_CMD_ASYNC_MASK & replyId)) {
                    HOST_Log("%s Async msg received (%x)\n", __func__, replyId);
                    retVal = IPC_QueueAsyncMsg(HIPC_IfcConfig.devId, replyId, (uint8_t *)&resp, replyLen);
                    if (retVal != BCM_ERR_OK) {
                        HOST_Log("%s failed to queue async msg, err:%d\n", __func__, retVal);
                    }
                    /* we have still not received a response to the msg sent */
                    retVal = BCM_ERR_NOT_FOUND;
                } else if (replyId != BCM_ERR_INVAL_MAGIC) {
                    retVal = BCM_ERR_NOSUPPORT;
                }
            }
        } else {
            retVal = HIPC_Send(cmdId, cmdHdl.u8Ptr, 4UL);
            if (retVal != BCM_ERR_OK) {
                HOST_Log("%s Failed to send command, err:%d\n", __func__, retVal);
                goto done;
            }
            retVal = BCM_ERR_NOT_FOUND;
        }
    } while (BCM_ERR_NOT_FOUND == retVal);

done:
    return retVal;
}
#endif

int32_t HIPC_GetTargetSWMode(MgmtInfoType *info, BCM_BootModeType *const targetBootMode, HIPC_TargetFeatureType *const targetFeatures)
{
    int32_t retVal;
    *targetBootMode = 0UL;
    *targetFeatures = 0UL;

#ifdef __BCM8953X__
    /* Ping target device to identify the software mode of target device.
     * HIPC_PingRom - ROM specific Ping
     *   If target device is in ROM mode, it would return
          - BCM_ERR_OK => ROM mode with reboot capability
          - BCM_ERR_UNINIT => ROM mode without reboot capability
          - BCM_ERR_NOSUPPORT => use HIPC_PingInternal to identify
     */
    retVal = HIPC_PingRom(info);
    if (BCM_ERR_OK == retVal) {
        *targetBootMode = SYS_BOOTMODE_BROM;
        *targetFeatures = HIPC_TARGETFEATURE_SELFREBOOT | HIPC_TARGETFEATURE_IMGHDRSIGNATURE;
    } else if (BCM_ERR_UNINIT == retVal) {
        *targetBootMode = SYS_BOOTMODE_BROM;
        *targetFeatures = HIPC_TARGETFEATURE_IMGHDRSIGNATURE;
        retVal = BCM_ERR_OK;
    }
    else
#endif
    {
        retVal = HIPC_PingInternal(info, targetBootMode, targetFeatures, BCM_GROUPID_IMGL);
        if (BCM_ERR_OK == retVal) {
            /* Newer versions of BootROM */
        } else {
            /* FW/Bootloader.. query using SYS Ping */
            retVal = HIPC_PingInternal(info, targetBootMode, targetFeatures, BCM_GROUPID_SYS);
        }
    }

    return retVal;
}

static int32_t HIPC_RebootIssueCommand(MgmtInfoType *info, uint32_t delayMs)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    uint32_t replyLen;
    uint32_t cmdId;

    DMON_RebootMsgType reboot;
    SYS_HandleType cmdHdl;
    cmdHdl.reboot = &reboot;

    RPC_ResponseType resp;

    /* Issue REBOOT command to TARGET */
    cmdHdl.reboot->delayMs = uswap32(delayMs); /* defer */
    cmdId = DMON_ID_REBOOT;

    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr, sizeof(DMON_RebootMsgType),
            (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != MGMT_STATUS_LEN) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    }

done:
    return retVal;
}

int32_t HIPC_Reboot(MgmtInfoType *info)
{
    int32_t retVal;
    HIPC_TargetFeatureType currTargetFeatures = 0UL;
    BCM_BootModeType currTargetBootMode = 0UL;

#ifdef __BCM8953X__
    retVal = HIPC_GetTargetSWMode(info, &currTargetBootMode, &currTargetFeatures);
    if (BCM_ERR_OK != retVal) {
        goto err_done;
    }
#endif

    /* If target can't reboot on it's own, it shall prepare for reboot instead */
    retVal = HIPC_RebootIssueCommand(info, HIPC_TARGET_REBOOT_DELAY_MS);
    if (BCM_ERR_OK != retVal) {
        HOST_Log("%s Failed to Reboot target through IPC command, err:0x%x\n", __func__, retVal);
        goto err_done;
    }

    retVal = HIPC_PlatReboot(HIPC_IfcConfig.devId, currTargetBootMode, currTargetFeatures);
    if (BCM_ERR_OK != retVal) {
        HOST_Log("%s Failed to perform platform specific reboot, err:0x%x\n", __func__, retVal);
    }

err_done:
    return retVal;
}

uint32_t HIPC_IsReady(void)
{
    uint16_t regVal16 = 0;
    uint32_t isReady = FALSE;
    uint16_t prio;

    HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_BUFF_INFO_REG, (uint8_t *)&regVal16, 16UL);
    if ((regVal16 == 0xFFFF)
            || (regVal16 == 0UL) || (HIPC_EvenParity(regVal16) != 0U)) {
        isReady = FALSE;
        goto done;
    }

    HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);

    prio = (regVal16 & IPC_TARGET_STAT_PRI_MASK) >> IPC_TARGET_STAT_PRI_SHIFT;
    if ((prio == IPC_TARGET_STAT_PRI_REBOOT)
        || (prio == IPC_TARGET_STAT_PRI_PAUSE)) {
        isReady = FALSE;
    } else {
        isReady = TRUE;
    }

done:
    return isReady;
}

uint32_t HIPC_IsTargetReady()
{
    uint32_t isReady = FALSE;
    uint16_t reg16 = 0;
    int32_t retVal;

    if (TRUE == HIPC_IsReady()) {
        retVal = HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_BL_DWNLD_TARGET_SPARE_REG, (uint8_t *)&reg16, 16UL);
        if (retVal) {
            goto done;
        }
        if ((reg16 & BL_IPC_DWNLD_BL_READY_MASK) == BL_IPC_DWNLD_BL_READY_MASK) {
            isReady = TRUE;
        }
    }
done:
    return isReady;
}

static void HIPC_ProgressLog(const uint32_t skipTimeIntervalCheck)
{
    static uint32_t firstCall = 1U; /* Ugh!! */
    static struct timeval lastLogTime;
    static uint32_t lastLogPercent = 0UL;

    struct timeval curTime;
    struct timeval elapsedTime;

    if (1U == firstCall) {
        gettimeofday(&lastLogTime, NULL);
        firstCall = 0U;
    }

    gettimeofday(&curTime, NULL);
    timersub(&curTime, &lastLogTime, &elapsedTime);

    if ((0U != skipTimeIntervalCheck) || (elapsedTime.tv_sec > 0) || (elapsedTime.tv_usec > 100000)) { /* 100ms */

        uint16_t target_reg = 0U;
        HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_BL_DWNLD_TARGET_SPARE_REG, (uint8_t *)&target_reg, 16UL);

        if (HIPC_IsTargetReady() == TRUE) {
            uint16_t percent =
                (target_reg & BL_IPC_DWNLD_FLASHING_PERCENT_MASK) >>
                    BL_IPC_DWNLD_FLASHING_PERCENT_SHIFT;

            if ((percent / 10) != (lastLogPercent / 10)) {
                HOST_Log("\n");
            }
            HOST_Log("\r%03u%%", percent);

            fflush(stdout);
            lastLogPercent = percent;
        }

        lastLogTime = curTime;
    }

    return;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible.
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t HIPC_Read32Bulk(uint8_t *buf, uint32_t addr, uint32_t len)
{
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        HOST_Log("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    retVal = HIPC_BusXferBulkRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_INDIRECT, addr, buf, len);

done:
    return retVal;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t HIPC_Write32Bulk(uint32_t addr, uint8_t *buf, uint32_t len)
{
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        HOST_Log("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    retVal = HIPC_BusXferBulkWrite(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_INDIRECT, addr, buf, len);
done:
    return retVal;
}

uint16_t HIPC_EvenParity(uint16_t val)
{
    uint16_t par = 0U;
    uint16_t i = sizeof(val) * 8U;

    while (i--) {
        par ^= ((val >> i) & 0x1U);
    }
    return par;
}

static uint32_t HIPC_GetChksum(uint32_t magic, uint32_t cmd, uint32_t *msg, uint32_t msglen, uint32_t len)
{
    uint32_t i;
    uint32_t chksum = 0UL;
    for (i = 0UL; i < ((msglen >> 2UL) - IPC_HDR_LAST_INDEX); i++) {
        chksum += uswap32(msg[i]);
    }
    chksum += magic;
    chksum += len;
    chksum += cmd;
    return (~chksum) + 1UL;
}

int32_t HIPC_Send(uint32_t cmd, uint8_t *msg, uint32_t len)
{
    int32_t retVal;
    uint16_t regVal16;
    uint16_t wPtr;
    uint16_t rPtr;
    uint8_t *ipcBuff;
    uint16_t ipcMsgCnt;
    uint16_t ipcMsgSz;
    uint8_t cntRollOverMask;
    uint16_t prio;
    uint32_t idx;
    uint32_t buffer[128];

    if ((sizeof(buffer) - IPC_MSG_HDR_SIZE)
            < len) {
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }

    retVal = HIPC_PlatGetBuff(HIPC_IfcConfig.devId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /*HOST_Log("IPC Buffer is not yet initialised(%d)\n", retVal);*/
        goto done;
    }
    if ((ipcMsgSz - IPC_MSG_HDR_SIZE) < len) {
        HOST_Log("IPC Buffer is not sufficient\n");
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }

    HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);

    prio = (regVal16 & IPC_TARGET_STAT_PRI_MASK) >> IPC_TARGET_STAT_PRI_SHIFT;
    if (prio == IPC_TARGET_STAT_PRI_REBOOT){
        retVal = BCM_ERR_NODEV;
    } else if (prio == IPC_TARGET_STAT_PRI_PAUSE) {
        retVal = BCM_ERR_BUSY;
    } else {
        /* Get pointers */
        rPtr = (regVal16 & IPC_TARGET_STAT_RD_MASK) >> IPC_TARGET_STAT_RD_SHIFT;

        HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
        wPtr = (regVal16 & IPC_HOST_STAT_WR_MASK) >> IPC_HOST_STAT_WR_SHIFT;
        /* Retain regVal16 for further use */

        /* Check if feasible */
        if (((rPtr + ipcMsgCnt) & IPC_MAX_PTR_MASK) != wPtr) {

            /* The HIPC_Write32Bulk API expects the transfer length to be aligned to 32 bytes */
            const uint32_t transferSize = (len + IPC_MSG_HDR_SIZE + 31U) & (~(31U));

            idx = (wPtr & (ipcMsgCnt - 1));
            memset(buffer, 0, sizeof(buffer));
            memcpy(&buffer[IPC_HDR_LAST_INDEX], msg, len);
            buffer[IPC_HDR_MAGIC_INDEX] = IPC_COMMAND_MAGIC;
            buffer[IPC_HDR_CHKSUM_INDEX] =
                uswap32(HIPC_GetChksum(IPC_COMMAND_MAGIC, cmd,
                        &buffer[IPC_HDR_LAST_INDEX],
                        len + IPC_MSG_HDR_SIZE, len));
            buffer[IPC_HDR_COMMAND_INDEX] = uswap32(cmd);
            buffer[IPC_HDR_LENGTH_INDEX] = uswap32(len);

            /* Memcpy */
            retVal = HIPC_Write32Bulk((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz],
                    (uint8_t*)buffer,
                    transferSize);
            if (retVal != BCM_ERR_OK) {
                retVal = BCM_ERR_UNKNOWN;
                goto done;
            }

            /* Increment write pointer */
            wPtr++;
            wPtr &= cntRollOverMask;

            /* Update HOST register */
            regVal16 &= ~IPC_HOST_STAT_WR_MASK;
            regVal16 |= ((wPtr << IPC_HOST_STAT_WR_SHIFT) & IPC_HOST_STAT_WR_MASK);
            HIPC_BusXferWrite(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

            HIPC_PlatNotifyTarget(HIPC_IfcConfig.devId);
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }

done:
    return retVal;
}

int32_t HIPC_Recv(uint32_t *cmd, uint8_t *msg, uint32_t len_max, uint32_t *len)
{
    int32_t retVal;
    uint16_t regVal16;
    uint16_t wPtr;
    uint16_t rPtr;
    uint8_t *ipcBuff;
    uint16_t ipcMsgCnt;
    uint16_t ipcMsgSz;
    uint8_t cntRollOverMask;
    uint32_t idx;
    uint32_t header[IPC_HDR_LAST_INDEX];
    uint32_t chksum;

    retVal = HIPC_PlatGetBuff(HIPC_IfcConfig.devId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /* HOST_Log("IPC Buffer is not yet initialised\n"); */
        goto done;
    }

    HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);
    wPtr = (regVal16 & IPC_TARGET_STAT_WR_MASK) >> IPC_TARGET_STAT_WR_SHIFT;

    HIPC_BusXferRead(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
    rPtr = (regVal16 & IPC_HOST_STAT_RD_MASK) >> IPC_HOST_STAT_RD_SHIFT;
    /* Retain regVal16 for further use */

    /* Check if there is a new message */
    if (rPtr != wPtr) {
        idx = (rPtr & (ipcMsgCnt - 1)) + ipcMsgCnt;

        /* Memcpy */
        retVal = HIPC_Read32Bulk((uint8_t*)header, (uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz], sizeof(header));
        if (retVal != BCM_ERR_OK) {
            retVal = BCM_ERR_UNKNOWN;
        }
        else {
            *cmd = uswap32(header[IPC_HDR_COMMAND_INDEX]);
            *len = uswap32(header[IPC_HDR_LENGTH_INDEX]);

            if (*len <= (ipcMsgSz - sizeof(header))) {
                retVal = HIPC_Read32Bulk(msg, ((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz]) + sizeof(header), *len);
                if (retVal != BCM_ERR_OK) {
                    retVal = BCM_ERR_UNKNOWN;
                }
                else {
                    chksum = HIPC_GetChksum(uswap32(header[IPC_HDR_MAGIC_INDEX]),
                            uswap32(header[IPC_HDR_COMMAND_INDEX]),
                            (uint32_t*)msg, *len + sizeof(header), *len);
                    if (IPC_REPLY_MAGIC != uswap32(header[IPC_HDR_MAGIC_INDEX])) {
                        retVal = BCM_ERR_DATA_INTEG;
                        HOST_Log("IPC: Invalid Magic\n");
                    } else if (chksum != uswap32(header[IPC_HDR_CHKSUM_INDEX])) {
                        retVal = BCM_ERR_DATA_INTEG;
                        HOST_Log("IPC: Failed to validate chksum\n");
                    } else {
                        retVal = BCM_ERR_OK;
                    }
                }
            } else {
                HOST_Log("IPC Receive: incorrect length %u\n", *len);
                retVal = BCM_ERR_NOMEM;
            }
        }
        /* Increment read pointer */
        rPtr++;
        rPtr &= cntRollOverMask;

        /* Update HOST register */
        regVal16 &= ~IPC_HOST_STAT_RD_MASK;
        regVal16 |= ((rPtr << IPC_HOST_STAT_RD_SHIFT) & IPC_HOST_STAT_RD_MASK);
        HIPC_BusXferWrite(HIPC_IfcConfig.devId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

        HIPC_PlatNotifyTarget(HIPC_IfcConfig.devId);
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

done:
    return retVal;
}

int32_t HIPC_SendRecv(uint32_t id, uint8_t *cmd, uint32_t cmd_len,
            uint8_t *reply, uint32_t reply_len_max, uint32_t *reply_len_act)
{
    int32_t retVal;
    uint32_t reply_id = 0;
    struct timeval startTime;
    struct timeval curTime;
    struct timeval elapsedTime;

    const uint32_t logProgress = (id == IMGL_ID_UPDATE_AUTO_SYNC);

    retVal = HIPC_Send(id, cmd, cmd_len);
    if (retVal != BCM_ERR_OK) {
        HOST_Log("%s: Failed to send command id:0x%x, err:%d\n",
                __func__, id, retVal);
        goto done;
    }
    gettimeofday(&startTime, NULL);

    do {
        /* Check for response */
        retVal = HIPC_FindResponse(id, reply, reply_len_max, reply_len_act);
        if (BCM_ERR_OK != retVal) {
            retVal = HIPC_Recv(&reply_id, reply, reply_len_max, reply_len_act);
            if (retVal == BCM_ERR_OK) {
                if (reply_id != id) {
                    if (0UL != (reply_id & RPC_CMD_ASYNC_MASK)) {
                        retVal = IPC_QueueAsyncMsg(HIPC_IfcConfig.devId, reply_id, reply, *reply_len_act);
                        if (retVal != BCM_ERR_OK) {
                            HOST_Log("%s failed to queue async msg, err:%d\n", __func__, retVal);
                        }
                    } else {
                        retVal = HIPC_AddResonse(reply_id, reply, *reply_len_act);
                        if (retVal != BCM_ERR_OK) {
                            HOST_Log("%s failed to add response to queue, err:%d\n", __func__, retVal);
                        } else {
                            HOST_Log("Added Response to queue\n");
                        }
                    }
                    /* we have still not received a response to the msg sent */
                    retVal = BCM_ERR_NOT_FOUND;
                }
            }
        }

        if (0U != logProgress) {
            HIPC_ProgressLog(retVal != BCM_ERR_NOT_FOUND);
        }
        gettimeofday(&curTime, NULL);
        timersub(&curTime, &startTime, &elapsedTime);
        if (((id == BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID,RPC_CMDIDVAL_DWNLD_IMG_HDR_V2))
            || (id == BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID,RPC_CMDIDVAL_DWNLD_IMG_V2)))
            && (elapsedTime.tv_usec > 100000)) {
            retVal = BCM_ERR_TIME_OUT;
        }

        if (retVal != BCM_ERR_NOT_FOUND) {
            break;
        }

    } while (retVal != BCM_ERR_OK);

done:
    return retVal;
}

int32_t HIPC_BusXferRead(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    return  HIPC_BusXferReadFunc[HIPC_IfcModeIdx](slaveId, access, addr, data, width);
}

int32_t HIPC_BusXferBulkRead(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t size)
{
    return  HIPC_BusXferBulkReadFunc[HIPC_IfcModeIdx](slaveId, access, addr, data, size);
}

int32_t HIPC_BusXferWrite(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                          uint8_t *data, uint32_t width)
{
    return HIPC_BusXferWriteFunc[HIPC_IfcModeIdx](slaveId, access, addr, data, width);
}

int32_t HIPC_BusXferBulkWrite(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                          uint8_t *data, uint32_t size)
{
    return HIPC_BusXferBulkWriteFunc[HIPC_IfcModeIdx](slaveId, access, addr, data, size);
}

int32_t HIPC_BusInit(void)
{
    return HIPC_BusInitFunc[HIPC_IfcModeIdx](HIPC_IfcConfig.serial,
                                             HIPC_IfcConfig.chip,
                                             HIPC_IfcConfig.devId,
                                             HIPC_InterfaceDefaultClk[HIPC_IfcModeIdx]);
}

int32_t HIPC_BusDeInit(void)
{
    HIPC_BusDeInitFunc[HIPC_IfcModeIdx]();
    return BCM_ERR_OK;
}

int32_t HIPC_Init(void)
{
    int32_t retVal;

    retVal = HIPC_BusInit();
    if (BCM_ERR_OK != retVal) {
        HOST_Log("Could not initialize hipc interface bus\n");
    } else {
        HOST_Log("HIPC_BusInit Succesfull busIdx: %d\n", HIPC_IfcModeIdx);
    }
    return retVal;
}

void HIPC_Deinit(void)
{
    HIPC_BusDeInit();
}

int32_t HIPC_SetConfig(HIPC_IfcConfigType cfg)
{
    int retVal = BCM_ERR_OK;

#ifdef HOST_PROCESSOR_X86
    if (HIPC_INTERFACE_MODE_JLINK == cfg.mode) {
        HIPC_IfcModeIdx = HIPC_INTERFACE_MODE_IDX_JLINK;
#ifdef HOST_ENABLE_PCIE
    } else if (HIPC_INTERFACE_MODE_PCIE == cfg.mode) {
        HIPC_IfcModeIdx = HIPC_INTERFACE_MODE_IDX_PCIE;
#endif /* HOST_ENABLE_PCIE */
    } else {
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }
#else /* HOST_PROCESSOR_X86 */
    if (HIPC_INTERFACE_MODE_SPI == cfg.mode) {
        HIPC_IfcModeIdx = HIPC_INTERFACE_MODE_IDX_SPI;
#ifdef HOST_ENABLE_PCIE
    } else if (HIPC_INTERFACE_MODE_PCIE == cfg.mode) {
        HIPC_IfcModeIdx = HIPC_INTERFACE_MODE_IDX_PCIE;
#endif /* HOST_ENABLE_PCIE */
    } else {
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }
#endif /* HOST_PROCESSOR_X86 */

    if (0xFFFFFFFF != cfg.devId) {
        HIPC_IfcConfig.devId = cfg.devId;
    } else {
        HIPC_IfcConfig.devId = HIPC_InterfaceDefaultId[HIPC_IfcModeIdx];
    }

    if (0UL != cfg.serial) {
        HIPC_IfcConfig.serial = cfg.serial;
    } else {
        HIPC_IfcConfig.serial = 0UL;
    }

    HIPC_IfcConfig.chip = cfg.chip;

done:
    return retVal;
}

void HIPC_ProbeSlaves()
{

}

int32_t HIPC_GetSlave(uint32_t *id)
{
    int32_t retVal;
    if (NULL == id) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *id = HIPC_IfcConfig.devId;
        retVal = BCM_ERR_OK;
    }
    return retVal;
}

int32_t HIPC_SetSlave(uint32_t id)
{
    int32_t retVal;
    if ((id >= SPI_ID_MIN) && (id <= SPI_ID_MAX)) {
        HIPC_IfcConfig.devId = id;
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    return retVal;
}

int32_t HIPC_GetActiveSlaves(uint32_t *id, uint32_t *count)
{
    int32_t retVal;
    int32_t i = 0;
    uint32_t actual;

    if ((NULL != id) && (NULL != count)) {
        for (i = 0, actual = 0; (i < *count) && (i < SPI_SLAVES_MAX); i++) {
            if (SPI_ID_INVAL == ActiveSpiId[i]) {
                break;
            }
            id[i] = ActiveSpiId[i];
            actual += 1;
        }

        /* Invalidate remaining IDs*/
        while (i < *count) {
            id[i++] = SPI_ID_INVAL;
        }

        *count = actual;
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    return retVal;
}

int32_t HIPC_IsStacked(void)
{
    int32_t retval = 0;

    if (ActiveSpiId[1] != SPI_ID_INVAL) {
        retval = 1;
    }

    return retval;
}

int32_t HIPC_SetConnMode(mgmt_connection_t mode)
{
    return BCM_ERR_OK;
}

mgmt_connection_t HIPC_GetConnMode(void)
{
    return MGMT_NO_CONNECTION;
}

static int32_t HIPC_TransferBl(const uint8_t* image, uint32_t len, uint32_t signatureSz)
{
    int32_t retVal;
    uint32_t recv_len;
    uint32_t cmdId;
    uint32_t i, itr, offset, cpy_sz;
    uint32_t len_loc = len - signatureSz;
    const uint8_t *image_loc = &image[signatureSz];
    BL_DWNLD_ImgHdrType *imgHdrPtr = (BL_DWNLD_ImgHdrType *)snd_msg;

    if (len <= signatureSz) {
        HOST_Log("%s: Invalid length:%u signatureSz:%u\n", len, signatureSz);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    memset(snd_msg, 0, MSG_BUF_SIZE);
    memset(recv_msg, 0, MSG_BUF_SIZE);

    /* Send Download header */
    cmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1);

    imgHdrPtr->magicNum = uswap32(0x494D4748UL);
    imgHdrPtr->imgSize = uswap32(len_loc);
    imgHdrPtr->flags = uswap32(BL_DWNLD_FLAG_EDC_CRC);
    imgHdrPtr->errDetCode = uswap64(BCM_CRC32(image_loc, len_loc, CRC32_POLY));

    /* Copy BL signature after header */
    if (signatureSz > 0UL) {
        memcpy(&snd_msg[sizeof(BL_DWNLD_ImgHdrType)], image, signatureSz);
    }

    retVal = HIPC_PlatSendRecvRom(cmdId, snd_msg,
            sizeof(BL_DWNLD_ImgHdrType) + signatureSz, recv_msg,
            MSG_BUF_SIZE, &recv_len);

    if (retVal != BCM_ERR_OK) {
        goto done;
    }

    itr = (len_loc / MSG_BUF_SIZE);
    if (0UL != (len_loc%MSG_BUF_SIZE)) {
        itr++;
    }

    offset = 0UL;
    for (i = 0UL; i < itr; i++) {
        memset(snd_msg, 0, MSG_BUF_SIZE);
        memset(recv_msg, 0, MSG_BUF_SIZE);

        cmdId = BCM_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1);
        /* copy image chunk */
        cpy_sz = len_loc - offset;
        if (cpy_sz > MSG_BUF_SIZE) {
            cpy_sz = MSG_BUF_SIZE;
        }
        memcpy(snd_msg, &image_loc[offset], cpy_sz);

        retVal = HIPC_PlatSendRecvRom(cmdId, snd_msg,
                cpy_sz, recv_msg, MSG_BUF_SIZE, &recv_len);
        if (retVal != BCM_ERR_OK) {
            goto done;
        }

        offset += cpy_sz;
    }

done:
    return retVal;
}

int32_t HIPC_ExecuteOnTarget(MgmtInfoType *info, HIPC_InstallType mode, const uint8_t* tarImage)
{
    int32_t retVal;
    HIPC_TargetFeatureType currTargetFeatures;
    BCM_BootModeType currTargetBootMode;
    volatile uint32_t isReady = FALSE;
    const uint8_t *image;
    uint32_t size = 0;
    uint32_t offset = 0;
    uint32_t signatureSz;

    /* Get the bootloader */
    retVal = HOST_ImglGetImg(&offset, &size, 1UL, 2UL);
    if ((retVal == -1) || (size == 0) || (offset == 0)) {
        HOST_Log("failed to get bootloader\n");
        goto err_GetSWMode;
    }

    image = &tarImage[offset];

    retVal = HIPC_GetTargetSWMode(info, &currTargetBootMode, &currTargetFeatures);
    if (BCM_ERR_OK != retVal) {
        goto err_GetSWMode;
    }

    if (0UL == (currTargetFeatures & HIPC_TARGETFEATURE_SELFREBOOT)) {
        /* Try pushing the updater/bootloader to TCM directly */
        retVal = HIPC_PlatExecuteOnTarget(HIPC_IfcConfig.devId, image, size);
    } else {
        if (0UL != (currTargetFeatures & HIPC_TARGETFEATURE_IMGHDRSIGNATURE)) {
            signatureSz = BL_IMG_SIGNATURE_SIZE;
        } else {
            signatureSz = 0UL;
        }
        /* Push the updater/bootloader through IPC */
        retVal = HIPC_TransferBl(image,size, signatureSz);
    }

    if (BCM_ERR_OK == retVal) {
        do {
            isReady = HIPC_IsTargetReady();
        } while (TRUE != isReady);
    }

err_GetSWMode:
    return retVal;
}

void HIPC_GenerateFrameSyncPulse(void)
{
#ifndef HOST_PROCESSOR_X86
    GPIO_Set(GPIO_SYNC_OUT, GPIO_LEVEL_HIGH);
    GPIO_Set(GPIO_SYNC_OUT, GPIO_LEVEL_LOW);
#endif
}
