/*****************************************************************************
 Copyright 2019 Broadcom Limited.  All rights reserved.

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
#include <stdio.h>
#include <bcm_err.h>
#include "mcu.h"
#include "bcm_utils.h"
#include <rpc_ipc_host_plat.h>
#include <rpc_ipc_bus_xfer.h>
#include <module_msg.h>

/**
    @brief RDB register config per platform
*/
const RPC_IpcHostRdbRegType RPC_IpcHostRdbReg[]  = {
    {                                         /* chip = BCM89571, BCM89572 */
        .wdtCtrlAddr = 0x40145008,
        .wdtIntClrAddr = 0x4014500C,
        .wdtLockAddr = 0x40145C00,

        .blDwnldTargetSpareReg = 0x4A800322,  /* chip_misc spare_sw_reg1  */
        .ipcBufInfoReg = 0x4A80032e,          /* chip_misc spare_sw_reg7  */
        .ipcBufInfo2Reg = 0x4A800334,         /* chip_misc spare_sw_reg10 */
        .ipcTargetStatReg = 0x4A800330,       /* chip_misc spare_sw_reg8  */
        .ipcHostStatReg = 0x4A800332,         /* chip_misc spare_sw_reg9  */
        .cpusysMiscReg = 0x4A800340,          /* chip_misc cpusys_misc    */
    },
    {                                         /* chip = BCM89561, BCM89564 */
        .wdtCtrlAddr = 0x40145008,
        .wdtIntClrAddr = 0x4014500C,
        .wdtLockAddr = 0x40145C00,

        .blDwnldTargetSpareReg = 0x4A800322,  /* chip_misc spare_sw_reg1  */
        .ipcBufInfoReg = 0x4A80032e,          /* chip_misc spare_sw_reg7  */
        .ipcBufInfo2Reg = 0x4A800334,         /* chip_misc spare_sw_reg10 */
        .ipcTargetStatReg = 0x4A800330,       /* chip_misc spare_sw_reg8  */
        .ipcHostStatReg = 0x4A800332,         /* chip_misc spare_sw_reg9  */
        .cpusysMiscReg = 0x4A800340,          /* chip_misc cpusys_misc    */
    },
};

RPC_IpcHostIfcConfigType RPC_IpcHostIfcConfig;

static uint16_t RPC_IpcHostEvenParity(uint16_t val)
{
    uint16_t par = 0U;
    uint16_t i = sizeof(val) * 8U;

    while (i--) {
        par ^= ((val >> i) & 0x1U);
    }
    return par;
}

void RPC_IpcHostPlatNotifyTarget(uint32_t slaveId)
{
    uint16_t regVal16;
    /* Trigger IPC interrupt to target */
    RPC_IpcBusXferRead(slaveId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_CPUSYS_MISC_REG, (uint8_t *)&regVal16, 16UL);
    regVal16 |= 1U;
    RPC_IpcBusXferWrite(slaveId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_CPUSYS_MISC_REG, (uint8_t *)&regVal16, 16UL);
}

int32_t RPC_IpcHostPlatGetBuff(uint32_t slaveId, uint8_t **buff, uint16_t *cnt,
                               uint8_t *cntRollOverMask, uint16_t *sz)
{
    uint16_t reg1Val16;
    uint16_t reg2Val16;
    int32_t retVal = BCM_ERR_OK;

    RPC_IpcBusXferRead(slaveId, RPC_IPCBUS_ACCESS_DIRECT,
        (uint32_t)(intptr_t)RPC_IPCHOST_IPC_BUFF_INFO_REG, (uint8_t *)&reg1Val16, 16UL);

    RPC_IpcBusXferRead(slaveId, RPC_IPCBUS_ACCESS_DIRECT,
        (uint32_t)(intptr_t)RPC_IPCHOST_IPC_BUFF_INFO2_REG, (uint8_t *)&reg2Val16, 16UL);

    if ((reg1Val16 != 0xFFFF) && (reg1Val16 != 0)
        && (RPC_IpcHostEvenParity(reg1Val16) == 0U)
        && (RPC_IpcHostEvenParity(reg2Val16) == 0U)) {
        *cnt = 1 << ((reg1Val16 & RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_CNT_MASK) >> RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_CNT_SHIFT);
        *sz = 1 << ((reg1Val16 & RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_SZ_MASK) >> RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_SZ_SHIFT);

        *buff = (uint8_t *)(intptr_t)((((reg1Val16 & RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_MASK)
                        >> RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_SHIFT)
                    << RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO_BASE_ALIGN_SHIFT)
                | (((reg2Val16 & RPC_IPCHOST_IPC_BUFF_INFO2_BASE_MASK)
                        >> RPC_IPCHOST_IPC_BUFF_INFO2_BASE_SHIFT)
                    << RPC_IPCHOST_RPC_IPCHOST_BUFF_INFO2_BASE_ALIGN_SHIFT));

        RPC_IpcBusXferRead(slaveId, RPC_IPCBUS_ACCESS_DIRECT, (uint32_t)(intptr_t)RPC_IPCHOST_BL_DWNLD_TARGET_SPARE_REG, (uint8_t *)&reg1Val16, 16UL);
        if ((1U == *cnt)    /* BROM and BL */
            && (RPC_IPCHOST_BL_IPC_DWNLD_BL_READY_MASK != (reg1Val16 & RPC_IPCHOST_BL_IPC_DWNLD_BL_READY_MASK))) {
            /* BootROM only */
            *cntRollOverMask = 0x1U; /* 0-1 */
        } else {
            *cntRollOverMask = 0xFU; /* 0-15 */
        }
    } else {
        *cnt = 0UL;
        *sz = 0UL;
        *buff = 0UL;
        retVal = BCM_ERR_UNINIT;
    }

    return retVal;
}
