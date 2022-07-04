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

#include <stdlib.h>
#include <ipc.h>
#include <rpc_ipc_host.h>
#include <rpc_ipc_bus_xfer.h>
#include <bcm_err.h>
#include "bcm_utils.h"
#include <rpc_ipc_host_plat.h>
#include <rpc_ipc_common.h>
#include <module_msg.h>

#include "rpc_ipc_pcie_xfer.h"
#include "rpc_ipc_jlink_xfer.h"

#define SPI_SPEED                        (12500000) /* Minimum 80ns as per DS */

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
#define SPI_SLAVES_MAX      (3UL)      /* Limited by light-stacking */


#define RPC_IPCHOST_IFC_MODE_IDX_JLINK     (0UL)
#ifdef RPC_IPC_JLINK
#define RPC_IPCHOST_IFC_MODE_IDX_PCIE      (1UL)
#else
#define RPC_IPCHOST_IFC_MODE_IDX_PCIE      (0UL)
#endif


/* HIPC Interface related structure and function pointers */
static uint32_t RPC_IpcHostIfcModeIdx;

static const uint32_t HIPC_InterfaceDefaultClk[] = {
    5000000UL,
    0xFFFFFFFUL,
};

const RPC_IpcBusIfcType *RPC_IpcBusIfcs[] = {
#ifdef RPC_IPC_JLINK
    &RPC_IpcBusJlink,
#endif
#ifdef RPC_IPC_PCIE
    &RPC_IpcBusPcie,
#endif
};

int32_t RPC_IpcBusXferRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                         uint8_t *data, uint32_t width)
{
    return  RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->read(slaveId, access, addr, data, width);
}

int32_t RPC_IpcBusXferWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                          uint8_t *data, uint32_t width)
{
    return RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->write(slaveId, access, addr, data, width);
}

int32_t RPC_IpcBusInit(void)
{
    return RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->init(RPC_IpcHostIfcConfig.serial,
                        RPC_IpcHostIfcConfig.chip,
                        RPC_IpcHostIfcConfig.devId,
                        HIPC_InterfaceDefaultClk[RPC_IpcHostIfcModeIdx]);
}

int32_t RPC_IpcBusDeInit(void)
{
    RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->deinit();
    return BCM_ERR_OK;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible.
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t RPC_IpcRead32Bulk(uint8_t *buf, uint32_t addr, uint32_t len)
{
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        (void)MODULE_HostHelperLog("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->bulkRead(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_INDIRECT, addr, buf, len);

done:
    return retVal;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t RPC_IpcWrite32Bulk(uint32_t addr, uint8_t *buf, uint32_t len)
{
    int32_t retVal = BCM_ERR_OK;

    /* Check if length is a multiple of 4 */
    if (len & 0x3) {
        (void)MODULE_HostHelperLog("%s length is not aligned to 32bits\n", __func__);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    RPC_IpcBusIfcs[RPC_IpcHostIfcModeIdx]->bulkWrite(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_INDIRECT, addr, buf, len);
done:
    return retVal;
}

uint16_t RPC_IpcHostEvenParity(uint16_t val)
{
    uint16_t par = 0U;
    uint16_t i = sizeof(val) * 8U;

    while (i--) {
        par ^= ((val >> i) & 0x1U);
    }
    return par;
}

static uint32_t RPC_IpcHostGetChksum(uint32_t magic, uint32_t cmd, uint32_t *msg, uint32_t msglen, uint32_t len)
{
    uint32_t i;
    uint32_t chksum = 0UL;
    for (i = 0UL; i < ((msglen >> 2UL) - RPC_IPCHOST_HDR_LAST_INDEX); i++) {
        chksum += uswap32(msg[i]);
    }
    chksum += magic;
    chksum += len;
    chksum += cmd;
    return (~chksum) + 1UL;
}

int32_t RPC_IpcHostSend(uint32_t cmd, uint8_t *msg, uint32_t len)
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

    retVal = RPC_IpcHostPlatGetBuff(RPC_IpcHostIfcConfig.devId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /*(void)MODULE_HostHelperLog("IPC Buffer is not yet initialised(%d)\n", retVal);*/
        goto done;
    }
    if ((ipcMsgSz - IPC_MSG_HDR_SIZE) < len) {
        (void)MODULE_HostHelperLog("IPC Buffer is not sufficient\n");
        retVal = BCM_ERR_NOSUPPORT;
        goto done;
    }

    RPC_IpcBusXferRead(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);

    prio = (regVal16 & RPC_IPCHOST_TARGET_STAT_PRI_MASK) >> RPC_IPCHOST_TARGET_STAT_PRI_SHIFT;
    if (prio == RPC_IPCHOST_TARGET_STAT_PRI_REBOOT){
        retVal = BCM_ERR_NODEV;
    } else if (prio == RPC_IPCHOST_TARGET_STAT_PRI_PAUSE) {
        retVal = BCM_ERR_BUSY;
    } else {
        /* Get pointers */
        rPtr = (regVal16 & RPC_IPCHOST_TARGET_STAT_RD_MASK) >> RPC_IPCHOST_TARGET_STAT_RD_SHIFT;

        RPC_IpcBusXferRead(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
        wPtr = (regVal16 & RPC_IPCHOST_HOST_STAT_WR_MASK) >> RPC_IPCHOST_HOST_STAT_WR_SHIFT;
        /* Retain regVal16 for further use */

        /* Check if feasible */
        if (((rPtr + ipcMsgCnt) & RPC_IPCHOST_MAX_PTR_MASK) != wPtr) {

            /* The RPC_IpcWrite32Bulk API expects the transfer length to be aligned to 32 bytes */
            const uint32_t transferSize = (len + IPC_MSG_HDR_SIZE + 31U) & (~(31U));

            idx = (wPtr & (ipcMsgCnt - 1));
            memset(buffer, 0, sizeof(buffer));
            memcpy(&buffer[RPC_IPCHOST_HDR_LAST_INDEX], msg, len);
            buffer[RPC_IPCHOST_HDR_MAGIC_INDEX] = RPC_IPCHOST_COMMAND_MAGIC;
            buffer[RPC_IPCHOST_HDR_CHKSUM_INDEX] =
                uswap32(RPC_IpcHostGetChksum(RPC_IPCHOST_COMMAND_MAGIC, cmd,
                        &buffer[RPC_IPCHOST_HDR_LAST_INDEX],
                        len + IPC_MSG_HDR_SIZE, len));
            buffer[RPC_IPCHOST_HDR_COMMAND_INDEX] = uswap32(cmd);
            buffer[RPC_IPCHOST_HDR_LENGTH_INDEX] = uswap32(len);

            /* Memcpy */
            retVal = RPC_IpcWrite32Bulk((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz],
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
            regVal16 &= ~RPC_IPCHOST_HOST_STAT_WR_MASK;
            regVal16 |= ((wPtr << RPC_IPCHOST_HOST_STAT_WR_SHIFT) & RPC_IPCHOST_HOST_STAT_WR_MASK);
            RPC_IpcBusXferWrite(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

            RPC_IpcHostPlatNotifyTarget(RPC_IpcHostIfcConfig.devId);
        } else {
            retVal = BCM_ERR_NOMEM;
        }
    }

done:
    return retVal;
}

int32_t RPC_IpcHostRecv(uint32_t *cmd, uint8_t *msg, uint32_t len_max, uint32_t *len)
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
    uint32_t header[RPC_IPCHOST_HDR_LAST_INDEX];
    uint32_t chksum;

    retVal = RPC_IpcHostPlatGetBuff(RPC_IpcHostIfcConfig.devId, &ipcBuff, &ipcMsgCnt, &cntRollOverMask, &ipcMsgSz);
    if (retVal != BCM_ERR_OK) {
        /* (void)MODULE_HostHelperLog("IPC Buffer is not yet initialised\n"); */
        goto done;
    }

    RPC_IpcBusXferRead(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_TARGET_STAT_REG, (uint8_t *)&regVal16, 16UL);
    wPtr = (regVal16 & RPC_IPCHOST_TARGET_STAT_WR_MASK) >> RPC_IPCHOST_TARGET_STAT_WR_SHIFT;

    RPC_IpcBusXferRead(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);
    rPtr = (regVal16 & RPC_IPCHOST_HOST_STAT_RD_MASK) >> RPC_IPCHOST_HOST_STAT_RD_SHIFT;
    /* Retain regVal16 for further use */

    /* Check if there is a new message */
    if (rPtr != wPtr) {
        idx = (rPtr & (ipcMsgCnt - 1)) + ipcMsgCnt;

        /* Memcpy */
        retVal = RPC_IpcRead32Bulk((uint8_t*)header, (uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz], sizeof(header));
        if (retVal != BCM_ERR_OK) {
            retVal = BCM_ERR_UNKNOWN;
        }
        else {
            *cmd = uswap32(header[RPC_IPCHOST_HDR_COMMAND_INDEX]);
            *len = uswap32(header[RPC_IPCHOST_HDR_LENGTH_INDEX]);

            if (*len <= (ipcMsgSz - sizeof(header))) {
                retVal = RPC_IpcRead32Bulk(msg, ((uint32_t)(intptr_t)&ipcBuff[idx*ipcMsgSz]) + sizeof(header), *len);
                if (retVal != BCM_ERR_OK) {
                    retVal = BCM_ERR_UNKNOWN;
                }
                else {
                    chksum = RPC_IpcHostGetChksum(uswap32(header[RPC_IPCHOST_HDR_MAGIC_INDEX]),
                            uswap32(header[RPC_IPCHOST_HDR_COMMAND_INDEX]),
                            (uint32_t*)msg, *len + sizeof(header), *len);
                    if (RPC_IPCHOST_REPLY_MAGIC != uswap32(header[RPC_IPCHOST_HDR_MAGIC_INDEX])) {
                        retVal = BCM_ERR_DATA_INTEG;
                        (void)MODULE_HostHelperLog("IPC: Invalid Magic\n");
                    } else if (chksum != uswap32(header[RPC_IPCHOST_HDR_CHKSUM_INDEX])) {
                        retVal = BCM_ERR_DATA_INTEG;
                        (void)MODULE_HostHelperLog("IPC: Failed to validate chksum\n");
                    } else {
                        retVal = BCM_ERR_OK;
                    }
                }
            } else {
                (void)MODULE_HostHelperLog("IPC Receive: incorrect length %u\n", *len);
                retVal = BCM_ERR_NOMEM;
            }
        }
        /* Increment read pointer */
        rPtr++;
        rPtr &= cntRollOverMask;

        /* Update HOST register */
        regVal16 &= ~RPC_IPCHOST_HOST_STAT_RD_MASK;
        regVal16 |= ((rPtr << RPC_IPCHOST_HOST_STAT_RD_SHIFT) & RPC_IPCHOST_HOST_STAT_RD_MASK);
        RPC_IpcBusXferWrite(RPC_IpcHostIfcConfig.devId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_HOST_STAT_REG, (uint8_t *)&regVal16, 16UL);

        RPC_IpcHostPlatNotifyTarget(RPC_IpcHostIfcConfig.devId);
    } else {
        retVal = BCM_ERR_NOT_FOUND;
    }

done:
    return retVal;
}

int32_t RPC_IpcHostInit(void)
{
    int32_t retVal;

    retVal = RPC_IpcBusInit();
    if (BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("Could not initialize hipc interface bus\n");
    } else {
        (void)MODULE_HostHelperLog("RPC_IpcBusInit Succesfull bus:%d\n", RPC_IpcHostIfcConfig.devId);
    }
    return retVal;
}

void RPC_IpcHostDeinit(void)
{
    RPC_IpcBusDeInit();
}

int32_t RPC_IpcHostSetConfig(RPC_IpcHostIfcConfigType *aCfg)
{
    int retVal = BCM_ERR_NOSUPPORT;
#ifdef RPC_IPC_JLINK
    if (RPC_IPCHOST_INTERFACE_JLINK == aCfg->mode) {
        RPC_IpcHostIfcModeIdx = RPC_IPCHOST_IFC_MODE_IDX_JLINK;
        retVal = BCM_ERR_OK;
    }
#endif
#ifdef RPC_IPC_PCIE
    if (RPC_IPCHOST_INTERFACE_PCIE == aCfg->mode) {
        RPC_IpcHostIfcModeIdx = RPC_IPCHOST_IFC_MODE_IDX_PCIE;
        retVal = BCM_ERR_OK;
    }
#endif
    if (retVal != BCM_ERR_OK) {
        (void)MODULE_HostHelperLog("Host SetConfig failed mode=%d idx=%d\n", aCfg->mode, RPC_IpcHostIfcModeIdx);
        goto done;
    }

    if (0xFFFFFFFF != aCfg->devId) {
        RPC_IpcHostIfcConfig.devId = aCfg->devId;
    } else {
        RPC_IpcHostIfcConfig.devId =  0UL;
    }

    if (0UL != aCfg->serial) {
        RPC_IpcHostIfcConfig.serial = aCfg->serial;
    } else {
        RPC_IpcHostIfcConfig.serial = 0UL;
    }

    RPC_IpcHostIfcConfig.chip = aCfg->chip;
done:
    return retVal;
}
