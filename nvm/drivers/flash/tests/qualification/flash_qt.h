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
/**
    @defgroup grp_nvm_flash_qt NVM flash qualification Test
    @ingroup grp_nvm

    @addtogroup grp_nvm_flash_qt
    @{

    @file flash_qt.h

    @board

    @brief NVM flash qualification Test
    This source file contains the qualification test for flash
    @version 0.1 Initial draft
*/

#ifndef FLASH_QT_H
#define FLASH_QT_H

/**
    @brief Check the flash driver status

    @pre Flash is in init state

    @test Call FLASH_GetStatus

    @post BCM_ERR_OK should be returned and FLASH_STATUS_IDLE
          should be updated in the status parameter
          Flash is initialized for the requested flash hw ID

    @functional Yes

    @type pos

    @trace #BRCM_SWARCH_FLASH_GET_STATUS_PROC
*/
#define BRCM_SWQTST_FLASH_STATUS_IDLE                                       (0x0001)

/**
    @brief Configure the read lane

    @pre Flash is in init state

    @test Call FLASH_CfgReadLane

    @post BCM_ERR_OK should be returned
          Read lane is configured for the requested flash hw ID

    @functional Yes

    @type pos

    @trace #BRCM_SWARCH_FLASH_CFG_READ_LANE_PROC
*/
#define BRCM_SWQTST_FLASH_CFG_READLANE                                      (0x0002)

/**
    @brief Configure the read lane

    @pre Flash is in init state

    @test Call FLASH_CfgReadLane

    @post BCM_ERR_NOSUPPORT should be returned
          Read lane is not configured for the requested flash hw ID

    @functional Yes

    @type Neg

    @trace #BRCM_SWARCH_FLASH_CFG_READ_LANE_PROC
*/
#define BRCM_SWQTST_FLASH_CFG_READLANE_NOSUPPORT                            (0x0003)

/**
    @brief Get the post operation result status

    @pre Flash is in init state

    @test Call FLASH_GetOpsResult

    @post BCM_ERR_OK should be returned and FLASH_OPS_RESULT_OK
          should be updated in the operation result parameter
          The requested operation is completed for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_GET_OPS_RESULT_PROC
*/
#define BRCM_SWQTST_FLASH_OPS_RESULT_OK                                     (0x0004)

/**
    @brief Flash state handler

    @pre Flash is in init state

    @test Call FLASH_StateHandler and wait till FlashQt_DoneEvent or
          FlashQt_ErrEvent are set

    @post BCM_ERR_OK should be returned
          The requested operation is completed for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_STATEHANDLER_PROC
*/
#define BRCM_SWQTST_FLASH_READ_EVENT_DONE                                   (0x0005)

/**
    @brief Get the flash driver status

    @pre Flash is in de-init state

    @test Call FLASH_GetStatus

    @post BCM_ERR_OK should be returned and FLASH_STATUS_UNINIT
          should be updated in the status parameter
          Flash is de-initialized for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_DEINIT_PROC
*/
#define BRCM_SWQTST_FLASH_STATUS_UNINIT                                     (0x0006)

/**
    @brief Read the flash driver device ID

    @pre Flash is in init state

    @test Call FLASH_ReadID

    @post BCM_ERR_OK should be returned
          Read dev ID request is placed succesfully for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_READ_ID_PROC
*/
#define BRCM_SWQTST_FLASH_READ_DEVID                                        (0x0007)

/**
    @brief Read the flash driver device ID register

    @pre Flash is in init state

    @test Call FLASH_RegReadWrite

    @post BCM_ERR_OK should be returned
          Read dev ID register request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_READ_ID_PROC
*/
#define BRCM_SWQTST_FLASH_READ_DEVID_REG                                    (0x0008)

/**
    @brief Compare the read device IDs

    @pre Flash is in init state

    @test Call FLASH_RegReadWrite and FLASH_ReadID

    @post BCM_ERR_OK should be returned
          The read device IDs from both APIs are same

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_READ_ID_PROC
*/
#define BRCM_SWQTST_FLASH_READ_CMP_DEVID                                    (0x0009)

/**
    @brief Erase the flash sector

    @pre Flash is in init state

    @test Call FLASH_Erase

    @post BCM_ERR_OK should be returned
          Flash sector erase request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_ERASE_PROC
*/
#define BRCM_SWQTST_FLASH_ERASE_SECTOR                                      (0x000A)

/**
    @brief Blank check of flash sector

    @pre Flash is in init state

    @test Call FLASH_BlankCheck

    @post BCM_ERR_OK should be returned
          Flash sector blank check request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_BLANK_CHECK_PROC
*/
#define BRCM_SWQTST_FLASH_ERASE_BLANK_CHECK                                 (0x000B)

/**
    @brief Flash write request

    @pre Flash is in init state

    @test Call FLASH_Write

    @post BCM_ERR_OK should be returned
          Flash page write request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_WRITE_PROC
*/
#define BRCM_SWQTST_FLASH_WRITE_PAGE                                        (0x000C)

/**
    @brief Flash read request

    @pre Flash is in init state

    @test Call FLASH_Read

    @post BCM_ERR_OK should be returned
          Flash page read request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_READ_PROC
*/
#define BRCM_SWQTST_FLASH_READ_PAGE                                         (0x000D)

/**
    @brief Flash read request

    @pre Flash is in init state

    @test Call FLASH_Write and FLASH_Read

    @post BCM_ERR_OK should be returned
          The written data and read data are same

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_WRITE_PROC
    @trace #BRCM_SWARCH_FLASH_READ_PROC
*/
#define BRCM_SWQTST_FLASH_CMP_PAGE                                          (0x000E)

/**
    @brief Flash compare request

    @pre Flash is in init state

    @test Call FLASH_Compare

    @post BCM_ERR_OK should be returned
          Flash compare request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_COMPARE_PROC
*/
#define BRCM_SWQTST_FLASH_READ_CMP                                          (0x000F)

/**
    @brief Flash read request

    @pre Flash is in init state

    @test Call FLASH_Read

    @post BCM_ERR_OK should be returned
          Flash page read request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_READ_PROC
*/
#define BRCM_SWQTST_FLASH_READ_ALL_PAGES                                    (0x0010)

/**
    @brief Flash cancel request

    @pre Flash is in init state

    @test Call FLASH_Cancel

    @post BCM_ERR_OK should be returned
          Flash cancel request is placed succesfully
          for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_CANCEL_PROC
*/
#define BRCM_SWQTST_FLASH_CANCEL                                            (0x0011)

/**
    @brief Flash state handler

    @pre Flash is in init state

    @test Call FLASH_StateHandler and wait till FlashQt_DoneEvent or
          FlashQt_ErrEvent are set

    @post BCM_ERR_OK should be returned
          The requested operation is completed for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_STATEHANDLER_PROC
*/
#define BRCM_SWQTST_FLASH_READ_EVENT_ERR                                    (0x0012)

/**
    @brief Get the post operation result status

    @pre Flash is in init state

    @test Call FLASH_GetOpsResult

    @post BCM_ERR_OK should be returned and FLASH_OPS_RESULT_CANCELLED
          should be updated in the operation result parameter
          The requested operation is completed for the requested flash hw ID

    @functional Yes

    @type Pos

    @trace #BRCM_SWARCH_FLASH_GET_OPS_RESULT_PROC
*/
#define BRCM_SWQTST_FLASH_OPS_RESULT_CANCELLED                              (0x0013)

/** @brief Qualification test sequence for testing basic flashing APIs

    @code{.c}

    Call FLASH_Init() with flash hw ID 0

    Call FLASH_GetStatus() with flash hw ID 0 and status parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_STATUS_IDLE

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    if the read lane configuration is enabled then,
    Call FLASH_CfgReadLane() with flash hw ID 0
    Check Expected Result for #BRCM_SWQTST_FLASH_CFG_READLANE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    if the read lane configuration is not enabled then,
    Call FLASH_CfgReadLane() with flash hw ID 0
    Check Expected Result for #BRCM_SWQTST_FLASH_CFG_READLANE_NOSUPPORT

    Call FLASH_ReadID() with flash hw ID 0
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_DEVID

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_RegReadWrite() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_DEVID_REG

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the read device ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP_DEVID

    Call FLASH_Erase() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_ERASE_SECTOR

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the read device ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP_DEVID

    Call FLASH_BlankCheck() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_ERASE_BLANK_CHECK

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Write() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_WRITE_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Read() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the written and read page buffers
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP

    Call FLASH_Compare() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_CMP_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Read() with flash hw ID 0 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_ALL_PAGES

    Wait for the first read event to complete
    Call FLASH_StateHandler() with flash hw ID 0

    Call FLASH_Cancel() with flash hw ID 0
    Check Expected Result for #BRCM_SWQTST_FLASH_CANCEL

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_ERR

    Call FLASH_GetOpsResult() with flash hw ID 0 and operation result parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_CANCELLED

    Call FLASH_DeInit() with flash hw ID 0

    Call FLASH_GetStatus() with flash hw ID 0 and status parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_STATUS_UNINIT

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    2s

    @analyzetime    5h
*/
#define BRCM_SWQTSEQ_FLASH_CTRL0_SEQ1                                       (0x0001)

/** @brief Qualification test sequence for testing basic flashing APIs

    @code{.c}

    Call FLASH_Init() with flash hw ID 1

    Call FLASH_GetStatus() with flash hw ID 1 and status parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_STATUS_IDLE

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    if the read lane configuration is enabled then,
    Call FLASH_CfgReadLane() with flash hw ID 1
    Check Expected Result for #BRCM_SWQTST_FLASH_CFG_READLANE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    if the read lane configuration is not enabled then,
    Call FLASH_CfgReadLane() with flash hw ID 1
    Check Expected Result for #BRCM_SWQTST_FLASH_CFG_READLANE_NOSUPPORT

    Call FLASH_ReadID() with flash hw ID 1
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_DEVID

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_RegReadWrite() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_DEVID_REG

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the read device ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP_DEVID

    Call FLASH_Erase() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_ERASE_SECTOR

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the read device ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP_DEVID

    Call FLASH_BlankCheck() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_ERASE_BLANK_CHECK

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Write() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_WRITE_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Read() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Compare the written and read page buffers
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_CMP

    Call FLASH_Compare() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_CMP_PAGE

    Wait until system event is processed
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    and wait till operation result either result ok or failed
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_OK

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_DONE

    Call FLASH_Read() with flash hw ID 1 and relevant parameters
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_ALL_PAGES

    Wait for the first read event to complete
    Call FLASH_StateHandler() with flash hw ID 1

    Call FLASH_Cancel() with flash hw ID 1
    Check Expected Result for #BRCM_SWQTST_FLASH_CANCEL

    Call WaitGetClearEvent() with task ID
    Check Expected Result for #BRCM_SWQTST_FLASH_READ_EVENT_ERR

    Call FLASH_GetOpsResult() with flash hw ID 1 and operation result parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_OPS_RESULT_CANCELLED

    Call FLASH_DeInit() with flash hw ID 1

    Call FLASH_GetStatus() with flash hw ID 1 and status parameter
    Check Expected Result for #BRCM_SWQTST_FLASH_STATUS_UNINIT

    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    2s

    @analyzetime    5h
*/
#define BRCM_SWQTSEQ_FLASH_CTRL1_SEQ2                                       (0x0002)

#endif /* FLASH_QT_H */

/** @} */