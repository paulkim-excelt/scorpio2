/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <bcm_err.h>
#include <rpc_ipc_pcie_ioctl.h>
#include <rpc_ipc_bus_xfer.h>
#include <rpc_ipc_pcie_xfer.h>
#include <rpc_ipc_pcie_config.h>
#include <module_msg.h>

#define IND_ACC_RETRY                   (1000*1000)
#define IND_ACC_TX_SZ_8                 (0)
#define IND_ACC_TX_SZ_16                (1)
#define IND_ACC_TX_SZ_32                (2)
#define IND_ACC_TX_SZ_64                (3)
#define IND_ACC_RD                      (0 << 2)
#define IND_ACC_WR                      (1 << 2)
#define IND_ACC_AUTO_INC                (1 << 3)
#define IND_ACC_NO_AUTO_INC             (0 << 3)
#define IND_ACC_COMMIT                  (1 << 4)
#define IND_ACC_COMMIT_ON_RDWR          (1 << 5)
#define IND_ACC_DONE                    (1 << 7)

static int32_t RPC_IpcPcieFD;

int32_t RPC_IpcPcieRead32(uint32_t slaveId, uint32_t addr, uint8_t *data)
{
    int32_t ret = BCM_ERR_OK;
    int err;

    struct xgbe_ioctlcmd cmd = {
        .addr = addr,
        .width = 32,
        .data = data,
    };

    if (RPC_IpcPcieFD > 0) {
        err = ioctl(RPC_IpcPcieFD, XGBE_IOCTL_RDMEM, &cmd);
        if (err) {
            ret = BCM_ERR_UNKNOWN;
        }
    } else {
        ret = BCM_ERR_NODEV;
    }
    return ret;
}

int32_t RPC_IpcPcieWrite32(uint32_t slaveId, uint32_t addr, uint32_t data)

{
    int32_t ret = BCM_ERR_OK;
    int err;

    struct xgbe_ioctlcmd cmd = {
        .addr = addr,
        .width = 32,
        .data = (uint8_t *)&data,
    };

    if (RPC_IpcPcieFD > 0) {
        err = ioctl(RPC_IpcPcieFD, XGBE_IOCTL_WRMEM, &cmd);
        if (err) {
            ret = BCM_ERR_UNKNOWN;
        }
    } else {
        ret = BCM_ERR_NODEV;
    }
    return ret;
}

/* Indirect Accesses */
static int32_t RPC_IpcPcieRead8Indirect(uint32_t slaveId, uint32_t addr, uint8_t *data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
	int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_RD | IND_ACC_TX_SZ_8));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_TIME_OUT;
		goto done;
    }
    RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), (uint8_t *)&rd_val);
    *data = (uint8_t)(rd_val & 0xff);

done:
    return retVal;
}

static int32_t RPC_IpcPcieWrite8Indirect(uint32_t slaveId, uint32_t addr, uint8_t data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
	int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), (uint32_t)(data));
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_WR | IND_ACC_TX_SZ_8));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_TIME_OUT;
    }

    return retVal;
}

static int32_t RPC_IpcPcieRead16Indirect(uint32_t slaveId, uint32_t addr, uint8_t *data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_RD | IND_ACC_TX_SZ_16));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), (uint8_t *)&rd_val);

    *(uint16_t *)data = (uint16_t)(rd_val & 0xFFFF);
done:
    return retVal;
}

static int32_t RPC_IpcPcieWrite16Indirect(uint32_t slaveId, uint32_t addr, uint16_t data)
{
    uint32_t val = data;
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), val);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_WR | IND_ACC_TX_SZ_16));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&val);
    } while (--wait && !(val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, val);
        retVal = BCM_ERR_TIME_OUT;
    }

    return retVal;
}

static int32_t RPC_IpcPcieRead32Indirect(uint32_t slaveId, uint32_t addr, uint8_t *data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_RD | IND_ACC_TX_SZ_32));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), data);

done:
    return retVal;
}

static int32_t RPC_IpcPcieWrite32Indirect(uint32_t slaveId, uint32_t addr, uint32_t data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), data);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_WR | IND_ACC_TX_SZ_32));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_TIME_OUT;
    }

    return retVal;
}

static int32_t RPC_IpcPcieRead64Indirect(uint32_t slaveId, uint32_t addr, uint8_t *data)
{
    uint32_t rd_val[2];
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_RD | IND_ACC_TX_SZ_64));

    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val[0]);
    } while (--wait && !(rd_val[0] & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog("%s: Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val[0]);
        retVal = BCM_ERR_TIME_OUT;
        goto done;
    }

    RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), (uint8_t *)&rd_val[1]);
    RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_H_L16_REG), (uint8_t *)&rd_val[0]);

    *(uint64_t *)data = ((uint64_t)rd_val[0] << 32) | rd_val[1];

done:
    return retVal;
}

static int32_t RPC_IpcPcieWrite64Indirect(uint32_t slaveId, uint32_t addr, uint64_t data)
{
    uint32_t rd_val;
    uint32_t wait = IND_ACC_RETRY;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_ADDR_L16_REG), addr);
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_L_L16_REG), (uint32_t)(data & 0xFfFfFfFf));
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_DATA_H_L16_REG), (uint32_t)(data >> 32));
    RPC_IpcPcieWrite32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (IND_ACC_COMMIT | IND_ACC_NO_AUTO_INC | IND_ACC_WR | IND_ACC_TX_SZ_64));
    do {
        RPC_IpcPcieRead32(slaveId, (uint32_t)(intptr_t)(RPC_HOSTCPU_INDIRECT_CTRL_L16_REG), (uint8_t *)&rd_val);
    } while (--wait && !(rd_val & IND_ACC_DONE));
    if (!wait) {
        (void)MODULE_HostHelperLog(":%s Ind. Wr. timed out ctrl 0x%x\n", __func__, rd_val);
        retVal = BCM_ERR_TIME_OUT;
    }

    return retVal;
}

int32_t RPC_IpcPcieXferRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    switch (width) {
    case 8UL:
        retVal = RPC_IpcPcieRead8Indirect(slaveId, addr, data);
        break;
    case 16UL:
        retVal = RPC_IpcPcieRead16Indirect(slaveId, addr, data);
        break;
    case 32UL:
        if (RPC_IPCBUS_ACCESS_INDIRECT == access) {
            retVal = RPC_IpcPcieRead32Indirect(slaveId, addr, data);
        } else if (RPC_IPCBUS_ACCESS_DIRECT == access) {
            retVal = RPC_IpcPcieRead32(slaveId, addr, data);
        }
        break;
    case 64UL:
        retVal = RPC_IpcPcieRead64Indirect(slaveId, addr, data);
        break;
    default:
        break;
    }
    return retVal;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible.
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t RPC_IpcPcieXferBulkRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *buf, uint32_t size)
{
    uint32_t data;
    int i;
    int end = addr + size;
    uint8_t *dst = buf;
    int32_t retVal = BCM_ERR_OK;

    for (i = addr; i < end; i = i + sizeof(uint32_t)) {
        RPC_IpcPcieXferRead(slaveId, access, i, (uint8_t *)&data, 32UL);

        /* store in Little Endian format */
        dst[3] = (uint8_t)((data >> 24UL) & 0xFF);
        dst[2] = (uint8_t)((data >> 16UL) & 0xFF);
        dst[1] = (uint8_t)((data >>  8UL) & 0xFF);
        dst[0] = (uint8_t)(data & 0xFF);

        dst += 4UL;
    }

    return retVal;
}


int32_t RPC_IpcPcieXferWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    switch (width) {
    case 8UL:
        retVal = RPC_IpcPcieWrite8Indirect(slaveId, addr, *data);
        break;
    case 16UL:
        retVal = RPC_IpcPcieWrite16Indirect(slaveId, addr, *(uint16_t *)data);
        break;
    case 32UL:
        if (RPC_IPCBUS_ACCESS_INDIRECT == access) {
            retVal = RPC_IpcPcieWrite32Indirect(slaveId, addr, *(uint32_t *)data);
        } else if (RPC_IPCBUS_ACCESS_DIRECT == access) {
            retVal = RPC_IpcPcieWrite32(slaveId, addr, *(uint32_t *)data);
        }
        break;
    case 64UL:
        retVal = RPC_IpcPcieWrite64Indirect(slaveId, addr, *(uint64_t *)data);
        break;
    default:
        break;
    }
    return retVal;
}

/* In multiples of 32bit and assumes that buf[] is so aligned & accessible
   Also, the buffer has to be in target's endianness - Little Endian */
static int32_t RPC_IpcPcieXferBulkWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *buf, uint32_t size)
{
    int i;
    int end = addr + size;
    uint32_t data;
    uint8_t *src = buf;
    int32_t retVal = BCM_ERR_OK;

    for (i = addr; i < end; ) {
        /* Retrieve in Little Endian format */
        data =    ((uint32_t)src[3] << 24UL)
                | ((uint32_t)src[2] << 16UL)
                | ((uint32_t)src[1] <<  8UL)
                | src[0];

        RPC_IpcPcieXferWrite(slaveId, access, i, (uint8_t *)&data, 32UL);
        src += 4UL;
        i += 4UL;
    }
    return retVal;
}

int32_t RPC_IpcPcieInit(uint32_t busSerial, uint32_t chip, uint32_t devId, uint32_t speed)
{
    int32_t ret = BCM_ERR_OK;
    RPC_IpcPcieFD = open(BCM_XGBE_DEV, O_RDWR);
    if (RPC_IpcPcieFD < 0) {
        perror("open");
        ret = BCM_ERR_NODEV;
    }
    return ret;
}

void RPC_IpcPcieDeInit(void)
{
    if (RPC_IpcPcieFD > 0) {
        close(RPC_IpcPcieFD);
    }
}

const RPC_IpcBusIfcType RPC_IpcBusPcie = {
    .init       = RPC_IpcPcieInit,
    .read       = RPC_IpcPcieXferRead,
    .bulkRead   = RPC_IpcPcieXferBulkRead,
    .write      = RPC_IpcPcieXferWrite,
    .bulkWrite  = RPC_IpcPcieXferBulkWrite,
    .deinit     = RPC_IpcPcieDeInit,
};

