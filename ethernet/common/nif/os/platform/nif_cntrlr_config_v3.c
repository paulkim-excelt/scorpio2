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
    @defgroup grp_nif_cntrlr_config_v3 NIF module platform for bcm8956x and bcm8957x
    @ingroup grp_nif

    @addtogroup grp_nif_cntrlr_config_v3
    @{

    @file nif_cntrlr_config_v3.c
    @brief This file implements platform layer for bcm8956x and bcm8957x

    @version 0.1 Initial draft
*/

#include <stddef.h>
#include <inttypes.h>
#include <nif_cntrlr_platform.h>

/**
    @name Ether NIF module OSIL Design IDs
    @{
    @brief Design IDs for Ether module OSIL
*/
#define BRCM_SWDSGN_NIF_CONFIG_GLOBAL    (0xB701U)    /**< @brief #NIF_Config */
/** @} */

/**
    @trace #BRCM_SWARCH_NIF_CONFIG_GLOBAL
    @trace #BRCM_SWREQ_NIF_CNTRLR
*/
const ETHER_CfgType NIF_Config = {
    .hwID = ETHER_HW_ID_0,
    .speed = ETHER_SPEED_1000MBPS,
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = NIF_RX_MAX_FRM_SIZE,
    .macAddr = NIF_DefaultMacAddr,
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
};

/** @} */
