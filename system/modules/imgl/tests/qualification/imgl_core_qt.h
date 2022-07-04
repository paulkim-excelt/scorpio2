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
    @defgroup grp_imgl_qt Qualification Tests
    @ingroup grp_imgl

    @addtogroup grp_imgl_qt
    @{

    @file imgl_core_qt.h
    @brief Loader Qualification Test
    This file contains test cases and test sequences.
    @version 0.1 Initial version
*/

#ifndef IMGL_QT_H
#define IMGL_QT_H

/**
    @brief Initialize the loader

    @pre Atlease one loader module should be present.

    @test Initialize the loader

    @post Loader is initialized. IMGL_Context.isInitialized should be TRUE

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define BRCM_SWQTST_IMGL_INIT             (0x101UL)

/**
    @brief Load the non secure executable

    @pre The required executable should be able to be loaded by the loader module

    @test Load non secure executable

    @post Should get the executable with out errors

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define BRCM_SWQTST_IMGL_NONSECURE_EXE    (0x102UL)

/**
    @brief Load the signed executable

    @pre The required executable should be able to be loaded by the loader module

    @test Load signed executable

    @post Should get the executable with out errors

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define BRCM_SWQTST_IMGL_SIGNED_EXE       (0x103UL)

/**
    @brief Load the encrypted executable

    @pre The required executable should be able to be loaded by the loader module

    @test Load encrypted executable

    @post Should get the executable with out errors

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define BRCM_SWQTST_IMGL_ENCRYPTED_EXE    (0x104UL)

/**
    @brief De-Initialize the loader

    @pre None

    @test De-Initialize the loader

    @post Loader is de-initialized. IMGL_Context.isInitialized should be FALSE

    @functional     Yes

    @type           Pos

    @trace #BRCM_SWREQ_IMGL_CORE
*/
#define BRCM_SWQTST_IMGL_DEINIT           (0x105UL)

/** @brief Verify loader

    Verify loading an executable using any of given loaders.

    @code{.c}

    Get one loader module information

    Initiaze loader
    For expected results refer to #BRCM_SWQTST_IMGL_INIT

    Load the non secure executable
    For expected results refer to #BRCM_SWQTST_IMGL_NONSECURE_EXE

    Set Public key information

    Load the signed executable
    For expected results refer to #BRCM_SWQTST_IMGL_SIGNED_EXE

    Set decrypt key information
    Load the encrypted executable
    For expected results refer to #BRCM_SWQTST_IMGL_ENCRYPTED_EXE

    De-Initiaze loader
    For expected results refer to #BRCM_SWQTST_IMGL_DEINIT

    @endcode

    @board bcm89561_evk
    @board bcm89531_evk

    @auto           No

    @type           Sanity

    @executetime    30m

    @analyzetime    30m

*/
#define BRCM_SWQTSEQ_IMGL_SEQ0            (0x106UL)

#endif /* IMGL_QT_H */

/** @} */
