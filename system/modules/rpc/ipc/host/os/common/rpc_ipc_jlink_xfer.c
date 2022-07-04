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
#include <string.h>
#include <bcm_err.h>
#include <rpc_ipc_bus_xfer.h>
#include <rpc_ipc_host_plat.h>
#include <module_msg.h>
#include <JLinkARMDLL.h>
#include <unistd.h>


static int32_t RPC_IpcJlinkRead8(uint32_t addr, uint8_t *rd_val)
{
    int retVal;
    uint8_t data;
    uint8_t pStatus;

    retVal = JLINKARM_ReadMemU8(addr, 1UL, &data, &pStatus);
    if ((retVal < 0) || (BCM_ERR_OK != pStatus)) {
        (void)MODULE_HostHelperLog("JLINKARM_ReadMemU8 failed addr=0x%08x retVal=%d, status=%d\n",addr, retVal, pStatus);
        goto done;
    } else {
        *rd_val = data;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

static int32_t RPC_IpcJlinkRead16(uint32_t addr, uint16_t *rd_val)
{
    int retVal;
    uint16_t data;
    uint8_t pStatus;

    retVal = JLINKARM_ReadMemU16(addr, 1UL, &data, &pStatus);
    if ((retVal < 0) || (BCM_ERR_OK != pStatus)) {
        (void)MODULE_HostHelperLog("JLINKARM_ReadMemU16 failed addr=0x%08x retVal=%d, status=%d\n",addr, retVal, pStatus);
        goto done;
    } else {
        *rd_val = data;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

static int32_t RPC_IpcJlinkRead32(uint32_t addr, uint32_t *rd_val)
{
    int retVal;
    uint32_t data;
    uint8_t pStatus;

    retVal = JLINKARM_ReadMemU32(addr, 1UL, &data, &pStatus);
    if ((retVal < 0) || (BCM_ERR_OK != pStatus)) {
        (void)MODULE_HostHelperLog("JLINKARM_ReadMemU32 failed addr=0x%08x retVal=%d, status=%d\n",addr, retVal, pStatus);
        goto done;
    } else {
        *rd_val = data;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

static int32_t RPC_IpcJlinkRead64(uint32_t addr, uint64_t *rd_val)
{
    int retVal;
    long long unsigned int data; /* refer to vendor/segger/inc/TYPES.h */
    uint8_t pStatus;

    retVal = JLINKARM_ReadMemU64(addr, 1UL, &data, &pStatus);
    if ((retVal < 0) || (BCM_ERR_OK != pStatus)) {
        (void)MODULE_HostHelperLog("JLINKARM_ReadMemU64 failed addr=0x%08x retVal=%d, status=%d\n",addr, retVal, pStatus);
        goto done;
    } else {
        *rd_val = (uint64_t)data;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

static int32_t RPC_IpcJlinkWrite8(uint32_t addr, uint8_t data)
{
    int retVal;

    retVal = JLINKARM_WriteU8(addr, data);
    if (BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("JLINKARM_WriteU8 failed addr=0x%08x retVal=%d,\n", addr, retVal);
    }

    return retVal;
}

static int32_t RPC_IpcJlinkWrite16(uint32_t addr, uint16_t data)
{
    int retVal;

    retVal = JLINKARM_WriteU16(addr, data);
    if (BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("RPC_IpcJlinkWrite16 failed addr=0x%08x retVal=%d,\n", addr, retVal);
    }

    return retVal;
}

static int32_t RPC_IpcJlinkWrite32(uint32_t addr, uint32_t data)
{
    int retVal;

    retVal = JLINKARM_WriteU32(addr, data);
    if (BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("RPC_IpcJlinkWrite16 failed addr=0x%08x retVal=%d,\n", addr, retVal);
    }

    return retVal;
}

static int32_t RPC_IpcJlinkWrite64(uint32_t addr, uint64_t data)
{
    int32_t retVal;

    retVal = JLINKARM_WriteU64(addr, data);
    if (BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("JLINKARM_WriteU64 failed addr=0x%08x retVal=%d,\n", addr, retVal);
    }

    return retVal;
}

int32_t RPC_IpcJlinkXferRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    switch (width) {
    case 8UL:
        retVal = RPC_IpcJlinkRead8(addr, data);
        break;
    case 16UL:
        retVal = RPC_IpcJlinkRead16(addr, (uint16_t *)data);
        break;
    case 32UL:
        retVal = RPC_IpcJlinkRead32(addr, (uint32_t *)data);
        break;
    case 64UL:
        retVal = RPC_IpcJlinkRead64(addr, (uint64_t *)data);
        break;
    default:
        break;
    }
    return retVal;
}

int32_t RPC_IpcJlinkXferBulkRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t size)
{
    int32_t retVal;
    retVal = JLINKARM_ReadMem(addr, size, data);
    return retVal;
}

int32_t RPC_IpcJlinkXferWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t width)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    switch (width) {
    case 8UL:
        retVal = RPC_IpcJlinkWrite8(addr, *data);
        break;
    case 16UL:
        retVal = RPC_IpcJlinkWrite16(addr, *(uint16_t *)data);
        break;
    case 32UL:
        retVal = RPC_IpcJlinkWrite32(addr, *(uint32_t *)data);
        break;
    case 64UL:
        retVal = RPC_IpcJlinkWrite64(addr, *(uint64_t *)data);
        break;
    default:
        break;
    }
    return retVal;
}

int32_t RPC_IpcJlinkXferBulkWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                        uint8_t *data, uint32_t size)
{
    int32_t retVal;
    retVal = JLINKARM_WriteMem(addr, size, data);
    if (retVal == size) {
        retVal = BCM_ERR_OK;
    } else {
        retVal = BCM_ERR_UNKNOWN;
    }
    return retVal;
}

static void _LogOut(const char* sLog) {
    (void)MODULE_HostHelperLog("Jlink Log: %s\n", sLog);
}

static void _ErrorOut(const char* sError) {
    (void)MODULE_HostHelperLog("\nJlink ERROR: %s\n", sError);
}

static void JLINK_DisableWdt(void)
{
    /* Disabling Watchdog */
    uint32_t data;
    RPC_IpcJlinkRead32(RPC_IPCHOST_WDT_CTRL_ADDR, &data);
    (void)MODULE_HostHelperLog("Watchdog ctrl reg: %08x, before resetting: %08x\n", RPC_IPCHOST_WDT_CTRL_ADDR, data);
    RPC_IpcJlinkWrite32(RPC_IPCHOST_WDT_LOCK_ADDR, 0x1ACCE551UL);
    RPC_IpcJlinkWrite32(RPC_IPCHOST_WDT_INTCLR_ADDR, 1UL);
    RPC_IpcJlinkWrite32(RPC_IPCHOST_WDT_CTRL_ADDR, 0UL);
    RPC_IpcJlinkRead32(RPC_IPCHOST_WDT_CTRL_ADDR, &data);
    (void)MODULE_HostHelperLog("Watchdog ctrl reg: %08x, after resetting: %08x\n", RPC_IPCHOST_WDT_CTRL_ADDR, data);
}

int32_t RPC_IpcJlinkInit(uint32_t busSerial, uint32_t chip, uint32_t devId, uint32_t speedHz)
{
    int retVal = BCM_ERR_OK;
    const char* sError;
    char acIn[0x400];
    char acOut[0x400];
    uint32_t ver;
    uint32_t numDev;
    char pIP[20];

    (void)MODULE_HostHelperLog("JLINK_Init: Wait few sec before initialization..\n");
    sleep(2);

    // JLINKARM_EnableLogCom(_LogOut);
    // JLINKARM_EnableLog(_LogOut);

    if (JLINKARM_IsOpen()) {
        JLINKARM_Close();
        (void)MODULE_HostHelperLog("JLink found in opened state. Closed.\n");
    }

    /* devId contains port number when connected via IP Server */
    if (0UL != devId) {
        sprintf(pIP, "%d.%d.%d.%d", ((busSerial & 0xFF000000) >> 24UL),
                                    ((busSerial & 0x00FF0000) >> 16UL),
                                    ((busSerial & 0x0000FF00) >> 8UL),
                                    (busSerial & 0x000000FF));

        retVal = JLINKARM_SelectIP(pIP, devId);
        if (0 != retVal) {
            (void)MODULE_HostHelperLog("JLINKARM_SelectIP Failed IP:%s Port:%d Error:%d\n", pIP, devId, retVal);
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        } else {
            (void)MODULE_HostHelperLog("JLINK_Init Connected to IP: %s Port:%d\n", pIP, devId);
        }
    } else {
        numDev = JLINKARM_EMU_GetNumDevices();
        (void)MODULE_HostHelperLog("JLINK Num of Emulators %d\n", numDev);

        /* Select device if serial number is available to avoid pop up */
        if (0UL != busSerial) {
            retVal = JLINKARM_EMU_SelectByUSBSN(busSerial);
            if (retVal < 0) {
                (void)MODULE_HostHelperLog("JLINK Emulator Index Error %d\n", retVal);
                retVal = BCM_ERR_UNKNOWN;
                goto done;
            } else {
                (void)MODULE_HostHelperLog("JLINK Emulator Index %d\n", retVal);
            }
        }
    }

    sError = JLINKARM_OpenEx(_LogOut, _ErrorOut);
    if (sError) {
        _ErrorOut(sError);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    (void)MODULE_HostHelperLog("Get JLINK Serial: %d\n", JLINKARM_GetSN());
    /* If we dont close, it causes below error during power on reset on erased mcm board.
        Jlink ERROR: CPU-TAP not found in JTAG chain */
    JLINKARM_Close();

    /* As JLINKARM_Close was called, select the device again */
    if (0UL != devId) {
        retVal = JLINKARM_SelectIP(pIP, devId);
        if (0 != retVal) {
            (void)MODULE_HostHelperLog("JLINKARM_SelectIP Failed: %d\n", retVal);
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        }
    } else {
        if (0UL != busSerial) {
            retVal = JLINKARM_EMU_SelectByUSBSN(busSerial);
            if (retVal < 0) {
                (void)MODULE_HostHelperLog("JLINK Emulator Index Error %d\n", retVal);
                retVal = BCM_ERR_UNKNOWN;
                goto done;
            } else {
                (void)MODULE_HostHelperLog("JLINK Emulator Index %d\n", retVal);
            }
        }
    }

    JLINKARM_CORE_Select(JLINK_CORE_CORTEX_M7);
    JLINKARM_TIF_Select(JLINKARM_TIF_JTAG);

    strcpy(acIn, "CORESIGHT_SetIndexAHBAPToUse = 1");
    JLINKARM_ExecCommand(acIn, &acOut[0], sizeof(acOut));
    if (acOut[0]) {
        _ErrorOut(acOut);
        retVal = BCM_ERR_UNKNOWN;
        goto done;
    }

    if (RPC_IPCHOST_CHIP_IDX_BCM89564 == chip) {
        /* Connect to SC1 which is the master */
        retVal = JLINKARM_CORESIGHT_Configure("IRPre=4;DRPre=1;IRPost=0;DRPost=0;IRLenDevice=4");
        if (retVal < 0UL) {
            _ErrorOut("JLINKARM_CORESIGHT_Configure failed");
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        }
    }

    //JLINKARM_SetSpeed(speedHz/1000UL);
    JLINKARM_SetMaxSpeed();

    retVal = JLINKARM_Connect();
    if (BCM_ERR_OK != retVal) {
        _ErrorOut("Could not connect to target.");
        retVal = BCM_ERR_UNKNOWN;
    }

    ver = JLINKARM_GetDLLVersion();
    printf("Jlink DLL Version: %d.%.2d%c\n", ver / 10000, ver / 100 %100, ver %100 + 'a'-1);

    (void)MODULE_HostHelperLog("Connected to JLINK Serial Number:%d with Speed:%dKhz\n",
                                                                JLINKARM_GetSN(),
                                                                JLINKARM_GetSpeed());

    JLINK_DisableWdt();

    if (RPC_IPCHOST_CHIP_IDX_BCM89564 == chip) {
        /* Connect to SC2 to disable Watchdog */
        retVal = JLINKARM_CORESIGHT_Configure("IRPre=0;DRPre=0;IRPost=4;DRPost=1;IRLenDevice=4");
        if (retVal < 0UL) {
            _ErrorOut("JLINKARM_CORESIGHT_Configure failed");
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        }

        JLINK_DisableWdt();

        /* Connect back to SC1 */
        retVal = JLINKARM_CORESIGHT_Configure("IRPre=4;DRPre=1;IRPost=0;DRPost=0;IRLenDevice=4");
        if (retVal < 0UL) {
            _ErrorOut("JLINKARM_CORESIGHT_Configure failed");
            retVal = BCM_ERR_UNKNOWN;
            goto done;
        }
    }
done:
    return retVal;
}

void RPC_IpcJlinkDeInit(void)
{
    JLINKARM_Close();
}


const RPC_IpcBusIfcType RPC_IpcBusJlink = {
    .init       = RPC_IpcJlinkInit,
    .read       = RPC_IpcJlinkXferRead,
    .bulkRead   = RPC_IpcJlinkXferBulkRead,
    .write      = RPC_IpcJlinkXferWrite,
    .bulkWrite  = RPC_IpcJlinkXferBulkWrite,
    .deinit     = RPC_IpcJlinkDeInit,
};


