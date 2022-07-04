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
#ifndef IO_SERVICE_QT_H
#define IO_SERVICE_QT_H

/**
    @brief Initialize IO service client module

    @pre IO service client module is in de-init state

    @test Call IOSRV.client.resetStateHandler

    @post BCM_ERR_BUSY should be returned
          IO service client module is initialized

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_CLIENT_INIT                         (0x0001UL)

/**
    @brief Ready IO service client module for accepting request

    @pre IO service client module is init state

    @test Call IOSRV.client.initStateHandler

    @post BCM_ERR_OK should be returned
          IO service client module is ready for accepting request

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_CLIENT_READY                        (0x0002UL)

/**
    @brief Run IO service client module

    @pre IO service client module is in ready state

    @test Call IOSRV.client.readyStateHandler

    @post BCM_ERR_OK should be returned
          IO service client module is in running state

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_CLIENT_READY_TO_RUN                 (0x0003UL)

/**
    @brief Ready IO service client module

    @pre IO service client module is in running state

    @test Call IOSRV.client.runStateHandler

    @post BCM_ERR_OK should be returned
          IO service client module is in ready state

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_CLIENT_RUN_TO_READY                 (0x0004UL)

/**
    @brief Un-initialize IO service client module

    @pre IO service client module is in ready state

    @test Call IOSRV.client.readyStateHandler

    @post BCM_ERR_OK should be returned
          IO service client module is un-initiliazed

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_CLIENT_UINIT                        (0x0005UL)

/**
    @brief Send command to desired module through IO service server

    @pre IO service client module is in running state

    @test Call IOSRV.server.sendCmd

    @post BCM_ERR_NOSUPPORT should be returned

    @functional Yes

    @type Neg

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_SERVER_SEND_CMD_NOSUPPORT           (0x0006UL)

/**
    @brief Get command response for previous request

    @pre IO service client module is in running state

    @test Call IOSRV.server.getResp

    @post BCM_ERR_NOSUPPORT should be returned

    @functional Yes

    @type Neg

    @trace #BRCM_SWREQ_IOSRV
*/
#define BRCM_SWQTST_IOSRV_SERVER_GET_RESP_NOSUPPORT           (0x0007UL)

/** @brief IO service

    This sequence verifies IO service.

    @code{.c}
    Call IOSRV.client.resetStateHandler() with BCM_STATE_INIT
    Check Expected Result for #BRCM_SWQTST_IOSRV_CLIENT_INIT
    Call IOSRV.client.initStateHandler() with BCM_STATE_READY
    Check Expected Result for #BRCM_SWQTST_IOSRV_CLIENT_READY
    Call IOSRV.client.readyStateHandler() with BCM_STATE_RUN
    Check Expected Result for #BRCM_SWQTST_IOSRV_CLIENT_READY_TO_RUN
    Call IOSRV.server.sendCmd() with invalid parameters
    Check Expected Result for #BRCM_SWQTST_IOSRV_SERVER_SEND_CMD_NOSUPPORT
    Call IOSRV.server.getResp() with valid parameters
    Check Expected Result for #BRCM_SWQTST_IOSRV_SERVER_GET_RESP_NOSUPPORT
    Call IOSRV.server.sendCmd() with valid parameters
    Call IOSRV.client.runStateHandler() with BCM_STATE_READY
    Check Expected Result for #BRCM_SWQTST_IOSRV_CLIENT_RUN_TO_READY
    Call IOSRV.client.readyStateHandler() with BCM_STATE_UNINIT
    Check Expected Result for #BRCM_SWQTST_IOSRV_CLIENT_UINIT
    @endcode

    @auto           Yes

    @type           Sanity

    @executetime    1s

    @analyzetime    10m
*/
#define BRCM_SWQTSEQ_IOSRV_SEQ0                                    (0x0001UL)

#endif /* IO_SERVICE_QT_H */