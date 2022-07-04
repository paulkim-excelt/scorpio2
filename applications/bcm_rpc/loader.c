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

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <string.h>
#include <hlog.h>
#include <errno.h>
#include <bcm_utils.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <ipc.h>
#include <ipc_hwif.h>
#include "bus_xfer.h"
#include "spi.h"
#include "spi_xfer.h"
#include <bcm_err.h>
#include "bl_downloader.h"
#include "bl_ipc_downloader.h"
#include "bl_chip_config.h"
#include "mcu.h"
#include "bcm_utils.h"
#include <rpc_cmds.h>
#include <hipc_plat.h>
#include <gpio.h>
#include <crc.h>
#include <hlog.h>
#include <rpc_cmds.h>
#include <sys_ipc_cmds.h>
#include <rpc_ipc_common.h>

#ifdef HIPC_ENABLE_PCIE
#include "pcie_xfer.h"
#endif

#define SPI_SPEED                   (12500000) /* Minimum 80ns as per DS */
#define USEC_PER_MSEC               (1000)

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

#define TAR_HEADER_NAME_OFFSET  (0UL)
#define TAR_HEADER_NAME_LENGTH  (100UL)
#define TAR_HEADER_SIZE_OFFSET  (124UL)
#define TAR_HEADER_SIZE_LENGTH  (12UL)
#define TAR_HEADER_MAGIC_OFFSET  (257UL)
#define TAR_HEADER_MAGIC_LENGTH  (6UL)

#define TAR_HEADER_SIZE (512UL)


#include <stdint.h>
#include <endian.h>
#include <byteswap.h>
#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
#define uswap16(x)              bswap_16(x)
#define uswap32(x)              bswap_32(x)
#define uswap64(x)              bswap_64(x)
#elif __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define uswap16(x)              (x)
#define uswap32(x)              (x)
#define uswap64(x)              (x)
#else
#error "__BYTE_ORDER__ has to be either __ORDER_BIG_ENDIAN__ or __ORDER_LITTLE_ENDIAN__"
#endif


static uint8_t send_msg_buf[MSG_BUF_SIZE];
static uint8_t *snd_msg = send_msg_buf;
static uint8_t recv_msg_buf[MSG_BUF_SIZE];
static uint8_t *recv_msg = recv_msg_buf;

/**
    @name Connection
    @{
    @brief Connection type
*/
typedef uint32_t mgmt_connection_t;     /**< @brief Connection Type */
#define MGMT_NO_CONNECTION      (0x00000001UL)  /**< @brief No Connection */
#define MGMT_SPI_CONNECTION     (0x00000002UL)  /**< @brief SPI Connection */
#define MGMT_PCIE_CONNECTION    (0x00000003UL)  /**< @brief PCIE connection */
/** @} */

#if defined(HIPC_ENABLE_SPI)
static mgmt_connection_t CurrentMode = MGMT_SPI_CONNECTION;
#elif defined(HIPC_ENABLE_PCIE)
static mgmt_connection_t CurrentMode = MGMT_PCIE_CONNECTION
#else
static mgmt_connection_t CurrentMode = MGMT_NO_CONNECTION;
#endif
/* SPI Driver will use this for all transactions */
static uint32_t CurrentSpiId = SPI_ID_DEFAULT;

#ifdef HIPC_ENABLE_PCIE
static uint32_t PCIESlavePresent = 0UL;
#endif
MCU_VersionType HIPC_McuVersion;

/* All IDs which have been probed during start-up gets registered here */
static uint32_t ActiveSpiId[SPI_SLAVES_MAX];

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

static uint16_t tar_get_pid(const uint8_t *const hdr)
{
    uint32_t i;
    uint16_t pid = 0UL;
    for (i = TAR_HEADER_NAME_OFFSET + 33UL; i < (TAR_HEADER_NAME_OFFSET + 33UL + 2UL); i++) {
        pid = pid * 16UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            pid += hdr[i] - '0';
        } else if ((hdr[i] >= 'A') && (hdr[i] <= 'F')) {
            pid += hdr[i] - 'A' + 10;
        }
    }
    return pid;
}

static uint16_t tar_get_img_id(const uint8_t *const hdr)
{
    uint32_t i;
    uint16_t imgID = 0UL;
    for (i = (TAR_HEADER_NAME_OFFSET + 35UL); i < (TAR_HEADER_NAME_OFFSET + 35UL + 4UL); i++) {
        imgID = imgID * 16UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            imgID += hdr[i] - '0';
        } else if ((hdr[i] >= 'A') && (hdr[i] <= 'F')) {
            imgID += hdr[i] - 'A' + 10;
        }
    }
    return imgID;
}

static uint32_t tar_is_img_hdr(const uint8_t *const hdr)
{
    uint32_t isImgHdr = TRUE;

    if (hdr[TAR_HEADER_NAME_OFFSET + 32UL] == '0') {
        isImgHdr = FALSE;
    }
    return isImgHdr;
}

static uint32_t tar_get_file_size(const uint8_t *const hdr)
{
    uint32_t i;
    uint32_t size = 0UL;
    for (i = TAR_HEADER_SIZE_OFFSET; i < (TAR_HEADER_SIZE_OFFSET + TAR_HEADER_SIZE_LENGTH - 1UL); i++) {
        size = size * 8UL;
        if ((hdr[i] >= '0') && (hdr[i] <= '9')) {
            size += hdr[i] - '0';
        }
    }
    return size;
}

static uint32_t tar_check_header(const uint8_t *const hdr)
{
    if ((hdr[TAR_HEADER_MAGIC_OFFSET] == 'u')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 1UL] == 's')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 2UL] == 't')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 3UL] == 'a')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 4UL] == 'r')
        && (hdr[TAR_HEADER_MAGIC_OFFSET + 5UL] == ' ')) {
            return TRUE;
    } else {
        return FALSE;
    }
}


void * buffer_from_file(char *name, uint32_t *len)
{
    FILE *fp;
    uint32_t read_len;
    void *buffer;
    fp = fopen(name, "r");
    if (!fp) {
        HOST_Log("could not open %s\n", name);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_END) < 0) {
        HOST_Log("error seeking to end of %s\n", name);
        fclose(fp);
        return NULL;
    }

    *len = ftell(fp);
    if(*len < 0 ) {
        HOST_Log("error in getting the current position\n");
        fclose(fp);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_SET) < 0) {
        HOST_Log("error seeking to beginning of %s\n", name);
        fclose(fp);
        return NULL;
    }

    buffer = malloc(*len);
    if (!buffer) {
        HOST_Log("could not allocate %d bytes\n", *len);
        fclose(fp);
        return NULL;
    }

    read_len = fread(buffer, 1, *len, fp);
    fclose(fp);
    if (read_len != *len) {
        HOST_Log("error reading %s\n", name);
        free(buffer);
        return NULL;
    }

    return buffer;
}


int32_t HIPC_BusXferRead(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (CurrentMode == MGMT_SPI_CONNECTION) {
#if defined(HIPC_ENABLE_SPI)
        retVal = SPI_XferRead(CurrentSpiId, access, addr, data, width);
#endif
#if defined(HIPC_ENABLE_PCIE)
    } else if (CurrentMode == MGMT_PCIE_CONNECTION) {
        retVal = PCIE_XferRead(0UL, access, addr, data, width);
#endif
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
        HOST_Log("HIPC_BusXferRead: invalid bus mode\n");
    }
    return retVal;
}

int32_t HIPC_BusXferWrite(uint32_t slaveId, HIPC_BusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_OK;

    if (CurrentMode == MGMT_SPI_CONNECTION) {
#if defined(HIPC_ENABLE_SPI)
        retVal = SPI_XferWrite(CurrentSpiId, access, addr, data, width);
#endif
#if defined(HIPC_ENABLE_PCIE)
    } else if (CurrentMode == MGMT_PCIE_CONNECTION) {
        retVal = PCIE_XferWrite(0UL, access, addr, data, width);
#endif
    } else {
        retVal = BCM_ERR_INVAL_PARAMS;
        HOST_Log("HIPC_BusXferWrite: invalid bus mode\n");
    }
    return retVal;
}


/* In multiples of 32bit and assumes that buf[] is so aligned & accessible.
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t SPI_Read32Bulk(uint8_t *buf, uint32_t addr, uint32_t len)
{
    uint32_t data;
    int i;
    int end = addr + len;
    uint8_t *dst = buf;
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        HOST_Log("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    for (i = addr; i < end; i = i + sizeof(uint32_t)) {
        HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_INDIRECT, i, (uint8_t *)&data, 32UL);

        /* store in Little Endian format */
        dst[3] = (uint8_t)((data >> 24UL) & 0xFF);
        dst[2] = (uint8_t)((data >> 16UL) & 0xFF);
        dst[1] = (uint8_t)((data >>  8UL) & 0xFF);
        dst[0] = (uint8_t)(data & 0xFF);

        dst += 4UL;
    }

done:
    return retVal;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t SPI_Write32Bulk(uint32_t addr, uint8_t *buf, uint32_t len)
{
    int i;
    int end = addr + len;
    uint32_t data;
    uint8_t *src = buf;
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        HOST_Log("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    for (i = addr; i < end; ) {
        /* Retrieve in Little Endian format */
        data =    ((uint32_t)src[3] << 24UL)
                | ((uint32_t)src[2] << 16UL)
                | ((uint32_t)src[1] <<  8UL)
                | src[0];

        HIPC_BusXferWrite(CurrentSpiId, HIPC_BUS_ACCESS_INDIRECT, i, (uint8_t *)&data, 32UL);
        src += 4UL;
        i += 4UL;
    }
done:
    return retVal;
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

    retVal = HIPC_PlatGetBuff(CurrentSpiId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /*HOST_Log("IPC Buffer is not yet initialised(%d)\n", retVal);*/
        goto done;
    }
    if ((ipcMsgSz - IPC_MSG_HDR_SIZE) < len) {
        HOST_Log("IPC Buffer is not sufficient\n");
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);

    prio = (regVal16 & IPC_TARGET_STAT_PRI_MASK) >> IPC_TARGET_STAT_PRI_SHIFT;
    if (prio == IPC_TARGET_STAT_PRI_REBOOT){
        retVal = BCM_ERR_NODEV;
    } else if (prio == IPC_TARGET_STAT_PRI_PAUSE) {
        retVal = BCM_ERR_BUSY;
    } else {
        /* Get pointers */
        rPtr = (regVal16 & IPC_TARGET_STAT_RD_MASK) >> IPC_TARGET_STAT_RD_SHIFT;

        HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
        wPtr = (regVal16 & IPC_HOST_STAT_WR_MASK) >> IPC_HOST_STAT_WR_SHIFT;
        /* Retain regVal16 for further use */

        /* Check if feasible */
        if (((rPtr + ipcMsgCnt) & IPC_MAX_PTR_MASK) != wPtr) {

            /* The SPI_Write32Bulk API expects the transfer length to be aligned to 32 bytes */
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
            retVal = SPI_Write32Bulk((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz],
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
            HIPC_BusXferWrite(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

            HIPC_PlatNotifyTarget(CurrentSpiId);
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

    retVal = HIPC_PlatGetBuff(CurrentSpiId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /* HOST_Log("IPC Buffer is not yet initialised\n"); */
        goto done;
    }

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);
    wPtr = (regVal16 & IPC_TARGET_STAT_WR_MASK) >> IPC_TARGET_STAT_WR_SHIFT;

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
    rPtr = (regVal16 & IPC_HOST_STAT_RD_MASK) >> IPC_HOST_STAT_RD_SHIFT;
    /* Retain regVal16 for further use */

    /* Check if there is a new message */
    if (rPtr != wPtr) {
        idx = (rPtr & (ipcMsgCnt - 1)) + ipcMsgCnt;

        /* Memcpy */
        retVal = SPI_Read32Bulk((uint8_t*)header, (uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz], sizeof(header));
        if (retVal != BCM_ERR_OK) {
            retVal = BCM_ERR_UNKNOWN;
        }
        else {
            *cmd = uswap32(header[IPC_HDR_COMMAND_INDEX]);
            *len = uswap32(header[IPC_HDR_LENGTH_INDEX]);

            if (*len <= (ipcMsgSz - sizeof(header))) {
                retVal = SPI_Read32Bulk(msg, ((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz]) + sizeof(header), *len);
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
        HIPC_BusXferWrite(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

        HIPC_PlatNotifyTarget(CurrentSpiId);
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

    retVal = HIPC_Send(id, cmd, cmd_len);
    if (retVal != BCM_ERR_OK) {
        HOST_Log("%s: Failed to send command id:0x%x, err:%d\n",
                __func__, id, retVal);
        goto done;
    }

    do {
        retVal = HIPC_Recv(&reply_id, reply, reply_len_max, reply_len_act);
        if (retVal == BCM_ERR_OK) {
            if (reply_id != id) {
                printf("Dropping async message id:0x%x\n", reply_id);
                /* we have still not received a response to the msg sent */
                retVal = BCM_ERR_NOT_FOUND;
            } else {
                /* found response */
                break;
            }
        }
    } while (retVal != BCM_ERR_OK);

done:
    return retVal;
}

static int32_t HIPC_PingInternal(uint32_t *const mode, uint32_t * const targetFeatures, uint8_t aGroupId)
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

    if ((NULL == mode) || (NULL == targetFeatures)) {
        HOST_Log("%s :: Invalid input parameter mode:%p targetFeatures:%p\n",
            __FUNCTION__, mode, targetFeatures);
        goto done;
    }

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = RPC_CMDID(aGroupId, BCM_RSV_ID, SYS_CMDID_PING);
    retVal = HIPC_SendRecv(cmdId, cmdHdl.u8Ptr,
            0UL, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);

    if (retVal != BCM_ERR_OK) {
        goto done;
    } else if (uswap32(resp.status) != BCM_ERR_OK) {
        HOST_Log("%s status:%d\n", __func__, uswap32(resp.status));
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    } else if (replyLen != (MGMT_STATUS_LEN + sizeof(SYS_PingType))) {
        HOST_Log("%s len:0x%x\n", __func__, replyLen);
        retVal = BCM_ERR_DATA_INTEG;
        goto done;
    } else {
        *mode = uswap32(respHdl.ping->mode);
        HIPC_McuVersion.manuf = uswap32(respHdl.ping->version.manuf);
        HIPC_McuVersion.model = uswap32(respHdl.ping->version.model);
        HIPC_McuVersion.rev = uswap32(respHdl.ping->version.rev);
        HIPC_McuVersion.securityMode = uswap32(respHdl.ping->version.securityMode);

        retVal = HIPC_PlatGetTargetFeature(&HIPC_McuVersion, targetFeatures);
        if (retVal != BCM_ERR_OK) {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

done:
    return retVal;
}


#ifdef __BCM8953X__
static int32_t HIPC_PingRom()
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

    memset(cmdHdl.u8Ptr, 0, RPC_CMDPAYLOADSZ);
    memset(respHdl.u8Ptr, 0, RPC_RESPPAYLOADSZ);

    cmdId = RPC_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_PING);

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
        retVal = HIPC_Recv(&replyId, (uint8_t *)&resp, RPC_CMDPAYLOADSZ, &replyLen);
        if (retVal == BCM_ERR_OK) {
            if (RPC_CMD_ASYNC_MASK == (RPC_CMD_ASYNC_MASK & replyId)) {
                HOST_Log("%s Async msg dropped (%x)\n", __func__, replyId);
                /* we have still not received a response to the msg sent */
                retVal = BCM_ERR_NOT_FOUND;
            } else if (replyId != BCM_ERR_INVAL_MAGIC) {
                retVal = BCM_ERR_NOSUPPORT;
            } else {
                /* retVal  will be BCM_ERR_OK */
            }
        }

    } while (BCM_ERR_NOT_FOUND == retVal);

done:
    return retVal;
}
#endif

int32_t HIPC_GetTargetSWMode(SYS_BootModeType *const targetBootMode, HIPC_TargetFeatureType *const targetFeatures)
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
    retVal = HIPC_PingRom();
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
        retVal = HIPC_PingInternal(targetBootMode, targetFeatures, BCM_GROUPID_IMGL);
        if (BCM_ERR_OK == retVal) {
            /* Newer versions of BootROM */
        } else {
            /* FW/Bootloader.. query using SYS Ping */
            retVal = HIPC_PingInternal(targetBootMode, targetFeatures, BCM_GROUPID_SYS);
        }
    }

    printf("%s Mode:0x%x features:0x%x ret:%d\n", __func__, *targetBootMode, *targetFeatures, retVal);

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


int32_t HIPC_BusInit(void)
{
    int32_t retVal = BCM_ERR_OK;

#ifdef HIPC_ENABLE_SPI
    /* Initialise GPIO before SPI */
    retVal = GPIO_Init();
    if (BCM_ERR_OK == retVal) {
        retVal = SPI_Init(0UL, SPI_SPEED);
    } else {
        HOST_Log("Could not initialize GPIO interface\n");
    }
#endif
#ifdef HIPC_ENABLE_PCIE
    /* when target is not flashed, PCIE can not be enumarated
     * so we just print error log here but let the server
     * initialize with SPI
     */
    retVal = PCIE_Init(0UL, 0xFFFFFFFUL);
    if (BCM_ERR_OK != retVal) {
        HOST_Log("Could not initialize PCIE bus\n");
        retVal = BCM_ERR_OK;
    }
#endif
    return retVal;
}

int32_t HIPC_BusDeInit(void)
{
#ifdef HIPC_ENABLE_SPI
    GPIO_Deinit();
    SPI_Deinit();
#endif
#ifdef HIPC_ENABLE_PCIE
    PCIE_DeInit(0UL);
#endif
    return BCM_ERR_OK;
}

int32_t HIPC_Init(void)
{
    return HIPC_BusInit();
}

void HIPC_Deinit(void)
{
    HIPC_BusDeInit();
}

int32_t HOST_SysInit()
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    /*initialize spi*/
    retVal = HIPC_Init();

    return retVal;
}

int32_t HOST_SysDeinit()
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    HIPC_Deinit();
    retVal = BCM_ERR_OK;

    return retVal;
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
    cmdId = RPC_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_HDR_V1);

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

        cmdId = RPC_CMDID(BCM_GROUPID_IMGL, BCM_RSV_ID, RPC_CMDIDVAL_DWNLD_IMG_V1);
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

static int32_t HOST_ImglGetImg(uint32_t* aOffset, uint32_t* aSize, uint32_t aPid, uint32_t aImgID, const uint8_t* tar, uint32_t size)
{
    uint32_t i = 0UL;
    uint32_t offset = 0UL;
    uint32_t totalSize = 0UL;
    int32_t retVal;

    retVal = BCM_ERR_NOT_FOUND;
    HOST_Log("PID  ImgID   maxSz  ImgHdr\n");
    while ((offset + TAR_HEADER_SIZE < size) && (i < BL_CNTRL_MAX_IMG_COUNT)) {
        uint16_t pid = 0UL;
        uint32_t imageSize = 0UL;
        uint8_t  isImgHdr = FALSE;
        uint32_t imgID;

        if (FALSE == tar_check_header(&tar[offset])) {
            break;
        }

        pid = tar_get_pid(&tar[offset]);
        isImgHdr = tar_is_img_hdr(&tar[offset]);
        imageSize = tar_get_file_size(&tar[offset]);
        totalSize = (TAR_HEADER_SIZE + imageSize + (TAR_HEADER_SIZE - 1UL)) & (~(TAR_HEADER_SIZE - 1UL));

        if (FALSE == isImgHdr) {
            imgID = tar_get_img_id(&tar[offset]);
        } else {
            imgID = 0UL;
        }

        if ((aPid == pid) && (aImgID == imgID)) {
            *aOffset = offset + TAR_HEADER_SIZE;
            *aSize = imageSize;
            retVal = BCM_ERR_OK;
            break;
        }

        HOST_Log("%3d 0x%04x 0x%05x %5d\n", pid, imgID, imageSize, isImgHdr);
        offset += totalSize;
        i++;
    }


    return retVal;
}

static int32_t HIPC_ExecuteOnTarget(const uint8_t* tarImage, uint32_t tarSize)
{
    int32_t retVal;
    HIPC_TargetFeatureType currTargetFeatures;
    SYS_BootModeType currTargetBootMode;
    const uint8_t *image;
    uint32_t size = 0;
    uint32_t offset = 0;
    uint32_t signatureSz;

    /* Get the bootloader */
    retVal = HOST_ImglGetImg(&offset, &size, 1UL, 2UL, tarImage, tarSize);
    if ((BCM_ERR_OK != retVal) || (size == 0) || (offset == 0)) {
        HOST_Log("failed to get bootloader\n");
        goto done;
    }

    image = &tarImage[offset];

    retVal = HIPC_GetTargetSWMode(&currTargetBootMode, &currTargetFeatures);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    if (0UL == (currTargetFeatures & HIPC_TARGETFEATURE_SELFREBOOT)) {
        /* Try pushing the updater/bootloader to TCM directly */
        retVal = HIPC_PlatExecuteOnTarget(CurrentSpiId, image, size);
    } else {
        if (0UL != (currTargetFeatures & HIPC_TARGETFEATURE_IMGHDRSIGNATURE)) {
            signatureSz = BL_IMG_SIGNATURE_SIZE;
        } else {
            signatureSz = 0UL;
        }
        /* Push the updater/bootloader through IPC */
        retVal = HIPC_TransferBl(image,size, signatureSz);
    }

done:
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


int32_t HIPC_ProbeSlaves()
{
    int32_t retVal = -1;
    uint8_t *buff;
    uint16_t cnt, sz;
    uint8_t cntRollOverMask;

#ifdef HIPC_ENABLE_SPI
    uint32_t i;

    for (i = SPI_ID_MIN; i <= SPI_ID_MAX; i++) {
        CurrentSpiId = i;
        retVal = HIPC_PlatGetBuff(i, &buff, &cnt, &cntRollOverMask, &sz);
        if (BCM_ERR_OK == retVal) {
            break;
        }
    }

    if (SPI_ID_MAX < i) {
        HOST_Log("Probe: No active slave ID found, setting default as %d\n", SPI_ID_DEFAULT);
        CurrentSpiId = SPI_ID_DEFAULT;
        retVal = BCM_ERR_OK;
    }
    printf("Probe: ID:%d ret:%d\n", CurrentSpiId, retVal);
#endif

#ifdef HIPC_ENABLE_PCIE
    retVal = HIPC_PlatGetBuff(0UL, &buff, &cnt, &cntRollOverMask, &sz);
    if (BCM_ERR_OK == retVal) {
        PCIESlavePresent = 1UL;
    }
#endif
    return retVal;
}


int main(int argc, char *argv[])
{
    int retVal;
    uint8_t *image;
    uint32_t imgSize;

    if (argc == 2) {
        image = buffer_from_file(argv[1], &imgSize);
        if (image != NULL) {
            /* Initialize Managament API */
            retVal = HOST_SysInit();
            if (retVal != BCM_ERR_OK) {
                HOST_Log("Could not Initilaize management interface\n");
            } else {
                /* Find active slaves */
                retVal = HIPC_ProbeSlaves();
                if (BCM_ERR_OK == retVal) {
                    retVal = HIPC_ExecuteOnTarget(image + 20UL, imgSize - 20UL);
                    if (BCM_ERR_OK != retVal) {
                        printf("Failed to execute, ret:%d\n", retVal);
                    }
                } else {
                    printf("Faile to establish connection to target:%d\n", retVal);
                }
                HOST_SysDeinit();
            }
        }
    } else {
        retVal = -1;
        printf("Usage: ./%s <application.img>", argv[0]);
    }

    return retVal;
}

void BCM_ReportError(uint16_t aCompID,
                     uint8_t aInstanceID,
                     uint16_t aApiID,
                     int32_t aErrorID,
                     uint32_t aNumInts,
                     const uint32_t *const aValues)
{
    printf("Error from comp %x\t apiID %x ret %x val = [%d %d %d %d] \n",aCompID,aApiID,aErrorID,*(aValues),*(aValues+1),*(aValues+2),*(aValues+3));
}
