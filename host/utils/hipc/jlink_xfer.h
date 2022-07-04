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
#ifndef JLINK_XFER_H
#define JLINK_XFER_H

#include <stdint.h>

/** @brief JLINK Transfer - Read Operation

    This API is used to do a JLINK Read operation

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
extern int32_t JLINK_XferRead(uint32_t slaveId, HIPC_BusAccessType access,
                            uint32_t addr, uint8_t *data, uint32_t width);

/** @brief JLINK Transfer - Bulk Read Operation

    This API is used to do a JLINK Read operation

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      slaveId         Slave Identification
    @param[in]      access          Access type
    @param[in]      addr            Address to be access
    @param[out]     data            Pointer to data buffer
    @param[in]      size            size of transfer in bytes

    @return     #BCM_ERR_OK             Success
    @return     #BCM_ERR_INVAL_PARAMS   Invalid access type
    @return     #BCM_ERR_INVAL_PARAMS   Invalid width
    @return     #BCM_ERR_TIME_OUT       Timed out waiting for operation
                                        completion

    @post None

    @limitations None
*/
extern int32_t JLINK_XferBulkRead(uint32_t slaveId, HIPC_BusAccessType access,
                            uint32_t addr, uint8_t *data, uint32_t size);

/** @brief JLINK Transfer - Write Operation

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
extern int32_t JLINK_XferWrite(uint32_t slaveId, HIPC_BusAccessType access,
                            uint32_t addr, uint8_t *data, uint32_t width);

/** @brief JLINK Transfer - Write Operation

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
extern int32_t JLINK_XferBulkWrite(uint32_t slaveId, HIPC_BusAccessType access,
                            uint32_t addr, uint8_t *data, uint32_t size);


/** @brief JLINK Initialization

    @behavior Sync, Non Re-entrant

    @pre None

    @param[in]      busSerial       Segger serial number
    @param[in]      chip            chip name
    @param[in]      devId           dev Id
    @param[in]      speedHz         Jlink Clock

    @return     #BCM_ERR_OK         Success
    @return     #BCM_ERR_UNKNOWN    Jlink op failure

    @post None

    @limitations None
*/
extern int32_t JLINK_Init(uint32_t busSerial, uint32_t chip, uint32_t devId, uint32_t speedHz);

/** @brief JLINK De-Initialization

    @behavior Sync, Non Re-entrant

    @pre None

    @post None

    @limitations None
*/
extern void JLINK_DeInit(void);
#endif /* JLINK_XFER_H */
