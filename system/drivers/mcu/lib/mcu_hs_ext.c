/*****************************************************************************
 Copyright 2018-2019 Broadcom Limited.  All rights reserved.

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
    @addtogroup grp_mcudrv_impl
    @{

    @file mcu_hs_ext.c
    @brief MCU Handshake Extension Implementation
    This header file contains MCU Handshake Extension Implementation

    @version 0.86 Imported from docx
*/
#include <inttypes.h>
#include <bcm_err.h>
#include <mcu.h>
#include <mcu_osil.h>

/**
    @name MCU Design IDs
    @{
    @brief Design IDs for MCU
*/
#define BRCM_SWDSGN_MCU_HS_EXT_REPORT_ERROR_PROC    (0xB301U)    /**< @brief #MCU_HsExtReportError */
#define BRCM_SWDSGN_MCU_SETDISPHSSRC_PROC           (0xB302U)    /**< @brief #MCU_SetDispHsSrc     */
#define BRCM_SWDSGN_MCU_DISPHSTRIGGER_PROC          (0xB303U)    /**< @brief #MCU_DispHsTrigger    */
/** @} */

/** @brief MCU Ext Report Error

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aApiID          API ID
    @param[in]      aErr            Error
    @param[in]      aVal0           Related information about the error
    @param[in]      aVal1           Related information about the error
    @param[in]      aVal2           Related information about the error
    @param[in]      aVal3           Related information about the error

    @return void

    @post None

    @limitations None

    @trace  #BRCM_SWARCH_MCU_SETDISPHSSRC_PROC
    @trace  #BRCM_SWARCH_MCU_DISPHSTRIGGER_PROC
    @trace  #BRCM_SWREQ_MCU_HANDSHAKE_EXTENSION
*/
static void MCU_HsExtReportError(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
        uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_MCU_ID & BCM_LOGMASK_USER), MCU_INSTANCE_ID, aApiID, aErr,
            4UL, values);
}

/** @brief Set display handshake

    @trace  #BRCM_SWARCH_MCU_SETDISPHSSRC_PROC
    @trace  #BRCM_SWREQ_MCU_HANDSHAKE_EXTENSION
*/
void MCU_SetDispHsSrc(MCU_CpuDHSChType aChannel,
        MCU_CpuDHSIDType aSrcId)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.channel = aChannel;
    mcuIO.srcID = aSrcId;

    ret = MCU_SysCmdReq(MCU_CMD_SET_DHS_SRC, &mcuIO);
    if (ret != BCM_ERR_OK) {
        MCU_HsExtReportError(BRCM_SWARCH_MCU_SETDISPHSSRC_PROC, ret, 0UL, 0UL, 0UL,
                0UL);
    }
}

/** @brief Display handshake trigger

    @trace  #BRCM_SWARCH_MCU_DISPHSTRIGGER_PROC
    @trace  #BRCM_SWREQ_MCU_HANDSHAKE_EXTENSION
*/
void MCU_DispHsTrigger(MCU_CpuDHSChType aChannel, uint32_t aBufAttr)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.channel = aChannel;
    mcuIO.bufAttr = aBufAttr;

    ret = MCU_SysCmdReq(MCU_CMD_DHS_TRIGGER, &mcuIO);
    if (ret != BCM_ERR_OK) {
        MCU_HsExtReportError(BRCM_SWARCH_MCU_DISPHSTRIGGER_PROC, ret, 0UL, 0UL, 0UL,
                0UL);
    }
}

/** @} */
