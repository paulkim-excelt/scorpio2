/*****************************************************************************
 Copyright 2019-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_eth_mdio_endpt_impl MDIO Config
    @ingroup grp_eth_cntlrdrv

    @addtogroup grp_eth_mdio_endpt_impl
    @{

    @file mdio_endpt_cfg_test.c
    @brief MDIO Configuration for BCM8910X & BCM8908X

    @version 0.1 Initial version
*/

#include <mdio.h>

/**
    @name BCM8910X MDIO Design IDs
    @{
    @brief Design IDs for BCM8910X MDIO
*/
#define BRCM_SWDSGN_ETHER_BCM8910X_MDIO_CFG_GLOBAL    (0xB801U)    /**< @brief #MDIO_BCM8910XMdioCfg */
#define BRCM_SWDSGN_ETHER_GETMDIOCONFIG_PROC          (0xB802U)    /**< @brief #MDIO_GetMdioConfig   */
/** @} */

/**
    @brief MDIO configurationf for BCM8910X

    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_ENDPOINT
*/
static const MDIO_CfgType MDIO_BCM8910XMdioCfg =
{
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
};

/** @} */


/**
    @addtogroup grp_eth_cntlrdrv_il
    @{
*/

/**
    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_ENDPOINT

    @code{.c}
    if Arguments are NULL
        ret = BCM_ERR_INVAL_PARAMS
    else
        ret = BCM_ERR_OK
        aCfg = MDIO_BCM8910XMdioCfg;
        aCount = 1
    return ret
    @endcode
*/
int32_t MDIO_GetMdioConfig(const MDIO_CfgType **aCfg, uint32_t *aCount)
{
    int32_t retVal;

    if ((NULL == aCfg) || (NULL == aCount)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aCfg = &MDIO_BCM8910XMdioCfg;
        *aCount = 1UL;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @} */
