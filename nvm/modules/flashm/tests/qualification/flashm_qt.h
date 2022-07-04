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

/**
    @defgroup grp_flashm_qt FLASHM qualification Test
    @ingroup grp_flashm

    @addtogroup grp_flashm_qt
    @{

    @file flashm_qt.h

    @board

    @brief FLASH Module qualification Test
    This source file contains the qualification test for FLASH Module
    @version 0.1 Initial draft
*/

#ifndef FLASHM_QT_H
#define FLASHM_QT_H


/**
    @brief Erase the flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Erase the Module FLASHM_Module.sendCmd with FLASHM_CMD_RPC_ERASE cmd

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_RPC_ERASE                                     (0x0000UL)

/**
    @brief Write the flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Erase the Module FLASHM_Module.sendCmd with FLASHM_CMD_RPC_WRITE cmd

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_RPC_WRITE                                     (0x0001UL)

/**
    @brief Read the flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Erase the Module FLASHM_Module.sendCmd with FLASHM_CMD_RPC_READ cmd

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_RPC_READ                                     (0x0002UL)
/**
    @brief Read the flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Erase the Module FLASHM_Module.sendCmd with FLASHM_CMD_RPC_READ cmd

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_RPC_GETRESP                                 (0x0003UL)

/**
    @brief Erase the Image in flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Call FLASHM_ImglHandler.eraseImg

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_IMGL_ERASE                                  (0x0004UL)

/**
    @brief Write Valid Image in flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Call FLASHM_ImglHandler.writeImg

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_IMGL_WRITE                                   (0x0005UL)

/**
    @brief Read Valid Image in flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Call FLASHM_ImglHandler.readImg

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_IMGL_READ                                     (0x0006UL)

/**
    @brief Read Valid PTBL from flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Call FLASHM_ImglHandler.readPtbl

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_IMGL_PTBL_READ                                     (0x0007UL)

/**
    @brief Read Valid ITBL from flash

    @pre FLASH is in Init state
         FLASHM is out of reset state

    @test Call FLASHM_ImglHandler.readItbl

    @post Return should be BCM_ERR_OK

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM

*/
#define BRCM_SWQTST_FLASHM_IMGL_ITBL_READ                                     (0x0008UL)


/**
    @brief Get responce of cmd for aHdl

    @pre FLASH is in Init state
         FLASHM is out of reset state
		 aHdl should be valid

    @test Call FLASHM_ImglHandler.getStatus with valid aHdl

    @post Return should be BCM_ERR_OK/BCM_ERR_BUSY

    @functional Yes

    @type pos

    @trace #BRCM_SWREQ_FLASHM
*/
#define BRCM_SWQTST_FLASHM_GET_IMGL_STATUS                                   (0x0009UL)


/**
  @brief Qualification test sequence for FLASH Module for RPC Interface with FLASH0

  @code{.c}

  Call MODULE_ResetStateHandler(FLASHM_Module)
  Call MODULE_InitStateHandler(FLASHM_Module)
  Call MODULE_ReadyStateHandler(FLASHM_Module, RUN)

  Execute BRCM_SWQTST_FLASHM_RPC_ERASE
  Execute BRCM_SWQTST_FLASHM_RPC_GETRESP
  Execute BRCM_SWQTST_FLASHM_RPC_WRITE
  Execute BRCM_SWQTST_FLASHM_RPC_GETRESP
  Execute BRCM_SWQTST_FLASHM_RPC_READ
  Execute BRCM_SWQTST_FLASHM_RPC_GETRESP

  Call MODULE_RunStateHandler(FLASHM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h
*/

#define BRCM_SWQTSEQ_FLASHM_0                                     (0x0000UL)

/**
  @brief Qualification test sequence for FLASH Module for IMGL Interface with FLASH0

  @code{.c}

  Call MODULE_ResetStateHandler(FLASHM_Module)
  Call MODULE_InitStateHandler(FLASHM_Module)
  Call MODULE_ReadyStateHandler(FLASHM_Module, RUN)

  Execute BRCM_SWQTST_FLASHM_IMGL_ERASE
  Execute BRCM_SWQTST_FLASHM_GET_IMGL_STATUS
  Execute BRCM_SWQTST_FLASHM_IMGL_WRITE
  Execute BRCM_SWQTST_FLASHM_GET_IMGL_STATUS
  Execute BRCM_SWQTST_FLASHM_IMGL_READ
  Execute BRCM_SWQTST_FLASHM_GET_IMGL_STATUS
  Execute BRCM_SWQTST_FLASHM_IMGL_PTBL_READ
  Execute BRCM_SWQTST_FLASHM_GET_IMGL_STATUS
  Execute BRCM_SWQTST_FLASHM_IMGL_ITBL_READ
  Execute BRCM_SWQTST_FLASHM_GET_IMGL_STATUS

  Call MODULE_RunStateHandler(FLASHM_Module, UNINIT)

  @endcode

  @auto           Yes

  @type           Sanity

  @executetime    1s

  @analyzetime    1h
  */
#define BRCM_SWQTSEQ_FLASHM_1                                     (0x0001UL)

/**
  @brief Repeat the Sequence BRCM_SWQTSEQ_FLASHM_0 for FLASH1
*/
#define BRCM_SWQTSEQ_FLASHM_2                                     (0x0002UL)

/**
  @brief Repeat the Sequence BRCM_SWQTSEQ_FLASHM_1 for FLASH1
*/
#define BRCM_SWQTSEQ_FLASHM_3                                     (0x0003UL)

#endif /* FLASHM_QT_H */
/** @} */

