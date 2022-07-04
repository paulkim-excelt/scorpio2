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
    @defgroup grp_eth_mdio_switch_cfg_v2_impl MDIO Config
    @ingroup grp_eth_cntlrdrv

    @addtogroup grp_eth_mdio_switch_cfg_v2_impl
    @{

    @file ether_mdio_switch_cfg_v2.c
    @brief MDIO Configuration for BCM8956X and BCM8957X

    @version 0.1 Initial version
*/

#include <mdio.h>
#include <mcu_switch_ext.h>

/**
    @name BCM8956X MDIO Design IDs
    @{
    @brief Design IDs for BCM8956X MDIO
*/
#define BRCM_SWDSGN_ETHER_BCM89561_MDIO_CFG_GLOBAL      (0xBB01U)    /**< @brief #MDIO_BCM89561MdioCfg        */
#define BRCM_SWDSGN_ETHER_BCM89564GM_MDIO_CFG_GLOBAL    (0xBB02U)    /**< @brief #MDIO_BCM89564GMasterMdioCfg */
#define BRCM_SWDSGN_ETHER_BCM89564GS_MDIO_CFG_GLOBAL    (0xBB03U)    /**< @brief #MDIO_BCM89564GSlaveMdioCfg  */
#define BRCM_SWDSGN_ETHER_GETMDIOCONFIG_PROC            (0xBB04U)    /**< @brief #ETHER_GetMdioConfig          */
/** @} */

/**
    @brief MDIO configurationf for BCM89561

    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_SWITCH
*/
static const MDIO_CfgType MDIO_BCM89561MdioCfg[] =
{
    {
    .mode = MDIO_CTRLMODE_SLAVE,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,

    },
};
/**
    @brief MDIO configurationf for BCM89564G Master

    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_SWITCH
*/
static const MDIO_CfgType MDIO_BCM89564GMasterMdioCfg[] =
{
    {
    .mode = MDIO_CTRLMODE_SLAVE,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_SLAVE,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
};

/**
    @brief MDIO configurationf for BCM89564G Slave

    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_SWITCH
*/
static const MDIO_CfgType MDIO_BCM89564GSlaveMdioCfg[] =
{
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
    {
    .mode = MDIO_CTRLMODE_MASTER,
    .speed = 1000000UL,
    .isSync = FALSE,
    },
};

/** @} */


/**
    @addtogroup grp_eth_cntlrdrv_il
    @{
*/

/**
    @trace #BRCM_SWARCH_ETHER_GETMDIOCONFIG_PROC
    @trace #BRCM_SWREQ_ETHER_MDIO_SWITCH

    @code{.c}
    MCU_InfoType switchInfo;
    ret = MCU_GetInfo(&switchInfo)
    if Arguments are NULL
        ret = BCM_ERR_INVAL_PARAMS
    else if ret == BCM_ERR_OK
        if stackingInof.stackingEn == TRUE
            if switchInfo.mstSlvMode == MASTER
                aCfg = MDIO_BCM89564GMasterMdioCfg
                aCount = 3
            else
                aCfg = MDIO_BCM89564GSlaveMdioCfg
                aCount = 1
        else
            aCfg = MDIO_BCM89561MdioCfg
            aCount = 1
    else
        ret = BCM_ERR_OK
        aCfg = MDIO_BCM89561MdioCfg
        aCount = 1
    return ret
    @endcode
*/
int32_t MDIO_GetMdioConfig(const MDIO_CfgType **aCfg, uint32_t *aCount)
{
    int32_t retVal;
    MCU_InfoType switchInfo;
    retVal = MCU_GetInfo(&switchInfo);

    if ((NULL == aCfg) || (NULL == aCount)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else if (BCM_ERR_OK == retVal) {
        if (TRUE == switchInfo.stackingEn) {
            if (MCU_DEVICE_MASTER == switchInfo.mstSlvMode) {
                *aCfg = &MDIO_BCM89564GMasterMdioCfg[0];
                *aCount = sizeof(MDIO_BCM89564GMasterMdioCfg)/sizeof(MDIO_CfgType);
            } else {
                *aCfg = &MDIO_BCM89564GSlaveMdioCfg[0];
                *aCount = sizeof(MDIO_BCM89564GSlaveMdioCfg)/sizeof(MDIO_CfgType);
            }
        } else {
            *aCfg = &MDIO_BCM89561MdioCfg[0];
            *aCount = sizeof(MDIO_BCM89561MdioCfg)/sizeof(MDIO_CfgType);
        }
    } else {
        /* Assume BCM89561 Device */
        *aCfg = &MDIO_BCM89561MdioCfg[0];
        *aCount = sizeof(MDIO_BCM89561MdioCfg)/sizeof(MDIO_CfgType);
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/** @} */
