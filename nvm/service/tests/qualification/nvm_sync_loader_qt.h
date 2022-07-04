/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_flash_loader_qt Qualification Tests
    @ingroup grp_imgl

    @addtogroup grp_flash_loader_qt
    @{

    @file flash_loader_qt.h
    @brief Flash loader Qualification Test
    This file contains test cases and test sequences.
    @version 0.1 Initial version
*/

#ifndef FLASH_IMGL_QT_H
#define FLASH_IMGL_QT_H

/**
    @brief Load the image from flash

    @pre Image should be present in flash

    @test Load an image

    @post Should get the image with out errors

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_FLSLDR
*/
#define BRCM_SWQTST_FLSLDR_LOAD_IMAGE       (0x101UL)

/**
    @brief Grafceful exit if the image is not present in flash

    @pre Image should not be present in flash

    @test Grafceful exit if image is not present in flash.
          That is the image offset is more than the flash size.

    @post Should return with #BCM_ERR_UNKNOWN

    @functional     Yes

    @type           Neg

    @trace #BRCM_SWREQ_FLSLDR
*/
#define BRCM_SWQTST_FLSLDR_GRACEFUL_EXIT    (0x102UL)

/** @brief Verify loading an executable using flash loader

    Verify loading an executable using flash loader if its
    possible or graceful exit if its not.

    @code{.c}

    Get flash loader information

    Initialize the flash loader

    Assert state of flash loader to be #IMGL_STATE_INIT

    Fetch PTBL

    Fetch ITBL

    Fetch an image which is present
    For expected results refer to #BRCM_SWQTST_FLSLDR_LOAD_IMAGE

    Fetch an image which is not present
    For expected results refer to #BRCM_SWQTST_FLSLDR_GRACEFUL_EXIT

    De-Initialize flash loader

    @endcode

    @board bcm89561_evk
    @board bcm89531_evk

    @auto           No

    @type           Sanity

    @executetime    15m

    @analyzetime    15m

*/
#define BRCM_SWQTSEQ_FLSLDR_SEQ0            (0x103UL)

#endif /* FLASH_IMGL_QT_H */

/** @} */
