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

#ifndef RPC_IPC_BUS_XFER
#define RPC_IPC_BUS_XFER

typedef uint32_t RPC_IpcBusAccessType;
#define RPC_IPCBUS_ACCESS_DIRECT       (0x00000001UL)
#define RPC_IPCBUS_ACCESS_INDIRECT     (0x00000002UL)

typedef int32_t (*RPC_IpcBusInitIfcType)(uint32_t busSerial, uint32_t chip, uint32_t devId, uint32_t speed);

typedef int32_t (*RPC_IpcBusReadType)(uint32_t slaveId, RPC_IpcBusAccessType access,
                                     uint32_t addr, uint8_t *data, uint32_t width);

typedef int32_t (*RPC_IpcBusBulkReadType)(uint32_t slaveId, RPC_IpcBusAccessType access,
                                     uint32_t addr, uint8_t *data, uint32_t size);

typedef int32_t (*RPC_IpcBusWriteType)(uint32_t slaveId, RPC_IpcBusAccessType access,
                                      uint32_t addr, uint8_t *data, uint32_t width);

typedef int32_t (*RPC_IpcBusBulkWriteType)(uint32_t slaveId, RPC_IpcBusAccessType access,
                                      uint32_t addr, uint8_t *data, uint32_t size);

typedef void (*RPC_IpcBusDeInitType)(void);

typedef struct sRPC_IpcBusIfcType {
    RPC_IpcBusInitIfcType   init;
    RPC_IpcBusReadType      read;
    RPC_IpcBusBulkReadType  bulkRead;
    RPC_IpcBusWriteType     write;
    RPC_IpcBusBulkWriteType bulkWrite;
    RPC_IpcBusDeInitType    deinit;
} RPC_IpcBusIfcType;

/** @brief Initialize Bus

    This API initializes all the underlying buses for data transfers

    @behavior Sync, Non Re-entrant

    @pre None

    @param      None

    @return     None

    @post None

    @limitations None
*/
int32_t RPC_IpcBusInit(void);

/** @brief Bus DeInitialization

    This API de-initializes all the underlying buses

    @behavior Sync, Non Re-entrant

    @pre None

    @param      None

    @return     None

    @post None

    @limitations None
*/
int32_t RPC_IpcBusDeInit(void);

/** @brief Bus Transfer - Read Operation

    This API reads the data from the given address using
    underlying bus protocol

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      slaveId         Slave Identification
    @param[in]      access          Access type
    @param[in]      addr            Address to be access
    @param[out]     data            Pointer to data buffer
    @param[in]      width           Width/size of transfer in bits

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_INVAL_PARAMS   Invalid access type
    @return     #BCM_ERR_INVAL_PARAMS   Invalid width
    @return     #BCM_ERR_TIME_OUT       Timed out waiting for operation
                                        completion

    @post None

    @limitations None
*/
int32_t RPC_IpcBusXferRead(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                           uint8_t *data, uint32_t width);

/** @brief Bus Transfer - Write Operation

    This API writes the given data at given address using the
    underlying bus protocol

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      slaveId         Slave Identification
    @param[in]      access          Access type
    @param[in]      addr            Address to be access
    @param[in]      data            Pointer to data buffer
    @param[in]      width           Width/size of transfer in bits

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_INVAL_PARAMS   Invalid access type
    @return     #BCM_ERR_INVAL_PARAMS   Invalid width
    @return     #BCM_ERR_TIME_OUT       Timed out waiting for operation
                                        completion

    @post None

    @limitations None
*/
int32_t RPC_IpcBusXferWrite(uint32_t slaveId, RPC_IpcBusAccessType access, uint32_t addr,
                            uint8_t *data, uint32_t width);

#endif /* RPC_IPC_BUS_XFER */

