/*****************************************************************************
 Copyright 2017-2020 Broadcom Limited.  All rights reserved.

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
/** @defgroup grp_ethswt_common_il Ethernet switch driver Integration implementation
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_common_il
    @{

    @file ethswt_common_osil.c
    @brief Ethernet Switch Driver Integration
    This source file contains the integration of Ethernet Switch Driver to
    system
    @version 0.6 Initial Version
*/

#include <bcm_err.h>
#include <osil/bcm_osil.h>
#include <eth_switch_osil.h>
#ifdef ENABLE_ETHSWT_VLAN
#include <ethswt_vlan_osil.h>
#endif
#ifdef ENABLE_ETHSWT_ARL
#include <ethswt_arl_osil.h>
#endif
#ifdef ENABLE_ETHSWT_DEBUG
#include <ethswt_debug_osil.h>
#endif
#ifdef ENABLE_ETHSWT_XCVR
#include <ethxcvr.h>
#include <ethswt_xcvr_osil.h>
#endif
#ifdef ENABLE_ETHSWT_CFP
#include <ethswt_cfp_osil.h>
#endif
#ifdef ENABLE_ETHSWT_EXT
#include <ethswt_ext_osil.h>
#endif
#ifdef ENABLE_ETHSWT_FA
#include <ethswt_fa_osil.h>
#endif

/**
    @name Design IDs
    @{
    @brief Design IDs
*/
#define BRCM_SWDSGN_ETHSWT_SVCIO_TYPE              (0xA101U)    /**< @brief #ETHSWT_SVCIOType     */
#define BRCM_SWDSGN_ETHSWT_SYS_CMD_HANDLER_PROC    (0xA102U)    /**< @brief #ETHSWT_SysCmdHandler */
/** @} */

/**
    @brief Switch SVC IO type
    Union to avoid MISRA Required error
    for Type conversion

    @trace #BRCM_SWARCH_ETHSWT_SYS_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER
*/
typedef union uETHSWT_SVCIOType {
    uint8_t *data;
    ETHSWT_IOType *io;
} ETHSWT_SVCIOType;

/**
    @brief Sys command handler

    @trace #BRCM_SWARCH_ETHSWT_SYS_CMD_HANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER

    @code{.c}
    if aSysIO is not NULL {
        if aMagicID is SVC_MAGIC_SWT_ID {
            aSysIO.retVal = ETHSWT_CmdHandler(aCmd, aSysIO)
        } else {
            aSysIO.retVal = BCM_ERR_INVAL_MAGIC
        }
    }
    @endcode
*/
void ETHSWT_SysCmdHandler(uint32_t aMagicID, uint32_t aCmd, uint8_t * aSysIO)
{
    ETHSWT_SVCIOType ethSwitch;
    ethSwitch.data = aSysIO;
    int32_t ret = BCM_ERR_NOSUPPORT;
    ETHSWT_IOType *io = NULL;

    if (NULL != aSysIO) {
        io = ethSwitch.io;
        if (SVC_MAGIC_SWT_ID == aMagicID) {
            if (ETHSWT_IO_CMD_INIT == aCmd) {
                ret = ETHSWT_CmdHandler(aCmd, io);
            } else if (ETHSWT_STATE_UNINIT == ETHSWT_GetState(ETHSWT_HW_ID_0)) {
                /* Driver is not initialized */
                ret = BCM_ERR_UNINIT;
            } else {
                if ((aCmd >= ETHSWT_IO_CMD_GET_PORT_MAC_ADDR) &&
                    (aCmd <= ETHSWT_IO_CMD_GET_STICKY_MAC_ADDRESS)) {
#ifdef ETHSWT_ARL_CMD_HANDLER
                    ret = ETHSWT_ARL_CMD_HANDLER(io->swtHwID, aCmd, io->arlIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_ENABLE_VLAN) &&
                           (aCmd <= ETHSWT_IO_CMD_GET_VLAN_HOPPING_DETECT)) {
#ifdef ETHSWT_VLAN_CMD_HANDLER
                    ret = ETHSWT_VLAN_CMD_HANDLER(io->swtHwID, aCmd, io->vlanIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_SET_PORT_MIRROR_CFG) &&
                           (aCmd <= ETHSWT_IO_CMD_GET_LED_STATE)) {
#ifdef ETHSWT_DBG_CMD_HANDLER
                    ret = ETHSWT_DBG_CMD_HANDLER(io->swtHwID, aCmd, io->dbgIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_CFP_INIT) &&
                           (aCmd <= ETHSWT_IO_CMD_CFP_DEINIT)) {
#ifdef ETHSWT_CFP_CMD_HANDLER
                    ret = ETHSWT_CFP_CMD_HANDLER(io->swtHwID, aCmd, io->cfpIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_SET_JUMBO_MODE) &&
                           (aCmd <= ETHSWT_IO_CMD_LINK_STATE_CHANGE_HDLR)) {
#ifdef ETHSWT_XCVR_CMD_HANDLER
                    ret = ETHSWT_XCVR_CMD_HANDLER(io->swtHwID, aCmd, io->xcvrIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_FA_START) &&
                           (aCmd <= ETHSWT_IO_CMD_FA_END)) {
#ifdef ETHSWT_FA_CMD_HANDLER
                    ret = ETHSWT_FA_CMD_HANDLER(io->swtHwID, aCmd, io->faIO);
#endif
                } else if ((aCmd >= ETHSWT_IO_CMD_EXT_CONFIG) &&
                           (aCmd <= ETHSWT_IO_CMD_EXT_CONFIG)) {
#ifdef ETHSWT_EXT_CMD_HANDLER
                    ret = ETHSWT_EXT_CMD_HANDLER(io->swtHwID, aCmd, io->extIO);
#endif
                } else {
                    ret = ETHSWT_CmdHandler(aCmd, ethSwitch.io);
                }
            }
            ethSwitch.io->retVal = ret;
        } else {
            ethSwitch.io->retVal = BCM_ERR_INVAL_MAGIC;
        }
    }
}

/** @} */
