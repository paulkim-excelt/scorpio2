/*****************************************************************************
 Copyright 2021-2022 Broadcom Limited.  All rights reserved.

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
#include <sys_ipc_cmds.h>
#include <gpio.h>
#include <crc.h>
#include <hlog.h>
#include <rpc_cmds.h>
#include <host_imgl.h>
#include <pcie_xfer.h>

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

/* SPI Driver will use this for all transactions */
static uint32_t CurrentSpiId = SPI_ID_DEFAULT;

#if defined(HIPC_ENABLE_SPI)
static mgmt_connection_t CurrentMode = MGMT_SPI_CONNECTION;
#elif defined(HIPC_ENABLE_PCIE)
static mgmt_connection_t CurrentMode = MGMT_PCIE_CONNECTION;
#else
static mgmt_connection_t CurrentMode = MGMT_NO_CONNECTION;
#endif
MCU_VersionType HIPC_McuVersion;
uint32_t HIPC_McuVersionReady;

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

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);

    prio = (regVal16 & IPC_TARGET_STAT_PRI_MASK) >> IPC_TARGET_STAT_PRI_SHIFT;
    if (prio == IPC_TARGET_STAT_PRI_REBOOT){
        retVal = BCM_ERR_NODEV;
    } else if (prio == IPC_TARGET_STAT_PRI_PAUSE) {
        retVal = BCM_ERR_BUSY;
    } else {
        /* Get pointers */
        rPtr = (regVal16 & IPC_TARGET_STAT_RD_MASK) >> IPC_TARGET_STAT_RD_SHIFT;

        HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
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
            HIPC_BusXferWrite(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

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

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);
    wPtr = (regVal16 & IPC_TARGET_STAT_WR_MASK) >> IPC_TARGET_STAT_WR_SHIFT;

    HIPC_BusXferRead(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
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
        HIPC_BusXferWrite(CurrentSpiId, HIPC_BUS_ACCESS_DIRECT, (uint32_t)(intptr_t)HIPC_IPC_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

        HIPC_PlatNotifyTarget(CurrentSpiId);
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

done:
    return retVal;
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

int32_t HIPC_BusInit(void)
{
    int32_t retVal = BCM_ERR_OK;

#ifdef HIPC_ENABLE_SPI
    /* Initialise GPIO before SPI */
    retVal = GPIO_Init();
    if (BCM_ERR_OK == retVal) {
        retVal = SPI_Init(0UL, 0UL, 0UL, SPI_SPEED);
    } else {
        HOST_Log("Could not initialize GPIO interface\n");
    }
#endif
#ifdef HIPC_ENABLE_PCIE
    /* when target is not flashed, PCIE can not be enumarated
     * so we just print error log here but let the server
     * initialize with SPI
     */
    retVal = PCIE_Init(0UL, 0UL, 0UL, 0xFFFFFFFUL);
    if (BCM_ERR_OK != retVal) {
        HOST_Log("Could not initialize PCIE bus\n");
        retVal = BCM_ERR_OK;
    }
#endif
    return retVal;
}

int32_t HIPC_SendRecv(uint32_t id, uint8_t *cmd, uint32_t cmd_len,
            uint8_t *reply, uint32_t reply_len_max, uint32_t *reply_len_act)
{
    return BCM_ERR_OK;
}
int32_t HIPC_BusDeInit(void)
{
#ifdef HIPC_ENABLE_SPI
    GPIO_Deinit();
    SPI_Deinit();
#endif
#ifdef HIPC_ENABLE_PCIE
    PCIE_DeInit();
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
