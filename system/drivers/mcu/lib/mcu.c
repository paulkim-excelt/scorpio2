/*****************************************************************************
 Copyright 2017-2019 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_mcudrv_impl Implementation
    @ingroup grp_mcudrv

    @addtogroup grp_mcudrv_impl
    @{

    @file mcu.c
    @brief MCU implementation
    This header file contains the implementation of MCU

    @version 0.86 Imported from docx
*/

#include <inttypes.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <mcu.h>
#include <mcu_osil.h>

/**
    @name MCU Design IDs
    @{
    @brief Design IDs for MCU
*/
#define BRCM_SWDSGN_MCU_REPORTERROR_PROC         (0xB201U)    /**< @brief #MCU_ReportError      */
#define BRCM_SWDSGN_MCU_GETVERSION_PROC          (0xB202U)    /**< @brief #MCU_GetVersion       */
#define BRCM_SWDSGN_MCU_RESETREQ_PROC            (0xB203U)    /**< @brief #MCU_ResetReq         */
#define BRCM_SWDSGN_MCU_GETRESETREASON_PROC      (0xB204U)    /**< @brief #MCU_GetResetReason   */
#define BRCM_SWDSGN_MCU_GETRESETRAWVALUE_PROC    (0xB205U)    /**< @brief #MCU_GetResetRawValue */
#define BRCM_SWDSGN_MCU_SETLPMMODE_PROC          (0xB206U)    /**< @brief #MCU_SetLpmMode       */
#define BRCM_SWDSGN_MCU_GETRESETMODE_PROC        (0xB207U)    /**< @brief #MCU_GetResetMode     */
#define BRCM_SWDSGN_MCU_SETRESETMODE_PROC        (0xB208U)    /**< @brief #MCU_SetResetMode     */
#define BRCM_SWDSGN_MCU_GETFWBOOTINFO_PROC       (0xB209U)    /**< @brief #MCU_GetBootInfo      */
#define BRCM_SWDSGN_MCU_GETBOOTTIMEINFO_PROC     (0xB20AU)    /**< @brief #MCU_GetBootTimeInfo  */
#define BRCM_SWDSGN_MCU_ADJUSTCLKFREQ_PROC       (0xB20BU)    /**< @brief #MCU_AdjustClkFreq    */
#define BRCM_SWDSGN_MCU_SET_INFO_PROC            (0xB20CU)    /**< @brief #MCU_SetInfo          */
#define BRCM_SWDSGN_MCU_SET_SECURITY_MODE_PROC   (0xB20DU)    /**< @brief #MCU_SetSecurityMode  */
/** @} */

/** @brief MCU Report Error

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

    @trace  #BRCM_SWARCH_MCU_GETVERSION_PROC
    @trace  #BRCM_SWARCH_MCU_RESETREQ_PROC
    @trace  #BRCM_SWARCH_MCU_GETRESETREASON_PROC
    @trace  #BRCM_SWARCH_MCU_GETRESETRAWVALUE_PROC
    @trace  #BRCM_SWARCH_MCU_SETLPMMODE_PROC
    @trace  #BRCM_SWARCH_MCU_GETRESETMODE_PROC
    @trace  #BRCM_SWARCH_MCU_SETRESETMODE_PROC
    @trace  #BRCM_SWREQ_MCU_KERNEL_INTERFACE
*/
static void MCU_ReportError(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
        uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError((BCM_MCU_ID & BCM_LOGMASK_USER), MCU_INSTANCE_ID, aApiID, aErr,
            4UL, values);
}


/** @brief Reset Request

    @trace  #BRCM_SWARCH_MCU_RESETREQ_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
void MCU_ResetReq(MCU_ResetReqType aResetReq)
{
    int32_t err;
    MCU_IOType mcuIO;

    mcuIO.resetReq = aResetReq;
    err = MCU_SysCmdReq(MCU_CMD_RESET_REQ, &mcuIO);
    if (err != BCM_ERR_OK) {
        MCU_ReportError(BRCM_SWARCH_MCU_RESETREQ_PROC, err, 0UL, 0UL, 0UL, 0UL);
    }
}

/** @brief Get Reset Reason

    @trace  #BRCM_SWARCH_MCU_GETRESETREASON_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY
*/
MCU_ResetReasonType MCU_GetResetReason(void)
{
    MCU_IOType mcuIO;
    int32_t ret;
    MCU_ResetReasonType reason = MCU_RESETREASON_UNDEFINED;

    ret = MCU_SysCmdReq(MCU_CMD_GET_RESET_REASON, &mcuIO);
    if (ret == BCM_ERR_OK) {
        reason = mcuIO.resetReason;
    } else {
        MCU_ReportError(BRCM_SWARCH_MCU_GETRESETREASON_PROC, ret, 0UL, 0UL, 0UL,
                0UL);
    }
    return reason;
}

/** @brief Get Reset Raw Value

    @trace  #BRCM_SWARCH_MCU_GETRESETRAWVALUE_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY
*/
uint32_t MCU_GetResetRawValue(void)
{
    MCU_IOType mcuIO;
    int32_t ret;
    uint32_t raw = 0UL;

    ret = MCU_SysCmdReq(MCU_CMD_GET_RAW_VAL, &mcuIO);
    if (ret == BCM_ERR_OK) {
        raw = mcuIO.resetRaw;
    } else {
        MCU_ReportError(BRCM_SWARCH_MCU_GETRESETRAWVALUE_PROC, ret, 0UL, 0UL, 0UL,
                0UL);
    }
    return raw;
}

/** @brief Set Low Power Mode

    @trace  #BRCM_SWARCH_MCU_SETLPMMODE_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
void MCU_SetLpmMode(MCU_LpmModeType aLpmMode)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.lpmMode = aLpmMode;
    ret = MCU_SysCmdReq(MCU_CMD_SET_LPM_MODE, &mcuIO);
    if (ret != BCM_ERR_OK) {
        MCU_ReportError(BRCM_SWARCH_MCU_SETLPMMODE_PROC, ret, 0UL, 0UL, 0UL, 0UL);
    }
}

/** @brief Get Reset Mode

    @trace  #BRCM_SWARCH_MCU_GETRESETMODE_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY
*/
MCU_ResetModeType MCU_GetResetMode(void)
{
    MCU_IOType mcuIO;
    int32_t ret;
    MCU_ResetModeType resetMode = MCU_RESETMODE_NONE;

    ret =  MCU_SysCmdReq(MCU_CMD_GET_RESET_MODE, &mcuIO);
    if (ret != BCM_ERR_OK) {
         MCU_ReportError(BRCM_SWARCH_MCU_GETRESETMODE_PROC, ret, 0UL, 0UL, 0UL,
                 0UL);
    } else  {
        resetMode = mcuIO.resetMode;
    }

    return resetMode;
}

/** @brief Set Reset Mode

    @trace  #BRCM_SWARCH_MCU_SETRESETMODE_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
void MCU_SetResetMode(MCU_ResetModeType aResetMode)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.resetMode = aResetMode;

    ret = MCU_SysCmdReq(MCU_CMD_SET_RESET_MODE, &mcuIO);
    if (ret != BCM_ERR_OK) {
         MCU_ReportError(BRCM_SWARCH_MCU_SETRESETMODE_PROC, ret, 0UL, 0UL, 0UL,
                 0UL);
    }
}

/** @brief Get FW Boot Info

    @trace  #BRCM_SWARCH_MCU_GETBOOTINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY
*/
int32_t MCU_GetBootInfo(PTBL_IdType *aPid, uint8_t *aFlsId)
{
    MCU_IOType mcuIO;
    int32_t ret = BCM_ERR_INVAL_PARAMS;

    if ((NULL != aPid) && (NULL != aFlsId)) {
        mcuIO.pid = *aPid;
        ret = MCU_SysCmdReq(MCU_CMD_GET_FW_BOOT_INFO, &mcuIO);
        if (BCM_ERR_OK == ret) {
            *aPid = mcuIO.pid;
            *aFlsId = mcuIO.flsId;
        }
    }
    return ret;
}

/** @brief Get Boot Time Info

    @trace  #BRCM_SWARCH_MCU_GETBOOTTIMEINFO_PROC
    @trace  #BRCM_SWREQ_MCU_QUERY
*/
int32_t MCU_GetBootTimeInfo(MCU_BootTimeInfoType *const aBootTime)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.bootTime = aBootTime;

    ret = MCU_SysCmdReq(MCU_CMD_GET_BOOT_TIME, &mcuIO);
    return ret;
}

/** @brief Adjust clock frequency

    @trace #BRCM_SWARCH_MCU_ADJUSTCLKFREQ_PROC
    @trace #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
int32_t MCU_AdjustClkFreq(MCU_ClkCfgIDType aCfgID, int32_t aCorrection)
{
    MCU_IOType mcuIO;
    int32_t ret;

    mcuIO.clkCfgID = aCfgID;
    mcuIO.correction = aCorrection;

    ret = MCU_SysCmdReq(MCU_CMD_ADJUST_CLK, &mcuIO);

    return ret;
}

/** @brief Set Switch info

    @trace  #BRCM_SWARCH_MCU_SET_INFO_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
int32_t MCU_SetInfo(MCU_InfoType *const aInfo)
{
    MCU_IOType mcuIO;
    int32_t retVal;

    mcuIO.info = aInfo;
    retVal = MCU_SysCmdReq(MCU_CMD_SET_INFO, &mcuIO);

    return retVal;
}

/** @brief Set Switch info

    @trace  #BRCM_SWARCH_MCU_SET_SECURITY_MODE_PROC
    @trace  #BRCM_SWREQ_MCU_DYNAMIC_CONFIG
*/
int32_t MCU_SetSecurityMode(MCU_SecurityModeType aMode)
{
    MCU_IOType mcuIO;
    int32_t retVal;

    mcuIO.securityMode = aMode;
    retVal = MCU_SysCmdReq(MCU_CMD_SET_SECURITY_MODE, &mcuIO);

    return retVal;
}

/** @} */
