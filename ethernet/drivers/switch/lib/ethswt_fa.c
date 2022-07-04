/*****************************************************************************
 Copyright 2020-2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_fa_impl Flow Accelerator Implementation
    @ingroup grp_ethswt

    @addtogroup grp_fa_impl
    @{

    @file ethswt_fa.c
    @brief Flow Accelerator implementation
    This header file contains the implementation of Flow accelerator

    @version 0.1 Initial version
*/

#include <ethswt_fa.h>
#include <ethswt_common_osil.h>
#include <ethswt_fa_osil.h>

/**
    @name Flow Accelerator API IDs
    @{
    @brief API IDs for Flow Accelerator
*/
#define BRCM_SWDSGN_ETHSWT_FAINIT_PROC          (0xB401U)    /**< @brief #ETHSWT_FAInit            */
#define BRCM_SWDSGN_ETHSWT_FADEINIT_PROC        (0xB402U)    /**< @brief #ETHSWT_FADeinit          */
#define BRCM_SWDSGN_ETHSWT_FAFLOWADD_PROC       (0xB403U)    /**< @brief #ETHSWT_FAFlowAdd         */
#define BRCM_SWDSGN_ETHSWT_FAFLOWDELETE_PROC    (0xB404U)    /**< @brief #ETHSWT_FAFlowDelete      */
#define BRCM_SWDSGN_ETHSWT_FAFLOWGET_PROC       (0xB405U)    /**< @brief #ETHSWT_FAFlowGet         */
#define BRCM_SWDSGN_ETHSWT_FASTATS_PROC         (0xB406U)    /**< @brief #ETHSWT_FAStats           */
#define BRCM_SWDSGN_ETHSWT_FATIMER_PROC         (0xB407U)    /**< @brief #ETHSWT_FATimer           */
#define BRCM_SWDSGN_ETHSWT_FAERR_PROC           (0xB408U)    /**< @brief #ETHSWT_FAErr             */
#define BRCM_SWDSGN_ETHSWT_FAMACADD_PROC        (0xB409U)    /**< @brief #ETHSWT_FAMacAdd          */
#define BRCM_SWDSGN_ETHSWT_FAMACDEL_PROC        (0xB40AU)    /**< @brief #ETHSWT_FAMacDelete       */
#define BRCM_SWDSGN_ETHSWT_FAMACPOOLGET_PROC    (0xB40BU)    /**< @brief #ETHSWT_FAMacPoolGet      */
#define BRCM_SWDSGN_ETHSWT_FAENABLEINTR_PROC    (0xB40CU)    /**< @brief #ETHSWT_FAEnableInterrupt */
/** @} */

/** @brief Error report

    This API reports the error

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aApiID      API ID
    @param[in]  aErr        Error value
    @param[in]  aVal0       Value 0
    @param[in]  aVal1       Value 1
    @param[in]  aVal2       Value 2
    @param[in]  aVal3       Value 3

    @return    void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_FAINIT_PROC
    @trace #BRCM_SWARCH_ETHSWT_FADEINIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION

    @code{.unparsed}
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3}
    BCM_ReportError(BCM_SWT_ID, 0U, aApiID, aErr, 4UL, values)
    @endcode
*/
static void ETHSWT_FAErr(uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                      uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4UL] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(BCM_SWT_ID, 0U, aApiID, aErr, 4UL, values);
}
/**
    @trace #BRCM_SWARCH_ETHSWT_FAINIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.cfg = aConfig

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_INIT, &swtIO)
    if (BCM_ERR_OK == retVal)
        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode)
            ret = ETHSWT_EnableBHShift(aSwtID, aFAID, TRUE)
        else
            ret = ETHSWT_EnableBHShift(aSwtID, aFAID, FALSE)
        if (BCM_ERR_OK != retVal)
            ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FAINIT_PROC, retVal, __LINE__,
                    (uint32_t)aSwtID, (uint32_t)aFAID,
                    (uint32_t)aConfig->ctfCfg.mode)
    else
        ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FAINIT_PROC, retVal, __LINE__,
                (uint32_t)aSwtID, (uint32_t)aFAID, 0UL)
    @endcode
*/
void ETHSWT_FAInit(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                   const ETHSWT_FACfgType *const aConfig)
{
    ETHSWT_FAIOType faIO;
    ETHSWT_IOType swtIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.cfg = aConfig;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_INIT, &swtIO);
    if (BCM_ERR_OK == retVal) {
        if (ETHSWT_FACTFMODE_NORMAL == aConfig->ctfCfg.mode) {
            retVal = ETHSWT_EnableBHShift(aSwtID, aFAID, TRUE);
        } else {
            retVal = ETHSWT_EnableBHShift(aSwtID, aFAID, FALSE);
        }

        if (BCM_ERR_OK != retVal) {
            ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FAINIT_PROC, retVal, __LINE__,
                    (uint32_t)aSwtID, (uint32_t)aFAID,
                    (uint32_t)aConfig->ctfCfg.mode);
        }
    } else {
        ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FAINIT_PROC, retVal, __LINE__,
                (uint32_t)aSwtID, (uint32_t)aFAID, 0UL);
    }
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FADEINIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_INITIALISATION

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID

    retVal = ETHSWT_EnableBHShift(aSwtID, aFAID, FALSE)
    if (BCM_ERR_OK == retVal)
        retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_DEINIT, &swtIO)
        if (BCM_ERR_OK != retVal)
            ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FADEINIT_PROC, retVal, __LINE__,
                    (uint32_t)aSwtID, (uint32_t)aFAID, 0UL)
    else
        ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FADEINIT_PROC, retVal, __LINE__,
                (uint32_t)aSwtID, (uint32_t)aFAID, 0UL)
    @endcode
*/
void ETHSWT_FADeinit(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;

    retVal = ETHSWT_EnableBHShift(aSwtID, aFAID, FALSE);
    if (BCM_ERR_OK == retVal) {
        retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_DEINIT, &swtIO);
        if (BCM_ERR_OK != retVal) {
            ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FADEINIT_PROC, retVal, __LINE__,
                    (uint32_t)aSwtID, (uint32_t)aFAID, 0UL);
        }
    } else {
        ETHSWT_FAErr(BRCM_SWDSGN_ETHSWT_FADEINIT_PROC, retVal, __LINE__,
                (uint32_t)aSwtID, (uint32_t)aFAID, 0UL);
    }
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAFLOWADD_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.flowIn = aFlow

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWADD, &swtIO)
    if (BCM_ERR_OK == retVal)
        *aFlowID = faIO.flowID
    return retVal
    @endcode
*/
int32_t ETHSWT_FAFlowAdd(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                         const ETHSWT_FAFlowType *const aFlow,
                         uint16_t *const aFlowID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.flowIn = aFlow;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWADD, &swtIO);
    if (BCM_ERR_OK == retVal) {
        *aFlowID = faIO.flowID;
    }
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAFLOWDELETE_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.flowID = aFlowID

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWDELETE, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAFlowDelete(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                            const uint16_t aFlowID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.flowID = aFlowID;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWDELETE, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAFLOWGET_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.flowID = aFlowID
    faIO.flowOut = aFlow
    faIO.flowStats = aFlowStats

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWGET, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAFlowGet(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                         const uint16_t aFlowID, ETHSWT_FAFlowType *const aFlow,
                         ETHSWT_FAFlowStatsType *const aFlowStats)
{
    ETHSWT_FAIOType faIO;
    ETHSWT_IOType swtIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.flowID = aFlowID;
    faIO.flowOut = aFlow;
    faIO.flowStats = aFlowStats;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_FLOWGET, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FASTATS_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.faStats = aStats

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_STATS, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAStats(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                       ETHSWT_FAStatsType *const aStats,
                       ETHSWT_FAFlowStatusType *const aFlowStatus)
{
    ETHSWT_FAIOType faIO;
    ETHSWT_IOType swtIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.faStats = aStats;
    faIO.flowStatus = aFlowStatus;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_STATS, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FATIMER_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_TIMER, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FATimer(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_TIMER, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAMACADD_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    faIO = {
               .id = aFAID
               .mac = aMac
               .external = aExternal
           }
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_ADD, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAMacAdd(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                        const uint8_t *const aMac, uint32_t aExternal)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO = {
                               .id = aFAID,
                               .mac = aMac,
                               .external = aExternal,
                           };
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_ADD, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAMACDELETE_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    faIO = {
               .id = aFAID
               .mac = aMac
           }
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_DELETE, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAMacDelete(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                           const uint8_t *const aMac)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO = {
                               .id = aFAID,
                               .mac = aMac,
                           };
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_DELETE, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAMACDELETE_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_QUERY

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.poolTableInfo = aPoolTableInfo;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_POOL_GET, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAMacPoolGet(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                            ETHSWT_FAPoolTableInfoType *const aPoolTableInfo)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.poolTableInfo = aPoolTableInfo;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_MAC_POOL_GET, &swtIO);
    return retVal;
}

/**
    @trace #BRCM_SWARCH_ETHSWT_FAENABLEINTR_PROC
    @trace #BRCM_SWREQ_ETHSWT_FA_OPERATIONS

    @code{.unparsed}
    swtIO.swtHwID = aSwtID
    swtIO.retVal = BCM_ERR_UNKNOWN
    swtIO.faIO = &faIO
    faIO.id = aFAID
    faIO.intrFlags = aFlags

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT, &swtIO)
    return retVal
    @endcode
*/
int32_t ETHSWT_FAEnableInterrupt(ETHSWT_HwIDType aSwtID, ETHSWT_FAIDType aFAID,
                                 ETHSWT_FAIntrFlagsType aFlags)
{
    ETHSWT_IOType swtIO;
    ETHSWT_FAIOType faIO;
    int32_t retVal;

    swtIO.swtHwID = aSwtID;
    swtIO.retVal = BCM_ERR_UNKNOWN;
    swtIO.faIO = &faIO;
    faIO.id = aFAID;
    faIO.intrFlags = aFlags;

    retVal = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_FA_ENABLE_INTERRUPT, &swtIO);
    return retVal;
}

/** @} */
