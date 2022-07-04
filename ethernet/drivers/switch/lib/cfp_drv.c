/*****************************************************************************
 Copyright 2018-2021 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_cfp_impl CFP Driver implementation
    @ingroup grp_ethswt

    @addtogroup grp_ethswt_cfp_impl
    @{

    @file cfp_drv.c

    @brief CFP Driver

    @version 0.1 Initial version
*/

#include <bcm_err.h>
#include <bcm_utils.h>
#include <switch_rdb.h>
#include <ethswt_cfp_osil.h>
#include "switch_drv.h"
#include "cfp_drv.h"

/**
    @name CFP Driver Design IDs
    @{
    @brief Design IDs for CFP
*/
#define BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMTCAM_PART_PROC               (0xB301U)    /**< @brief #ETHSWT_CFPDrvProgramTCAM             */
#define BRCM_SWDSGN_ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK_MACRO        (0xB302U)    /**< @brief #ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMACTIONPOLICYRAM_PART_PROC    (0xB303U)    /**< @brief #ETHSWT_CFPDrvProgramActionPolicyRAM  */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMRATEMETERRAM_PART_PROC       (0xB304U)    /**< @brief #ETHSWT_CFPDrvProgramRateMeterRAM     */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMUDFS_PROC                    (0xB305U)    /**< @brief #ETHSWT_CFPDrvProgramUDFs             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVGETFORMAT_PART_PROC                 (0xB306U)    /**< @brief #ETHSWT_CFPDrvGetFormat               */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVWAITFORACCESS_PART_PROC             (0xB307U)    /**< @brief #ETHSWT_CFPDrvWaitForAccess           */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVCHECKIFRULEEXISTS_PART_PROC         (0xB308U)    /**< @brief #ETHSWT_CFPDrvCheckIfRuleExists       */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVINSERTRULE_PART_PROC                (0xB309U)    /**< @brief #ETHSWT_CFPDrvInsertRule              */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVCOPYRULE_PART_PROC                  (0xB30AU)    /**< @brief #ETHSWT_CFPDrvCopyRule                */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVALLOCATEROW_PART_PROC               (0xB30BU)    /**< @brief #ETHSWT_CFPDrvAllocateRow             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVSETSTATS_PART_PROC                  (0xB30CU)    /**< @brief #ETHSWT_CFPDrvSetStats                */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVSETRULEVALID_PART_PROC              (0xB30DU)    /**< @brief #ETHSWT_CFPDrvSetRuleValid            */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEKEY_PROC                    (0xB30EU)    /**< @brief #ETHSWT_CFPDrvValidateKey             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEDSTMAPFLAGS_PART_PROC       (0xB30FU)    /**< @brief #ETHSWT_CFPDrvValidateDstMapFlags     */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATECOLOR_PART_PROC             (0xB310U)    /**< @brief #ETHSWT_CFPDrvValidateColor           */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEUDFBASE_PART_PROC           (0xB311U)    /**< @brief #ETHSWT_CFPDrvValidateUDFBase         */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEPKTLENCORR_PART_PROC        (0xB312U)    /**< @brief #ETHSWT_CFPDrvValidatePktLenCorr      */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVCHECKACCEPTABLEFRAME_PART_PROC      (0xB313U)    /**< @brief #ETHSWT_CFPDrvCheckAcceptableFrame    */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEL2L3FRAMING_PART_PROC       (0xB314U)    /**< @brief #ETHSWT_CFPDrvValidateL2L3Framing     */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVRESETANDCLEARTCAM_PART_PROC         (0xB315U)    /**< @brief #ETHSWT_CFPDrvResetAndClearTCAM       */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMRULE_PART_PROC               (0xB316U)    /**< @brief #ETHSWT_CFPDrvProgramRule             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVCHECKIFRULEISSTATIC_PART_PROC       (0xB317U)    /**< @brief #ETHSWT_CFPDrvCheckIfRuleIsStatic     */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVREPORTERROR_PART_PROC               (0xB318U)    /**< @brief #ETHSWT_CFPDrvReportError             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVINIT_PROC                           (0xB319U)    /**< @brief #ETHSWT_CFPDrvInit                    */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVADDRULE_PROC                        (0xB31AU)    /**< @brief #ETHSWT_CFPDrvAddRule                 */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVREMOVERULE_PROC                     (0xB31BU)    /**< @brief #ETHSWT_CFPDrvRemoveRule              */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVUPDATERULE_PROC                     (0xB31CU)    /**< @brief #ETHSWT_CFPDrvUpdateRule              */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVGETSTATS_PROC                       (0xB31DU)    /**< @brief #ETHSWT_CFPDrvGetStats                */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVGETKEY_PROC                         (0xB31EU)    /**< @brief #ETHSWT_CFPDrvGetKey                  */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVGETSNAPSHOT_PART_PROC               (0xB31FU)    /**< @brief #ETHSWT_CFPDrvGetSnapshot             */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVENABLEPORT_PROC                     (0xB320U)    /**< @brief #ETHSWT_CFPDrvEnablePort              */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVDISABLEPORT_PROC                    (0xB321U)    /**< @brief #ETHSWT_CFPDrvDisablePort             */
#define BRCM_SWDSGN_ETHSWT_CFP_INIT_PROC                              (0xB322U)    /**< @brief #ETHSWT_CFPInit                       */
#define BRCM_SWDSGN_ETHSWT_CFP_ADD_RULE                               (0xB323U)    /**< @brief #ETHSWT_CFPAddRule                    */
#define BRCM_SWDSGN_ETHSWT_CFP_REMOVE_RULE_PROC                       (0xB324U)    /**< @brief #ETHSWT_CFPRemoveRule                 */
#define BRCM_SWDSGN_ETHSWT_CFP_UPDATE_RULE_PROC                       (0xB325U)    /**< @brief #ETHSWT_CFPUpdateRule                 */
#define BRCM_SWDSGN_ETHSWT_CFP_GET_STATS_PROC                         (0xB326U)    /**< @brief #ETHSWT_CFPGetStats                   */
#define BRCM_SWDSGN_ETHSWT_CFP_GET_ROW_CONFIG_PROC                    (0xB327U)    /**< @brief #ETHSWT_CFPGetRowConfig               */
#define BRCM_SWDSGN_ETHSWT_CFP_GET_SNAPSHOT_PROC                      (0xB328U)    /**< @brief #ETHSWT_CFPGetSnapshot                */
#define BRCM_SWDSGN_ETHSWT_CFP_ENABLE_PORT_PROC                       (0xB329U)    /**< @brief #ETHSWT_CFPEnablePort                 */
#define BRCM_SWDSGN_ETHSWT_CFP_DISABLE_PORT_PROC                      (0xB32AU)    /**< @brief #ETHSWT_CFPDisablePort                */
#define BRCM_SWDSGN_ETHSWT_CFP_DEINIT_PROC                            (0xB32BU)    /**< @brief #ETHSWT_CFPDeInit                     */
#define BRCM_SWDSGN_ETHSWT_CFP_CMD_HANDLER_PROC                       (0xB32CU)    /**< @brief #ETHSWT_CFPCmdHandler                 */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVDEINIT_PROC                         (0xB32DU)    /**< @brief #ETHSWT_CFPDrvDeInit                  */
#define BRCM_SWDSGN_ETHSWT_CFP_RDWR_TIMEOUT_MACRO                     (0xB32EU)    /**< @brief #ETHSWT_CFP_RDWR_TIMEOUT              */
#define BRCM_SWDSGN_ETHSWT_CFP_ERR_EXIT_MACRO                         (0xB32FU)    /**< @brief #ETHSWT_CFP_ERR_EXIT                  */
#define BRCM_SWDSGN_ETHSWT_CFP_HANDLE_GLOBAL                          (0xB330U)    /**< @brief #ETHSWT_CFPHandle                     */
#define BRCM_SWDSGN_ETHSWT_CFP_NUM_FORMATS_MACRO                      (0xB331U)    /**< @brief #ETHSWT_CFP_NUM_FORMATS               */
#define BRCM_SWDSGN_ETHSWT_CFP_STATE_TYPE                             (0xB332U)    /**< @brief #ETHSWT_CFPStateType                  */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVGETACTION_PROC                      (0xB333U)    /**< @brief #ETHSWT_CFPDrvGetAction               */
#define BRCM_SWDSGN_ETHSWT_CFP_RULEDATA_TYPE                          (0xB334U)    /**< @brief #ETHSWT_CFPRuleDataType               */
#define BRCM_SWDSGN_ETHSWT_CFP_CONTEXT_TYPE                           (0xB335U)    /**< @brief #ETHSWT_CFPContextType                */
#define BRCM_SWDSGN_ETHSWT_CFP_REGS_GLOBAL                            (0xB336U)    /**< @brief #ETHSWT_CFPRegs                       */
#define BRCM_SWDSGN_ETHSWT_CFP_ACCEPTABLEFRAME_TYPE                   (0xB337U)    /**< @brief #ETHSWT_CFPAcceptableFrameType        */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVAFTTOTAGSTATUS_PART_PROC            (0xB338U)    /**< @brief #ETHSWT_CFPDrvAFTtoTagStatus          */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVTAGSTATUSTOAFT_PART_PROC            (0xB339U)    /**< @brief #ETHSWT_CFPDrvTagStatustoAFT          */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEACTION_PROC                 (0xB33AU)    /**< @brief #ETHSWT_CFPDrvValidateAction          */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVFINDSLICE_PROC                      (0xB33BU)    /**< @brief #ETHSWT_CFPDrvFindSlice               */
#define BRCM_SWDSGN_ETHSWT_CFP_DRVSETTBLSIZE_PROC                     (0xB33CU)    /**< @brief #ETHSWT_CFPDrvSetTblSize              */
/** @} */

/**
    @name Definitions for CFP Acceptable Frame Type
    @{
    @brief Definitions for CFP Acceptable Frame Type.
           Combination of Un-Tagged and VLAN-Tagged type is not possible
           due to hardware constraint.

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint32_t ETHSWT_CFPAcceptableFrameType;                         /**< @brief typedef for Acceptable Frame */
#define ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED                     (1UL)   /**< @brief Un-Tagged type, Tag status value = 0UL, Tag status mask = 3UL*/
#define ETHSWT_CFP_ACCEPTABLEFRAME_PRIO_TAGGED                  (2UL)   /**< @brief Priority-Tagged type, Tag status value = 1UL, Tag status mask = 3UL */
#define ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED_OR_PRIO_TAGGED      (3UL)   /**< @brief Un-Tagged or Priority-Tagged type, Tag status value = 0UL,
                                                                             Tag status mask = 2UL */
#define ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_TAGGED                  (4UL)   /**< @brief VLAN-Tagged type, Tag status value = 3UL, Tag status mask = 3UL */
#define ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_OR_PRIO_TAGGED          (6UL)   /**< @brief VLAN-Tagged or Priority-Tagged type, Tag status value = 1UL,
                                                                             Tag status mask = 1UL */
#define ETHSWT_CFP_ACCEPTABLEFRAME_ALL                          (7UL)   /**< @brief Un-Tagged, VLAN-Tagged or Priority-Tagged type,
                                                                             Tag status value = 0UL, Tag status mask =  0UL */
#define ETHSWT_CFP_ACCEPTABLEFRAME_INVALID                      (5UL)   /**< @brief Invalid Tagged Frame*/
/** @} */

/**
    @brief Macro to acceptable-Frame-bit-map mask

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK    ((ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK)  | \
                                                (ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK) | \
                                                (ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK)) /**< @brief Mask for the status field in the tag parameter */

/**
    @brief Timeout for CFP RAM access

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_CFP_RDWR_TIMEOUT             (8000UL)

/**
    @brief Macro to check a function's return value and jump to the err_exit
    label in case of error return

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
#define ETHSWT_CFP_ERR_EXIT(fn_ret)                \
    if (((ret) = (fn_ret)) != BCM_ERR_OK) { line = __LINE__; goto err_exit;}

/**
    @name State for the CFP module
    @{
    @brief State for the CFP module

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint32_t ETHSWT_CFPStateType;           /**< @brief typedef for CFP state */
#define ETHSWT_CFP_STATE_RESET          (0UL)   /**< @brief Reset state           */
#define ETHSWT_CFP_STATE_INITIALIZED    (1UL)   /**< @brief Initialized state     */
/** @} */

/**
    @name Cache per rule
    @{
    @brief Cache per rule
    Stores information required per rule at run time in the following format
    enable (1) | static (1) | slice (2) | format (2) |  resv (1) | udfMap (9)

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef uint16_t ETHSWT_CFPRuleDataType;                /**< @brief typedef for CFP rule data */
#define ETHSWT_CFP_RULEDATA_ENABLE_SHIFT    (15U)       /**< @brief Shift for enable field    */
#define ETHSWT_CFP_RULEDATA_ENABLE_MASK     (0x8000U)   /**< @brief Mask for enable field     */
#define ETHSWT_CFP_RULEDATA_STATIC_SHIFT    (14U)       /**< @brief Shift for static field    */
#define ETHSWT_CFP_RULEDATA_STATIC_MASK     (0x4000U)   /**< @brief Mask for static field     */
#define ETHSWT_CFP_RULEDATA_SLICE_SHIFT     (12U)       /**< @brief Shift for slice field     */
#define ETHSWT_CFP_RULEDATA_SLICE_MASK      (0x3000U)   /**< @brief Mask for slice field      */
#define ETHSWT_CFP_RULEDATA_FORMAT_SHIFT    (10U)       /**< @brief Shift for format field    */
#define ETHSWT_CFP_RULEDATA_FORMAT_MASK     (0x0C00U)   /**< @brief Mask for format field     */
#define ETHSWT_CFP_RULEDATA_UDFMAP_SHIFT    (0U)        /**< @brief Shift for UDF map field   */
#define ETHSWT_CFP_RULEDATA_UDFMAP_MASK     (0x1FFU)    /**< @brief Mask for UDF map field    */
/** @} */

/**
    @brief Structure for CFP context

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_UDFQUEUEENTRY_TYPE
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
typedef struct sETHSWT_CFPContextType {
    ETHSWT_CFPStateType             state;                              /**< @brief State of the
                                                                             module */
    uint32_t                        numRules;                           /**< @brief Number of rules
                                                                             currently programmed */
    ETHSWT_CFPUDFAllocListType      udfList[ETHSWT_CFP_NUM_FORMATS];    /**< @brief Global list of
                                                                             UDF allocation across
                                                                             all formats and slices*/
    ETHSWT_CFPRuleDataType          rules[ETHSWT_CFP_MAX_RULES];        /**< @brief Cached context
                                                                             for each rule */
    uint32_t                        numAllowedRules;                    /**< @brief Maximum number of
                                                                             allowed rules */
} ETHSWT_CFPContextType;

/**
    @brief Switch registers

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static SWITCH_RDBType *const ETHSWT_CFPRegs = (SWITCH_RDBType *)SWITCH_BASE;

/**
    @brief CFP Handle

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static ETHSWT_CFPContextType ETHSWT_CFPHandle COMP_SECTION(".bss.drivers.cfp");

/** @brief CFP Driver report error

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aCompID         Component ID
    @param[in]      aInstanceID     Instance ID
    @param[in]      aApiID          API ID
    @param[in]      aErr            Error
    @param[in]      aVal0           Related information about the error
    @param[in]      aVal1           Related information about the error
    @param[in]      aVal2           Related information about the error
    @param[in]      aVal3           Related information about the error

    @return void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_INIT_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_ADD_RULE_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_REMOVE_RULE_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_UPDATE_RULE_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_STATS_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_ROW_CONFIG_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_SNAPSHOT_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_ENABLE_PORT_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_DISABLE_PORT_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_DEINIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
static void ETHSWT_CFPDrvReportError(uint16_t aCompID, uint32_t aInstanceID,
                     uint16_t aApiID, int32_t aErr, uint32_t aVal0,
                     uint32_t aVal1, uint32_t aVal2, uint32_t aVal3)
{
    const uint32_t values[4] = {aVal0, aVal1, aVal2, aVal3};
    BCM_ReportError(aCompID, (uint8_t)aInstanceID, aApiID, aErr, 4UL, values);
}

/** @brief Reset and Clear TCAM

    @behavior Sync, Re-entrant

    @pre None

    This API disables the CFP lookup on all ports. It then resets and
    clears the TCAM.

    @param[in]     aID               Switch index

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             TCAM reset and cleared successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    disable CFP
    reset and clear CFP
    wait for operation to complete
    @endcode
*/
static int32_t ETHSWT_CFPDrvResetAndClearTCAM(ETHSWT_HwIDType aID)
{
    uint32_t regVal32;
    uint16_t regVal16;
    uint32_t line    = 0UL;
    uint32_t timeout = 0UL;
    int32_t  ret     = BCM_ERR_OK;

    /* First disable the CFP on all ports: Software is not allowed to reset */
    /* TCAM in the middle of CFP lookup                                     */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, &regVal16));
    regVal16 &= (uint16_t)~(SWITCH_PAGE_A1_CFP_CTL_REG_EN_MAP_MASK);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, regVal16));

    /* Reset & Clear the CFP RAM */
    regVal32 = SWITCH_PAGE_A0_CFP_ACC_RAM_CLEAR_MASK
                | SWITCH_PAGE_A0_CFP_ACC_TCAM_RST_MASK;
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc, regVal32));

    /* Poll for the Reset/Clear to complete */
    while (timeout < ETHSWT_CFP_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc, &regVal32);
        if ((ret != BCM_ERR_OK) ||
            ((regVal32 & (SWITCH_PAGE_A0_CFP_ACC_TCAM_RST_MASK
                        |SWITCH_PAGE_A0_CFP_ACC_RAM_CLEAR_MASK)) == 0UL)) {
            break;
        }
        timeout++;
    }

    if (timeout == ETHSWT_CFP_RDWR_TIMEOUT) {
        ret = BCM_ERR_TIME_OUT;
        line = __LINE__;
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVRESETANDCLEARTCAM_PART_PROC, ret,
                        line, (uint32_t)ETHSWT_CFPHandle.state, 0UL, 0UL);
    }
    return ret;
}


/** @brief Get format from L3 framing type

    @behavior Sync, Re-entrant

    @pre None

    This API converts the L3 framing type to CFP format type

    @param[in]     aL3Framing        L3 framing type
    @param[out]    aFormat           CFP format type

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             CFP format returned successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid aL3Framing

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    Map L3framing values to format as follows:
        ETHSWT_CFP_L3FRAMING_IPV4 -> 0
        ETHSWT_CFP_L3FRAMING_IPV6 -> 1
        ETHSWT_CFP_L3FRAMING_NONIP -> 2
        others -> error
    @endcode
*/
static int32_t ETHSWT_CFPDrvGetFormat(ETHSWT_CFPL3FramingType aL3Framing,
                                uint32_t* const aFormat)
{
    int32_t ret = BCM_ERR_OK;

    switch(aL3Framing) {
        case ETHSWT_CFP_L3FRAMING_IPV4:
            *aFormat = 0UL;
            break;
        case ETHSWT_CFP_L3FRAMING_IPV6:
            *aFormat = 1UL;
            break;
        case ETHSWT_CFP_L3FRAMING_NONIP:
            *aFormat = 2UL;
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
    }
    return ret;
}

/** @brief Validate destination map flags value

    @behavior Sync, Re-entrant

    @pre None

    This API validates the input destination map flags value

    @param[in]     aID               Switch index
    @param[in]     aFlags            Destination map flags value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if fwdMap is in [ETHSWT_CFP_CHANGEFWDMAP_NON, ETHSWT_CFP_CHANGEFWDMAP_REP]
        return SUCCESS
    else if fwdMap is in [ETHSWT_CFP_CHANGEFWDMAP_REM, ETHSWT_CFP_CHANGEFWDMAP_ADD]
        if dstMap is not 0
            return SUCCESS
    return FAIL
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidateDstMapFlags(ETHSWT_HwIDType aID,
                                          uint32_t aFlags)
{
    int32_t  ret         = BCM_ERR_INVAL_PARAMS;
    uint32_t dstMap      = (aFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT;
    uint32_t changFwdMap = (aFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >> ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT;

    if ((ETHSWT_CFP_CHANGEFWDMAP_NON == changFwdMap) ||
        (ETHSWT_CFP_CHANGEFWDMAP_REP == changFwdMap)) {
        ret = BCM_ERR_OK;
    } else {
        if (0U != dstMap) {
            ret = BCM_ERR_OK;
        }
    }
    return ret;
}

/** @brief Validate UDF base value

    @behavior Sync, Re-entrant

    @pre None

    This API validates the input UDF base value

    @param[in]     aID               Switch index
    @param[in]     aBase             UDF base value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if value is not in [ETHSWT_CFP_UDFBASE_SOP, ETHSWT_CFP_UDFBASE_ENDL2HDR, ETHSWT_CFP_UDFBASE_ENDL3HDR]
        return error
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidateUDFBase(ETHSWT_HwIDType aID,
                                      ETHSWT_CFPUDFBaseType aBase)
{
    int32_t ret;

    switch (aBase) {
        case ETHSWT_CFP_UDFBASE_SOP:
        case ETHSWT_CFP_UDFBASE_ENDL2HDR:
        case ETHSWT_CFP_UDFBASE_ENDL3HDR:
            ret = BCM_ERR_OK;
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
    }

    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEUDFBASE_PART_PROC,
                        ret, (uint32_t)aBase, 0UL, 0UL, 0UL);
    }
    return ret;
}

/** @brief Validate Acceptable Frame

    @behavior Sync, Re-entrant

    @pre None

    This API Validate Acceptable Frame

    @param[in]     aID               Switch index
    @param[in]     frame             Acceptable Frame

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if value is not in [ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED, ETHSWT_CFP_ACCEPTABLEFRAME_PRIO_TAGGED,
                        ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED_OR_PRIO_TAGGED,ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_TAGGED,ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_OR_PRIO_TAGGED,ETHSWT_CFP_ACCEPTABLEFRAME_ALL]
        return error
    @endcode
*/
static int32_t ETHSWT_CFPDrvCheckAcceptableFrame(ETHSWT_HwIDType aID,
                                        ETHSWT_CFPAcceptableFrameType frame)
{
    int32_t ret = BCM_ERR_OK;

    if ((ETHSWT_CFP_ACCEPTABLEFRAME_INVALID == frame) || (0U == frame)) {
        ret = BCM_ERR_INVAL_PARAMS;
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVCHECKACCEPTABLEFRAME_PART_PROC,
                        ret, (uint32_t)frame, 0UL, 0UL, 0UL);
    }
    return ret;
}

/** @brief Convert Acceptable Frame Type to tagstatus value and tagstatus mask

    @behavior Sync, Re-entrant

    @pre None

    This API Convert Acceptable Frame Type to tagstatus value and tagstatus mask

    @param[in]     aID                Switch index
    @param[in]     frame              Acceptable Frame
    @param[out]    tagstatusVal       Tag Status Value
    @param[out]    tagstatusMask      Tag Status Mask

    @retval  None

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_CFPDrvAFTtoTagStatus(ETHSWT_HwIDType aID, ETHSWT_CFPAcceptableFrameType frame, uint32_t *tagStatusVal, uint32_t *tagStatusMask)
{
    switch(frame) {
        case ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED:
            *tagStatusVal  = 0UL;
            *tagStatusMask = 3UL;
            break;
        case ETHSWT_CFP_ACCEPTABLEFRAME_PRIO_TAGGED:
            *tagStatusVal  = 1UL;
            *tagStatusMask = 3UL;
            break;
        case ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED_OR_PRIO_TAGGED:
            *tagStatusVal  = 0UL;
            *tagStatusMask = 2UL;
            break;
        case ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_TAGGED:
            *tagStatusVal  = 3UL;
            *tagStatusMask = 3UL;
            break;
        case ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_OR_PRIO_TAGGED:
            *tagStatusVal  = 1UL;
            *tagStatusMask = 1UL;
            break;
        default:
            /* case ETHSWT_CFP_ACCEPTABLEFRAME_ALL */
            *tagStatusVal  = 0UL;
            *tagStatusMask = 0UL;
            break;
    }
}

/** @brief Convert tagstatus value and tagstatus mask to Acceptable Frame

    @behavior Sync, Re-entrant

    @pre None

    This API Convert tagstatus value and tagstatus mask to Acceptable Frame

    @param[in]    aID                 Switch index
    @param[in]    tagstatusVal        Tag Status Value
    @param[in]    tagstatusMask       Tag Status Mask

    @return  #ETHSWT_CFPAcceptableFrameType Acceptable Frame

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @limitations None

    @code{.unparsed}
    @endcode
*/
static ETHSWT_CFPAcceptableFrameType ETHSWT_CFPDrvTagStatustoAFT(ETHSWT_HwIDType aID, uint32_t tagStatusVal, uint32_t tagStatusMask)
{
    ETHSWT_CFPAcceptableFrameType frame;

    if((0UL == tagStatusVal) && (3UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED;
    }
    else if((1UL == tagStatusVal) && (3UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_PRIO_TAGGED;
    }
    else if((0UL == tagStatusVal) && (2UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_UNTAGGED_OR_PRIO_TAGGED;
    }
    else if((3UL == tagStatusVal) && (3UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_TAGGED;
    }
    else if((1UL == tagStatusVal) && (1UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_VLAN_OR_PRIO_TAGGED;
    }
    else if((0UL == tagStatusVal) && (0UL == tagStatusMask)) {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_ALL;
    }
    else {
        frame = ETHSWT_CFP_ACCEPTABLEFRAME_INVALID;
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                BRCM_SWDSGN_ETHSWT_CFP_DRVTAGSTATUSTOAFT_PART_PROC,
                BCM_ERR_DATA_INTEG, (uint32_t)tagStatusVal, (uint32_t)tagStatusMask, 0UL, 0UL);
    }
    return frame;
}

/** @brief Validate L2 and L3 framing values

    @behavior Sync, Re-entrant

    @pre None

    This API validates the input L2 and L3 framing values

    @param[in]     aID               Switch index
    @param[in]     aL2Framing        L2 framing value
    @param[in]     aL3Framing        L3 framing value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if L3 framing == Non-IP
        if L2 framing is not in [ETHSWT_CFP_L2FRAMING_DIXV2, ETHSWT_CFP_L2FRAMING_DIXV2,
                            ETHSWT_CFP_L2FRAMING_SNAP_PVT, ETHSWT_CFP_L2FRAMING_LLC]
        return error
    elseif L3 framing == IPv6 or IPv4
        if L2 framing is not in [ETHSWT_CFP_L2FRAMING_DIXV2, ETHSWT_CFP_L2FRAMING_DIXV2]
        return error
    else
        return error
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidateL2L3Framing(ETHSWT_HwIDType aID,
                                          ETHSWT_CFPL2FramingType aL2Framing,
                                          ETHSWT_CFPL3FramingType aL3Framing)
{
    int32_t ret;

    if (ETHSWT_CFP_L3FRAMING_NONIP == aL3Framing) {
        switch (aL2Framing) {
            case ETHSWT_CFP_L2FRAMING_DIXV2:
            case ETHSWT_CFP_L2FRAMING_SNAP_PUB:
            case ETHSWT_CFP_L2FRAMING_LLC:
            case ETHSWT_CFP_L2FRAMING_SNAP_PVT:
                ret = BCM_ERR_OK;
                break;
            default:
                ret = BCM_ERR_INVAL_PARAMS;
                break;
        }
    } else if ((ETHSWT_CFP_L3FRAMING_IPV4 == aL3Framing) ||
               (ETHSWT_CFP_L3FRAMING_IPV6 == aL3Framing)) {
        switch (aL2Framing) {
            case ETHSWT_CFP_L2FRAMING_DIXV2:
            case ETHSWT_CFP_L2FRAMING_SNAP_PUB:
                ret = BCM_ERR_OK;
                break;
            default:
                ret = BCM_ERR_INVAL_PARAMS;
                break;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEL2L3FRAMING_PART_PROC,
                        ret, (uint32_t)aL2Framing, (uint32_t)aL3Framing,
                        0UL, 0UL);
    }
    return ret;
}

/** @brief Validate packet length correction value

    @behavior Sync, Re-entrant

    @pre None

    This API validates the input packet length correction value

    @param[in]     aID               Switch index
    @param[in]     aCorr             Packet length correction value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if value is not in
        [ETHSWT_CFP_PKTLENCORR_NONE, ETHSWT_CFP_PKTLENCORR_ADD_PRE_SFD, ETHSWT_CFP_PKTLENCORR_ADD_PRE_SFD_IFG]
        return error
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidatePktLenCorr(ETHSWT_HwIDType aID,
                                         ETHSWT_CFPPktLenCorrType aCorr)
{
    int32_t ret;

    switch (aCorr) {
        case ETHSWT_CFP_PKTLENCORR_NONE:
        case ETHSWT_CFP_PKTLENCORR_ADD_PRE_SFD:
        case ETHSWT_CFP_PKTLENCORR_ADD_PRE_SFD_IFG:
            ret = BCM_ERR_OK;
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
    }

    return ret;
}

/** @brief Validate color value

    @behavior Sync, Re-entrant

    @pre None

    This API validates the input color value

    @param[in]     aID               Switch index
    @param[in]     aColor            Color value

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Valid value
    @retval  #BCM_ERR_INVAL_PARAMS   Invalid value

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if value is not in [ETHSWT_CFP_COLOR_GREEN, ETHSWT_CFP_COLOR_YELLOW, ETHSWT_CFP_COLOR_RED]
        return error
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidateColor(ETHSWT_HwIDType aID, ETHSWT_CFPColorType aColor)
{
    int32_t ret;

    switch (aColor) {
        case ETHSWT_CFP_COLOR_GREEN:
        case ETHSWT_CFP_COLOR_RED:
        case ETHSWT_CFP_COLOR_YELLOW:
            ret = BCM_ERR_OK;
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            break;
    }

    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATECOLOR_PART_PROC,
                        ret, (uint32_t)aColor, 0UL, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief Validate rule key configuration

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVVALIDATEKEY_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_UDFQUEUEENTRY_TYPE
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if ingressPortBitmap is not 0
        if aRow is valid
            validate CTagStatus
            validate STagStatus
            validate L2 and L3 framing
            validate numEnabledUDFs
            for all UDFs in Key: 0->numEnabledUDFs
                validate UDF base
    @endcode
*/
int32_t ETHSWT_CFPDrvValidateKey(ETHSWT_HwIDType aID,
                                 const ETHSWT_CFPKeyType* const aKey)
{
    int32_t              ret     = BCM_ERR_OK;
    uint32_t             line    = 0UL;
    uint32_t             dbgVal1 = 0UL;
    uint32_t             dbgVal2 = 0UL;
    uint32_t             i,j;
    ETHSWT_CFPUDFQueueEntryType     udfScratchQ[ETHSWT_CFP_MAX_UDFS];

    /* Use the ingress port bitmap to determine if a rule is enabled or */
    /* not                                                              */
    if (0U == (aKey->ingressPortBitmap & ETHSWT_CFP_KEY_INGPORTBMP_MASK)) {
        ret     = BCM_ERR_INVAL_PARAMS;
        line    = __LINE__;
        dbgVal1 = (uint32_t)aKey->ingressPortBitmap;
        goto err_exit;
    }

    /* Check Acceptable Frame */
    ret = ETHSWT_CFPDrvCheckAcceptableFrame(aID,
            (ETHSWT_CFPAcceptableFrameType)((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK) >> ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT));
    if (BCM_ERR_OK != ret) {
        line    = __LINE__;
        dbgVal1 = (uint32_t)aKey->cTagFlags;
        goto err_exit;
    }

    /* Check Acceptable Frame */
    ret = ETHSWT_CFPDrvCheckAcceptableFrame(aID,
            (ETHSWT_CFPAcceptableFrameType)((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK) >> ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT));
    if (BCM_ERR_OK != ret) {
        line  = __LINE__;
        dbgVal1 = (uint32_t)aKey->sTagFlags;
        goto err_exit;
    }

    /* Validate L2 and L3 framing */
    ret = ETHSWT_CFPDrvValidateL2L3Framing(aID, aKey->l2Framing, aKey->l3Framing);
    if (BCM_ERR_OK != ret) {
        line    = __LINE__;
        dbgVal1 = (uint32_t)aKey->l2Framing;
        dbgVal2 = (uint32_t)aKey->l3Framing;
        goto err_exit;
    }

    /* Validate numEnabledUDFs */
    if (aKey->numEnabledUDFs > ETHSWT_CFP_MAX_UDFS) {
        ret     = BCM_ERR_INVAL_PARAMS;
        line    = __LINE__;
        dbgVal1 = (uint32_t)aKey->numEnabledUDFs;
        goto err_exit;
    }

    /* Validate UDF base */
    for (i = 0UL; i < aKey->numEnabledUDFs; ++i) {
        ret = ETHSWT_CFPDrvValidateUDFBase(aID,
                (aKey->udfList[i].baseAndOffset & ETHSWT_CFP_UDF_DEFS_BASE_MASK) >> ETHSWT_CFP_UDF_DEFS_BASE_SHIFT);
        if (BCM_ERR_OK != ret) {
            line    = __LINE__;
            dbgVal1 = (uint32_t)aKey->udfList[i].baseAndOffset;
            dbgVal2 = i;
            break;
        }
        /* Store the address in the scratch queue */
        udfScratchQ[i].address = aKey->udfList[i].baseAndOffset;

        /* Check for duplicate UDFs */
        for (j = 0UL; j < i; ++j) {
            if (udfScratchQ[j].address == udfScratchQ[i].address) {
                line    = __LINE__;
                dbgVal1 = i;
                dbgVal2 = j;
                ret = BCM_ERR_INVAL_PARAMS;
                break;
            }
        }
        if (ret != BCM_ERR_OK) {
            break;
        }
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWARCH_ETHSWT_CFP_DRVVALIDATEKEY_PROC,
                        ret, line, (uint32_t)aKey, dbgVal1, dbgVal2);
    }
    return ret;
}

/** @brief Validate action configuration

    @behavior Sync, Re-entrant

    @pre None

    This API checks the input parameters in the action configuration and reports
    any errors

    @param[in]     aID               Switch index
    @param[in]     aRow              CFP row
    @param[in]     aAction           CFP Action

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule is valid
    @retval  #BCM_ERR_INVAL_PARAMS   Returned if aAction or aRow is NULL
                                     Returned if any of the following fields are
                                     invalid
                                         - dstMapIBFlags/- dstMapOBFlags
                                         - colorFlags
                                         - cirRefCnt/eirRefCnt
                                         - cirBktSize
                                         - cirTkBkt/eirTkBkt
    @retval  #BCM_ERR_NOMEM           CFP TCAM is full

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if ingressPortBitmap is not 0
        if aRow is valid
            validate dstMapIBFlags
            validate dstMapOBFlags
            validate colorFlags
            if policer mode is not DISABLED
                if CIRRefCnt > 0 and CIRRefCnt <= Max rate
                    validate CIRBktSize and CIRTkBkt
                if EIRRefCnt != 0
                    validate EIRBktSize and EIRTkBkt
    @endcode
*/
static int32_t ETHSWT_CFPDrvValidateAction(ETHSWT_HwIDType aID,
                                               const ETHSWT_CFPActionType* const aAction)
{
    int32_t                    ret     = BCM_ERR_OK;
    const ETHSWT_CFPMeterType  *meter  = &aAction->meter;
    uint32_t                   line    = 0UL;
    uint32_t                   dbgVal1 = 0UL;
    uint32_t                   dbgVal2 = 0UL;

    /* Validate dstMapIBFlags */
    ret = ETHSWT_CFPDrvValidateDstMapFlags(aID, aAction->dstMapIBFlags);
    if (BCM_ERR_OK != ret) {
        line    = __LINE__;
        dbgVal1 = aAction->dstMapIBFlags;
        goto err_exit;
    }

    /* Validate dstMapOBFlags */
    ret = ETHSWT_CFPDrvValidateDstMapFlags(aID, aAction->dstMapOBFlags);
    if (BCM_ERR_OK != ret) {
        line    = __LINE__;
        dbgVal1 = aAction->dstMapOBFlags;
        goto err_exit;
    }

    /* Validate colorFlags */
    ret = ETHSWT_CFPDrvValidateColor(aID, (aAction->colorFlags & ETHSWT_CFP_ACTION_COLOR_MASK) >>
                               ETHSWT_CFP_ACTION_COLOR_SHIFT);
    if (BCM_ERR_OK != ret) {
        line    = __LINE__;
        dbgVal1 = aAction->colorFlags;
        goto err_exit;
    }

    if (ETHSWT_CFP_POLICERMODE_DISABLED !=
       ((meter->policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT)) {
        /* Validate CIR parameters */
        if ((0UL < meter->cirRefCnt) &&
            (ETHSWT_CFP_METER_REFCNT_MASK >= meter->cirRefCnt)) {

            if ((meter->cirBktSize > ETHSWT_CFP_METER_BKTSZ_MASK) ||
                (0UL == meter->cirBktSize) ||
                (meter->cirTkBkt > ETHSWT_CFP_METER_TKBKT_MASK)) {
                ret     = BCM_ERR_INVAL_PARAMS;
                line    = __LINE__;
                dbgVal1 = meter->cirBktSize;
                dbgVal2 = meter->cirTkBkt;
                goto err_exit;
            }

        } else {
            ret     = BCM_ERR_INVAL_PARAMS;
            line    = __LINE__;
            dbgVal1 = meter->cirRefCnt;
            goto err_exit;
        }

        /* Validate EIR parameters */
        if (0UL != meter->eirRefCnt) {
            if ((meter->eirBktSize > ETHSWT_CFP_METER_BKTSZ_MASK) ||
                (0UL == meter->eirBktSize) ||
                (ETHSWT_CFP_METER_REFCNT_MASK < meter->eirRefCnt) ||
                (meter->eirTkBkt > ETHSWT_CFP_METER_TKBKT_MASK)) {
                ret     = BCM_ERR_INVAL_PARAMS;
                line    = __LINE__;
                dbgVal1 = meter->eirBktSize;
                dbgVal2 = meter->eirTkBkt;
                goto err_exit;
            }
        }
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVVALIDATEACTION_PROC,
                        ret, line, (uint32_t)aAction, dbgVal1, dbgVal2);
    }
    return ret;
}

/** @brief Wait for CFP access operation to complete

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    while timeout has not occurred
        check if done bit in CFP access register is cleared
    @endcode
*/
int32_t ETHSWT_CFPDrvWaitForAccess(ETHSWT_HwIDType aID)
{
    uint32_t regVal;
    int32_t  ret     = BCM_ERR_OK;
    uint32_t timeout = 0UL;

    while (timeout < ETHSWT_CFP_RDWR_TIMEOUT) {
        ret = ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc, &regVal);
        if ((ret != BCM_ERR_OK) ||
            ((regVal & SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK) == 0UL)) {
            break;
        }
        timeout++;
    }

    if (timeout == ETHSWT_CFP_RDWR_TIMEOUT) {
        ret = BCM_ERR_TIME_OUT;
    }
    return ret;
}

/**
    @brief Program the CFP key in the TCAM

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVPROGRAMTCAM_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_UDFQUEUEENTRY_TYPE
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    Construct DATA0 and MASK0 values from UDF0 and UDF1
    Write DATA0 and MASK0 registers

    Construct DATA1 and MASK1 values from UDF1, UDF2 and UDF3
    Write DATA1 and MASK1 registers

    Construct DATA2 and MASK2 values from UDF3, UDF4 and UDF5
    Write DATA2 and MASK2 registers

    Construct DATA3 and MASK3 values from UDF5, UDF6 and UDF7
    Write DATA3 and MASK3 registers

    Construct DATA4 and MASK4 values from UDF7, UDF8 and CTag
    Write DATA4 and MASK4 registers

    Construct DATA5 and MASK5 values from CTag, STag and UDFValid
    Write DATA5 and MASK5 registers

    Construct DATA6 and MASK6 values from UDFValid, flags, l3Framing, l2Framing,
    CTagStatus and STagStatus
    Write DATA6 and MASK6 registers

    Construct DATA7 and MASK7 values from ingressPortBitmap
    Write DATA7 and MASK7 registers

    Start write access at input row to TCAM
    Wait for write to TCAM to complete
    @endcode
*/
int32_t ETHSWT_CFPDrvProgramTCAM(ETHSWT_HwIDType aID,
                                 uint32_t aRow,
                                 uint32_t aSlice,
                                 const ETHSWT_CFPKeyType* const aKey,
                                 const ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ)
{
    uint32_t  regVal;
    uint32_t  cTagAFT;
    uint32_t  sTagAFT;
    uint32_t  cTagStatusMask;
    uint32_t  sTagStatusMask;
    uint32_t  cTagStatusValue;
    uint32_t  sTagStatusValue;
    uint32_t  tagId;
    uint32_t  tagMask;
    uint32_t  value;
    uint32_t  udfValid = 0UL;
    uint32_t  valid;
    int32_t   ret = BCM_ERR_OK;
    uint32_t  line;

    /* DATA0 */
    regVal = ((aSlice << SWITCH_CFP_DATA0_SLICEID_SHIFT) & SWITCH_CFP_DATA0_SLICEID_MASK)            |
             ((aProgramUDFQ[0U].value << SWITCH_CFP_DATA0_UDF0_SHIFT) & SWITCH_CFP_DATA0_UDF0_MASK)  |
             ((aProgramUDFQ[1U].value << SWITCH_CFP_DATA0_UDF1_SHIFT) & SWITCH_CFP_DATA0_UDF1_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data0,
                               regVal));

    /* MASK0 */
    regVal = SWITCH_CFP_DATA0_SLICEID_MASK;
    if (1UL == aProgramUDFQ[0U].enable) {
        regVal   |= (aProgramUDFQ[0U].mask << SWITCH_CFP_DATA0_UDF0_SHIFT);
        udfValid |= 0x1UL;
    }
    if (1UL == aProgramUDFQ[1U].enable) {
        regVal   |= ((aProgramUDFQ[1U].mask & (SWITCH_CFP_DATA0_UDF1_MASK >> SWITCH_CFP_DATA0_UDF1_SHIFT))
                    << SWITCH_CFP_DATA0_UDF1_SHIFT);
        udfValid |= 0x2UL;
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask0,
                               regVal));

    /* DATA1 */
    value = aProgramUDFQ[1U].value >> 8UL;
    regVal = ((value << SWITCH_CFP_DATA1_UDF1_SHIFT) & SWITCH_CFP_DATA1_UDF1_MASK) |
             ((aProgramUDFQ[2U].value << SWITCH_CFP_DATA1_UDF2_SHIFT) & SWITCH_CFP_DATA1_UDF2_MASK) |
             ((aProgramUDFQ[3U].value << SWITCH_CFP_DATA1_UDF3_SHIFT) & SWITCH_CFP_DATA1_UDF3_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data1,
                               regVal));

    /* MASK1 */
    regVal = 0UL;
    if (1UL == aProgramUDFQ[1U].enable) {
        regVal |= (aProgramUDFQ[1U].mask >> 8U);
    }
    if (1UL == aProgramUDFQ[2U].enable) {
        regVal   |= (aProgramUDFQ[2U].mask << SWITCH_CFP_DATA1_UDF2_SHIFT);
        udfValid |= 0x4UL;
    }
    if (1UL == aProgramUDFQ[3U].enable) {
        regVal   |= ((aProgramUDFQ[3U].mask & (SWITCH_CFP_DATA1_UDF3_MASK >> SWITCH_CFP_DATA1_UDF3_SHIFT))
                    << SWITCH_CFP_DATA1_UDF3_SHIFT);
        udfValid |= 0x8UL;
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask1,
                               regVal));

    /* DATA2 */
    value = aProgramUDFQ[3U].value >> 8UL;
    regVal = ((value << SWITCH_CFP_DATA2_UDF3_SHIFT) & SWITCH_CFP_DATA2_UDF3_MASK) |
             ((aProgramUDFQ[4U].value << SWITCH_CFP_DATA2_UDF4_SHIFT) & SWITCH_CFP_DATA2_UDF4_MASK) |
             ((aProgramUDFQ[5U].value << SWITCH_CFP_DATA2_UDF5_SHIFT) & SWITCH_CFP_DATA2_UDF5_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data2,
                               regVal));

    /* MASK2 */
    regVal = 0UL;
    if (1UL == aProgramUDFQ[3U].enable) {
        regVal |= (aProgramUDFQ[3U].mask >> 8UL);
    }
    if (1UL == aProgramUDFQ[4U].enable) {
        regVal   |= (aProgramUDFQ[4U].mask << SWITCH_CFP_DATA2_UDF4_SHIFT);
        udfValid |= 0x10UL;
    }
    if (1UL == aProgramUDFQ[5U].enable) {
        regVal   |= ((aProgramUDFQ[5U].mask & (SWITCH_CFP_DATA2_UDF5_MASK >> SWITCH_CFP_DATA2_UDF5_SHIFT))
                    << SWITCH_CFP_DATA2_UDF5_SHIFT);;
        udfValid |= 0x20UL;
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask2,
                               regVal));

    /* DATA3 */
    value = (uint32_t)aProgramUDFQ[5U].value >> 8UL;
    regVal = ((value << SWITCH_CFP_DATA3_UDF5_SHIFT) & SWITCH_CFP_DATA3_UDF5_MASK) |
             ((aProgramUDFQ[6U].value << SWITCH_CFP_DATA3_UDF6_SHIFT) & SWITCH_CFP_DATA3_UDF6_MASK) |
             ((aProgramUDFQ[7U].value << SWITCH_CFP_DATA3_UDF7_SHIFT) & SWITCH_CFP_DATA3_UDF7_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data3,
                               regVal));

    /* MASK3 */
    regVal = 0UL;
    if (1UL == aProgramUDFQ[5U].enable) {
        regVal |= (aProgramUDFQ[5U].mask >> 8U);
    }
    if (1UL == aProgramUDFQ[6U].enable) {
        regVal   |= (aProgramUDFQ[6U].mask << SWITCH_CFP_DATA3_UDF6_SHIFT);
        udfValid |= 0x40UL;
    }
    if (1UL == aProgramUDFQ[7U].enable) {
        regVal   |= ((aProgramUDFQ[7U].mask & (SWITCH_CFP_DATA3_UDF7_MASK >> SWITCH_CFP_DATA3_UDF7_SHIFT))
                    << SWITCH_CFP_DATA3_UDF7_SHIFT);
        udfValid |= 0x80UL;
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask3,
                                regVal));

    /* DATA4 */
    value = aProgramUDFQ[7U].value >> 8UL;
    regVal = ((value << SWITCH_CFP_DATA4_UDF7_SHIFT) & SWITCH_CFP_DATA4_UDF7_MASK) |
             ((aProgramUDFQ[8U].value << SWITCH_CFP_DATA4_UDF8_SHIFT) & SWITCH_CFP_DATA4_UDF8_MASK);

    valid      = ((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) >>
                 ETHSWT_CFP_KEY_TAG_ID_VALID_SHIFT);

    if (1UL == valid) {
        tagId = ((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_ID_MASK) >>
                 ETHSWT_CFP_KEY_TAG_ID_SHIFT);
        regVal |= ((tagId << SWITCH_CFP_DATA4_CTAG_SHIFT) & SWITCH_CFP_DATA4_CTAG_MASK);
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data4,
                               regVal));

    /* MASK4 */
    regVal = 0UL;
    if (1UL == aProgramUDFQ[7U].enable) {
        regVal |= (aProgramUDFQ[7U].mask >> 8U);
    }
    if (1UL == aProgramUDFQ[8U].enable) {
        regVal   |= (aProgramUDFQ[8U].mask << SWITCH_CFP_DATA4_UDF8_SHIFT);
        udfValid |= 0x100UL;
    }
    if (1UL == valid) {
        tagMask = (((uint32_t)aKey->cTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        regVal |= (SWITCH_CFP_DATA4_CTAG_MASK & (tagMask << SWITCH_CFP_DATA4_CTAG_SHIFT));
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask4,
                               regVal));

    /* DATA5 */
    regVal = 0UL;
    /* ID */
    if (1UL == valid) {
        regVal |= (tagId >> 8UL);
    }

    /* PCP */
    valid = ((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) >>
            ETHSWT_CFP_KEY_TAG_PCP_VALID_SHIFT);

    if (1UL == valid) {
        regVal |= (((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_PCP_MASK) >>
                  ETHSWT_CFP_KEY_TAG_PCP_SHIFT) << 5UL);
    }

    /* DEI */
    valid = ((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) >>
            ETHSWT_CFP_KEY_TAG_DEI_VALID_SHIFT);

    if (1UL == valid) {
        regVal |= (((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_DEI_MASK) >>
                  ETHSWT_CFP_KEY_TAG_DEI_SHIFT) << 4UL);
    }

    regVal &= SWITCH_CFP_DATA5_CTAG_MASK;

    /* PCP */
    valid = ((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) >>
            ETHSWT_CFP_KEY_TAG_PCP_VALID_SHIFT);

    if (1UL == valid) {
        regVal |= (((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_PCP_MASK) >>
                  ETHSWT_CFP_KEY_TAG_PCP_SHIFT) << (SWITCH_CFP_DATA5_STAG_SHIFT + 13UL));
    }

    /* DEI */
    valid = ((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) >>
            ETHSWT_CFP_KEY_TAG_DEI_VALID_SHIFT);

    if (1UL == valid) {
        regVal |= (((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_DEI_MASK) >>
                  ETHSWT_CFP_KEY_TAG_DEI_SHIFT) << (SWITCH_CFP_DATA5_STAG_SHIFT + 12UL));
    }

    /* ID */
    valid      = ((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) >>
                 ETHSWT_CFP_KEY_TAG_ID_VALID_SHIFT);

    if (1UL == valid) {
        tagId = ((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_ID_MASK) >>
                ETHSWT_CFP_KEY_TAG_ID_SHIFT);
        regVal |= ((tagId << SWITCH_CFP_DATA5_STAG_SHIFT) & SWITCH_CFP_DATA5_STAG_MASK);
    }

    regVal |= ((udfValid << SWITCH_CFP_DATA5_UDFVALID_7_0_SHIFT) & SWITCH_CFP_DATA5_UDFVALID_7_0_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data5,
                               regVal));

    /* MASK5 */
    regVal = 0UL;
    if ((ETHSWT_CFP_KEY_TAG_ID_VALID_MASK == (aKey->cTagFlags &
         ETHSWT_CFP_KEY_TAG_ID_VALID_MASK))) {
        tagMask = (aKey->cTagMask & 0xF00UL) >> 8UL;
        regVal |= (0xFUL & (tagMask << SWITCH_CFP_DATA5_CTAG_SHIFT));
    }

    if (ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK == (aKey->cTagFlags &
        ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK)) {
        tagMask = (uint32_t)((aKey->cTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK) >> ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
        regVal |= (0xE0UL &  (tagMask << 5UL));
    }
    if (ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK == (aKey->cTagFlags &
        ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK)) {
        regVal |= 0x10UL;
    }

    if (1UL == valid) {
        tagMask = (uint32_t)((aKey->sTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        regVal |= (tagMask << SWITCH_CFP_DATA5_STAG_SHIFT);
    }

    if (ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK == (aKey->sTagFlags &
        ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK)) {
        tagMask = (uint32_t)((aKey->sTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK) >> ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
        regVal |= (tagMask << (SWITCH_CFP_DATA5_STAG_SHIFT + 13UL));
    }
    if (ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK == (aKey->sTagFlags &
        ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK)) {
        regVal |= (0x1000UL << SWITCH_CFP_DATA5_STAG_SHIFT);
    }

    regVal |= ((udfValid << SWITCH_CFP_DATA5_UDFVALID_7_0_SHIFT) &
              SWITCH_CFP_DATA5_UDFVALID_7_0_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask5,
                               regVal));

    /* DATA6 */
    regVal = (((udfValid >> 8UL) << SWITCH_CFP_DATA6_UDFVALID_8_SHIFT) &
             SWITCH_CFP_DATA6_UDFVALID_8_MASK);

    switch(aKey->l3Framing) {
        case ETHSWT_CFP_L3FRAMING_IPV4:
            /* Fall through intentional */
        case ETHSWT_CFP_L3FRAMING_IPV6:
            regVal |= (aKey->flags & ETHSWT_CFP_KEY_IP_MASK) <<
                      SWITCH_CFP_DATA6_TTL_SHIFT;
            break;
        case ETHSWT_CFP_L3FRAMING_NONIP:
            regVal |= (((aKey->flags & ETHSWT_CFP_KEY_NONIP_MASK) <<
                        SWITCH_CFP_DATA6_ETHTYPE_SHIFT) & SWITCH_CFP_DATA6_ETHTYPE_MASK);
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            break;
    }
    if (ret != BCM_ERR_OK) {
        goto err_exit;
    }

    regVal |= (((uint32_t)aKey->l3Framing << SWITCH_CFP_DATA6_L3FRAMING_SHIFT) & SWITCH_CFP_DATA6_L3FRAMING_MASK);
    regVal |= (((uint32_t)aKey->l2Framing << SWITCH_CFP_DATA6_L2FRAMING_SHIFT) & SWITCH_CFP_DATA6_L2FRAMING_MASK);

    cTagAFT = ((aKey->cTagFlags & ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK) >>
                 ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT);
    ETHSWT_CFPDrvAFTtoTagStatus(aID, (ETHSWT_CFPAcceptableFrameType)cTagAFT, &cTagStatusValue, &cTagStatusMask);
    regVal |= ((cTagStatusValue << SWITCH_CFP_DATA6_CTAGSTATUS_SHIFT) & SWITCH_CFP_DATA6_CTAGSTATUS_MASK);

    sTagAFT = ((aKey->sTagFlags & ETHSWT_CFP_KEY_TAG_ACCEPT_FRAME_MASK) >>
                 ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT);
    ETHSWT_CFPDrvAFTtoTagStatus(aID, (ETHSWT_CFPAcceptableFrameType)sTagAFT, &sTagStatusValue, &sTagStatusMask);
    regVal |= ((sTagStatusValue << SWITCH_CFP_DATA6_STAGSTATUS_SHIFT) & SWITCH_CFP_DATA6_STAGSTATUS_MASK);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data6,
                               regVal));

    /* MASK6 */
    regVal = (((udfValid >> 8UL) << SWITCH_CFP_DATA6_UDFVALID_8_SHIFT) &
             SWITCH_CFP_DATA6_UDFVALID_8_MASK);

    switch(aKey->l3Framing) {
        case ETHSWT_CFP_L3FRAMING_IPV4:
            /* Fall through intentional */
        case ETHSWT_CFP_L3FRAMING_IPV6:
            regVal |= (aKey->flagsMask & ETHSWT_CFP_KEY_IP_MASK) <<
                      SWITCH_CFP_DATA6_TTL_SHIFT;
            break;
        case ETHSWT_CFP_L3FRAMING_NONIP:

            regVal |= (((aKey->flagsMask & ETHSWT_CFP_KEY_NONIP_MASK) <<
                        SWITCH_CFP_DATA6_ETHTYPE_SHIFT) & SWITCH_CFP_DATA6_ETHTYPE_MASK);
            break;
        default:
            /* Handling default case */
            break;
    }

    /* L3 Framing is mandatorily enabled */
    regVal |= SWITCH_CFP_DATA6_L3FRAMING_MASK;

    if (aKey->l2Framing != ETHSWT_CFP_L2FRAMING_DIXV2) {
        regVal |= SWITCH_CFP_DATA6_L2FRAMING_MASK;
    }

    regVal |= cTagStatusMask << SWITCH_CFP_DATA6_CTAGSTATUS_SHIFT;
    regVal |= sTagStatusMask << SWITCH_CFP_DATA6_STAGSTATUS_SHIFT;

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask6,
                               regVal));

    /* DATA7 */
    regVal = (((aKey->ingressPortBitmap) & SWITCH_CFP_DATA7_SRCPRTMAP_MASK) <<
              SWITCH_CFP_DATA7_SRCPRTMAP_SHIFT);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data7,
                               regVal));

    /* MASK7 */
    regVal = (((uint32_t)(~aKey->ingressPortBitmap) & SWITCH_CFP_DATA7_SRCPRTMAP_MASK) <<
              SWITCH_CFP_DATA7_SRCPRTMAP_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask7,
                               regVal));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMTCAM_PART_PROC,
                        ret, line, aRow, aSlice, (uint32_t) aKey->l3Framing);
    }
    return ret;
}


/** @brief Program the CFP Action Policy RAM

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API programs the row in the action policy RAM for the given config

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number
    @param[in]     aAction           Pointer to action configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Row programmed successfully in Action
                                     Policy RAM
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    Construct ACTPOL0 value from otherFlags, reasonCode, dstMapIBFlags and
    tosIBFlags
    Write ACTPOL0 register

    Construct ACTPOL1 value from tosIBFlags, dstMapOBFlags, tosOBFlags, chainID,
    colorFlags and otherFlags
    Write ACTPOL1 register

    Write 0 to ACTPOL2 register

    Start write access at input row to Action RAM
    Wait for write to Action RAM to complete
    @endcode
*/
static int32_t ETHSWT_CFPDrvProgramActionPolicyRAM(ETHSWT_HwIDType aID,
                                             uint32_t aRow,
                                             const ETHSWT_CFPActionType* const aAction)
{
    uint32_t  regVal;
    int32_t   ret = BCM_ERR_OK;
    uint32_t  line;
    uint32_t  dstMapFlags = 0UL;

    /* ACT_POL_DATA0 */
    dstMapFlags = (aAction->dstMapIBFlags & (SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_DST_MAP_IB_MASK >> SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_DST_MAP_IB_SHIFT)) <<
                   SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_DST_MAP_IB_SHIFT;
    dstMapFlags |= ((aAction->dstMapIBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >>
                   ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) << SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_CHANGE_FWRD_MAP_IB_SHIFT;
    regVal = ((aAction->otherFlags & SWITCH_CFP_ACT_POL_DATA0_BYPASS_MASK) <<
             SWITCH_CFP_ACT_POL_DATA0_BYPASS_SHIFT) |
             ((uint32_t)(aAction->reasonCode << SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_REASON_CODE_SHIFT) &
             SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_REASON_CODE_MASK) |
            ((uint32_t)((aAction->otherFlags >> ETHSWT_CFP_ACTION_LPBK_EN_SHIFT) << SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_LOOP_BK_EN_SHIFT) &
            SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_LOOP_BK_EN_MASK) |
            (((uint32_t)aAction->tcFlags << SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_TC_SHIFT) &
            SWITCH_CFP_ACT_POL_DATA0_TC_MASK) |
            (dstMapFlags) |
            (((uint32_t)aAction->tosIBFlags << SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_DSCP_IB_SHIFT) &
            SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_DSCP_IB_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data0,
                regVal));

    /* ACT_POL_DATA1 */
    dstMapFlags = (aAction->dstMapOBFlags & (SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_DST_MAP_OB_MASK >> SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_DST_MAP_OB_SHIFT)) <<
                   SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_DST_MAP_OB_SHIFT;
    dstMapFlags |= ((aAction->dstMapOBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >>
                   ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) << SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_FWRD_MAP_OB_SHIFT;
    regVal = (((uint32_t)(((aAction->tosIBFlags & ETHSWT_CFP_ACTION_CHANGE_TOS_MASK) >>
              ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) << SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_DSCP_IB_SHIFT) &
              SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_DSCP_IB_MASK) |
              (dstMapFlags) |
              ((uint32_t)(aAction->tosOBFlags << SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_NEW_DSCP_OB_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA1_TOS_MASK) |
              ((uint32_t)(aAction->chainID << SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHAIN_ID_SHIFT) &
              SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHAIN_ID_MASK) |
              ((uint32_t)(aAction->colorFlags << SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_COLOR_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA1_COLOR_MASK));

#if defined(__BCM8953X__)
    regVal |= ((((aAction->otherFlags & ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK) >>
              ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) << SWITCH_CFP_ACT_POL_DATA1_REDDFLT_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA1_REDDFLT_MASK);
#endif

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data1,
                               regVal));

    /* ACT_POL_DATA2 */
#if defined(__BCM8956X__) || defined(__BCM8957X__)
    regVal = ((uint32_t)(((aAction->otherFlags & ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK) >>
              ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_REDDFLT_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA2_REDDFLT_MASK) |
              ((uint32_t)(((aAction->otherFlags & ETHSWT_CFP_ACTION_MIRROR_OB_MASK) >>
              ETHSWT_CFP_ACTION_MIRROR_OB_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_OB_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_OB_MASK) |
              ((uint32_t)(((aAction->otherFlags & ETHSWT_CFP_ACTION_MIRROR_IB_MASK) >>
              ETHSWT_CFP_ACTION_MIRROR_IB_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_IB_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_IB_MASK) |
              ((uint32_t)(((aAction->otherFlags & ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_MASK) >>
              ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_MAC_LIMIT_BYPASS_SHIFT) &
              SWITCH_CFP_ACT_POL_DATA2_MAC_LIMIT_BYPASS_MASK);
#else
    regVal = 0UL;
#endif
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data2,
                               regVal));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
            (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
            ((SWITCH_CFP_ACC_RAM_SEL_ACT_POL << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
            SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
            ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)|
            SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMACTIONPOLICYRAM_PART_PROC,
                        ret, line, aRow, 0UL, 0UL);
    }
    return ret;
}


/** @brief Program the CFP Rate Meter RAM

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API programs the row in the metering RAM for the given config

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number
    @param[in]     aMeter            Pointer to meter configuration

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Row programmed successfully in Rate Meter
                                     RAM
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    Write policerFlags to RATE_METER0 register
    Write eirTkBkt to RATE_METER1 register
    Write eirBktSize to RATE_METER2 register
    Write eirRefCnt to RATE_METER3 register
    Write cirTkBkt to RATE_METER4 register
    Write cirBktSize to RATE_METER5 register
    Write cirRefCnt to RATE_METER6 register

    Start write access at input row to Rate Meter RAM
    Wait for write to Rate Meter RAM to complete
    @endcode
*/
static int32_t ETHSWT_CFPDrvProgramRateMeterRAM(ETHSWT_HwIDType aID,
                                          uint32_t aRow,
                                          const ETHSWT_CFPMeterType* const aMeter)
{
    uint32_t  regVal;
    int32_t   ret = BCM_ERR_OK;
    uint32_t  line;

    /* RATE_METER0*/
    regVal = (aMeter->policerFlags & SWITCH_CFP_RATE_METER0_MASK);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter0,
                               regVal));

    /* RATE_METER1*/
    regVal = ((aMeter->eirTkBkt & SWITCH_PAGE_A0_RATE_METER1_EIR_TK_BKT_MASK) <<
                SWITCH_PAGE_A0_RATE_METER1_EIR_TK_BKT_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter1,
                               regVal));

    /* RATEMETER2*/
    regVal = ((aMeter->eirBktSize & SWITCH_PA0RM2_PAGE_A0_RATE_METER2_EIR_BKT_SIZE_MASK) <<
                SWITCH_PA0RM2_PAGE_A0_RATE_METER2_EIR_BKT_SIZE_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter2,
                               regVal));

    /* RATEMETER3*/
    regVal = ((aMeter->eirRefCnt & SWITCH_PA0RM3_PAGE_A0_RATE_METER3_EIR_REF_CNT_MASK) <<
                SWITCH_PA0RM3_PAGE_A0_RATE_METER3_EIR_REF_CNT_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter3,
                               regVal));

    /* RATEMETER4*/
    regVal = ((aMeter->cirTkBkt & SWITCH_PAGE_A0_RATE_METER4_CIR_TK_BKT_MASK) <<
                SWITCH_PAGE_A0_RATE_METER4_CIR_TK_BKT_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter4,
                               regVal));

    /* RATEMETER5*/
    regVal = ((aMeter->cirBktSize & SWITCH_PA0RM5_PAGE_A0_RATE_METER5_CIR_BKT_SIZE_MASK) <<
                SWITCH_PA0RM5_PAGE_A0_RATE_METER5_CIR_BKT_SIZE_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter5,
                               regVal));

    /* RATEMETER6*/
    regVal = ((aMeter->cirRefCnt & SWITCH_PA0RM6_PAGE_A0_RATE_METER6_CIR_REF_CNT_MASK) <<
                SWITCH_PA0RM6_PAGE_A0_RATE_METER6_CIR_REF_CNT_SHIFT);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter6,
                               regVal));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RATE_METER << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID,
                        BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMRATEMETERRAM_PART_PROC,
                        ret, line, aRow, 0UL, 0UL);
    }
    return ret;
}


/** @brief Program the global UDFs

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    for all UDFs in scratch Q: 0->ETHSWT_CFP_MAX_UDFS
        if UDF enabled but not created
            Write UDF register in H/W
    @endcode
*/
int32_t ETHSWT_CFPDrvProgramUDFs(ETHSWT_HwIDType aID,
                                 uint32_t aFormat,
                                 uint32_t aSlice,
                                 volatile uint8_t* aUDFBaseAddr,
                                 const ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ)
{
    uint32_t i;
    int32_t ret = BCM_ERR_OK;

    for (i = 0UL ; i < ETHSWT_CFP_MAX_UDFS; ++i) {
        if ((TRUE == aProgramUDFQ[i].enable) &&
            (FALSE == aProgramUDFQ[i].created)) {
            ret = ETHSWT_DrvWriteReg(aID, (uint32_t)aUDFBaseAddr +
                                     (aFormat * 0x30UL) +
                                     (aSlice * 0x10UL) + i,
                                     aProgramUDFQ[i].address);
            if (BCM_ERR_OK != ret) {
                break;
            }
        }
    }
    return ret;
}

/**
    @brief Enable/Disable rule

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVSETRULEVALID_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPDrvSetRuleValid(ETHSWT_HwIDType aID,
                                  uint32_t aRow, uint32_t aEnable)
{
    uint32_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line= 0UL;

    /* Read the TCAM */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* DATA0 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data0, &regVal));

    if (TRUE == aEnable) {
        /* Set the slice valid */
        regVal |= SWITCH_CFP_DATA0_VALID;
    } else {
        /* Reset the slice valid */
        regVal &= ~(SWITCH_CFP_DATA0_VALID);
    }
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data0, regVal));

    /* Write to the TCAM */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVSETRULEVALID_PART_PROC,
                           ret, line, aRow, aEnable, 0UL);
    }
    return ret;
}

/** @brief Set statistics counters

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API sets the statistics counters to the input values

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number of the rule
    @param[in]     aStats            Pointer to statistics counters

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Counters set successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    Set Green counter in Green statistics RAM
    Set Yellow counter in Yellow statistics RAM
    Set Red counter in Red statistics RAM
    @endcode
*/
static int32_t ETHSWT_CFPDrvSetStats(ETHSWT_HwIDType aID,
                               uint32_t aRow,
                               const ETHSWT_CFPStatsType *const aStats)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t line = 0UL;

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_green_cntr,
                                aStats->green));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_GREEN_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_yellow_cntr,
                                aStats->yellow));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_YELLOW_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_red_cntr,
                                aStats->red));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RED_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVSETSTATS_PART_PROC,
                        ret, line, aRow, 0UL, 0UL);
    }
    return ret;
}

/** @brief Check if input row is occupied

    @behavior Sync, Re-entrant

    @pre None

    This API checks the S/W cache to decide if a rule is already programed
    at the input row

    @param[in]     aRow              Row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Row is occupied
    @retval  #BCM_ERR_NOT_FOUND      Row is not occupied

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if row < ETHSWT_CFP_MAX_RULES and row is enabled
        return SUCCESS
    else
        return FAIL
    @endcode
*/
static int32_t ETHSWT_CFPDrvCheckIfRuleExists(uint32_t aRow)
{
    int32_t ret = BCM_ERR_NOT_FOUND;

    if (aRow < ETHSWT_CFP_MAX_RULES) {
        if (0U != (ETHSWT_CFP_RULEDATA_ENABLE_MASK & ETHSWT_CFPHandle.rules[aRow])) {
            ret = BCM_ERR_OK;
        }
    }

    return ret;
}

/** @brief Check if input row is occupied by a static rule

    @behavior Sync, Re-entrant

    @pre None

    This API checks the S/W cache to decide if a row is programed
    with a static rule

    @param[in]     aRow              Row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule is static
    @retval  #BCM_ERR_UNKNOWN        Rule is not static

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if row < ETHSWT_CFP_MAX_RULES and row is enabled
        return SUCCESS
    else
        return FAIL
    @endcode
*/
static int32_t ETHSWT_CFPDrvCheckIfRuleIsStatic(uint32_t aRow)
{
    int32_t ret = BCM_ERR_UNKNOWN;

    if (aRow < ETHSWT_CFP_MAX_RULES) {
        if (0U != (ETHSWT_CFP_RULEDATA_STATIC_MASK & ETHSWT_CFPHandle.rules[aRow])) {
            ret = BCM_ERR_OK;
        }
    }

    return ret;
}

/**
    @brief CFP driver get statistics

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID     Switch Index
    @param[in]      aRow    Row number
    @param[inout]   aStats  Pointer to Statistics

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in Initialize state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if state == INITIALIZED
        if rule exists
            read Green counter
            read Yellow counter
            read Red counter
    @endcode
*/
static int32_t ETHSWT_CFPDrvGetStats(ETHSWT_HwIDType aID,
                        uint32_t aRow,
                        ETHSWT_CFPStatsType *const aStats)
{
    uint32_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvCheckIfRuleExists(aRow));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_GREEN_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_green_cntr,
                               &regVal));
    aStats->green = regVal;

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_YELLOW_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_yellow_cntr,
                                &regVal));
    aStats->yellow = regVal;

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RED_STATS << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_stat_red_cntr,
                                &regVal));
    aStats->red = regVal;

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVGETSTATS_PROC, ret,
                        line, aRow, (uint32_t)ETHSWT_CFPHandle.state, 0UL);
    }
    return ret;
}

/** @brief Copy rule from one row to another

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API copies a rule, register by register from one row to another

    @param[in]     aID               Switch index
    @param[in]     aDestRow          Destination row number
    @param[in]     aSrcRow           Source row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule copied successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    Load Rate Meter registers from source row
    Write Rate Meter registers to destination row
    Load Action Policy registers from source row
    Write Action Policy registers to destination row
    Load TCAM registers from source row
    Write TCAM registers to destination row
    Load statistics from the source row
    Write statistics to the destination row
    @endcode
*/
static int32_t ETHSWT_CFPDrvCopyRule(ETHSWT_HwIDType aID,
                               uint32_t aDestRow,
                               uint32_t aSrcRow)
{
    uint32_t      regVal;
    uint32_t      line;
    ETHSWT_CFPStatsType stats;
    int32_t       ret = BCM_ERR_OK;

    /* RATE METER */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aSrcRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RATE_METER << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter0,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter1,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter2,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter3,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter4,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter5,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter6,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aDestRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RATE_METER << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* ACT POL */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
            (((aSrcRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
            ((SWITCH_CFP_ACC_RAM_SEL_ACT_POL << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
            SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
            ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)|
            SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data0,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data1,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data2,
                               &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
            (((aDestRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
            ((SWITCH_CFP_ACC_RAM_SEL_ACT_POL << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
            SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
            ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)|
            SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* TCAM */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aSrcRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data0, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask0, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data1, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask1, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data2, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask2, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data3, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask3, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data4, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask4, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data5, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask5, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data6, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask6, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data7, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask7, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aDestRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_WR << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* Statistics */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvGetStats(aID, aSrcRow, &stats));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetStats(aID, aDestRow, &stats));
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVCOPYRULE_PART_PROC,
                        ret, line, aDestRow, aSrcRow, 0UL);
    }
    return ret;
}

/** @brief Insert rule at a particular row

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API copies a rule, register by register from one row to another

    @param[in]     aID               Switch index
    @param[in]     aRow              Row number to insert the rule at

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Rule inserted successfully
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out
    @retval  #BCM_ERR_NOMEM          No free space to insert

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    search for a higher numbered free row
    if found
        shift up all rules from input row onwards
        update rulesAssociated bitmap to reflect new row number
    @endcode
*/
static int32_t ETHSWT_CFPDrvInsertRule(ETHSWT_HwIDType aID,
                                 uint32_t aRow)
{
    uint32_t             row   = 0UL;
    int32_t              ret   = BCM_ERR_OK;
    uint32_t             srcRow;
    uint32_t             destRow;
    uint32_t             line = 0UL;

    /* Find the last entry to be moved */
    for (row = aRow + 1UL; row < ETHSWT_CFPHandle.numAllowedRules; ++row) {
        if (BCM_ERR_OK != ETHSWT_CFPDrvCheckIfRuleExists(row)) {
            break;
        }
    }

    if (row >= ETHSWT_CFPHandle.numAllowedRules) {
        ret = BCM_ERR_NOMEM;
        line = __LINE__;
        goto err_exit;
    }

    /* Now shift up all rules from the input row number onwards */
    for (; row > aRow; row--) {
        srcRow  = row - 1UL;
        destRow = row;

        if (BCM_ERR_OK != ETHSWT_CFPDrvCopyRule(aID, destRow, srcRow)) {
            line = __LINE__;
            break;
        }
        /* Update the S/W data structures:                           */
        /*  - rulesAssociated with all the UDFs that srcRow is using */
        /*    to be associated with destRow                          */
        /*  - cached rule data associated with destRow to be updated */
        BCM_MemCpy(&ETHSWT_CFPHandle.rules[destRow],
                   &ETHSWT_CFPHandle.rules[srcRow],
                   sizeof(ETHSWT_CFPRuleDataType));
    }
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVINSERTRULE_PART_PROC,
                        ret, line, aRow, row, 0UL);
    }
    return ret;
}

/** @brief Allocate row in CFP table

    @behavior Sync, Re-entrant (for different switch index)

    @pre None

    This API allocates a row (if required) in the CFP table. If a valid
    row number is not provided, a free row is returned. If the input row
    number is already occupied, this routine tries to create space by pushing
    all higher numbered rows down.

    @param[in]     aID               Switch index
    @param[inout]  aRow              Pointer to row number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK             Row is allocated
    @retval  #BCM_ERR_NOMEM          No free row
    @retval  #BCM_ERR_INVAL_PARAMS   Register is invalid
    @retval  #BCM_ERR_TIME_OUT       CFP/Switch Register access timed out

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None

    @code{.unparsed}
    if valid row number is provided
        if row is already occupied
            if existing rule is not static
                insert the rule
    else
        search for a free row
    @endcode
*/
static int32_t ETHSWT_CFPDrvAllocateRow(ETHSWT_HwIDType aID,
                                  uint32_t* const aRow)
{
    int32_t  ret = BCM_ERR_OK;
    uint32_t row;
    uint32_t line;

    if (*aRow >= ETHSWT_CFP_MAX_RULES) {
        /* There can be holes due to deletion so find out a free slot */
        for (row = 0UL; row < ETHSWT_CFPHandle.numAllowedRules; ++row) {
            if (BCM_ERR_OK != ETHSWT_CFPDrvCheckIfRuleExists(row)) {
                *aRow = row;
                break;
            }
        }

        if (*aRow == ETHSWT_CFPHandle.numAllowedRules) {
            ret  = BCM_ERR_NOMEM;
            line = __LINE__;
        }
    } else {
        /* Row number is provided - make sure it does not belong to a static rule */
        if (BCM_ERR_OK == ETHSWT_CFPDrvCheckIfRuleExists(*aRow)) {
            if (BCM_ERR_OK == ETHSWT_CFPDrvCheckIfRuleIsStatic(*aRow)) {
                ret  = BCM_ERR_NOPERM;
                line = __LINE__;
            } else {
                ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvInsertRule(aID, *aRow));
            }
        }
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVALLOCATEROW_PART_PROC,
                        ret, line, *aRow, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief Find a free slice for UDFs of a rule to be programmed

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVFINDSLICE_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_UDFQUEUEENTRY_TYPE
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION
*/
int32_t ETHSWT_CFPDrvFindSlice(ETHSWT_HwIDType aID,
                               const ETHSWT_CFPKeyType* const aKey,
                               uint32_t* const aSlice,
                               ETHSWT_CFPUDFAllocListType *const aActiveUDFList,
                               ETHSWT_CFPUDFQueueEntryType *const aProgramUDFQ)
{
    uint32_t             slot;
    int32_t              ret            = BCM_ERR_NOMEM;
    uint8_t              slice;
    uint8_t              startSlice;
    uint8_t              endSlice;

    if (ETHSWT_CFP_MAX_SLICES <= *aSlice) {
        startSlice = ETHSWT_CFP_MAX_SLICES - 1U;
        endSlice = 0U;
    } else {
        startSlice = endSlice = (uint8_t) *aSlice;
    }

    /* Traverse the highest priority slice and see if all UDFs */
    /* can fit. If not, then move on to the next slice         */
    for (slice = startSlice ; slice >= endSlice; --slice) {
        uint32_t ruleFitsInCurrSlice = TRUE;
        uint32_t udf;

        /* Clean up the udf allocation queue to start fresh for every slice */
        BCM_MemSet(aProgramUDFQ, 0U, sizeof(ETHSWT_CFPUDFQueueEntryType) * ETHSWT_CFP_MAX_UDFS);

        for (udf = 0UL; udf < aKey->numEnabledUDFs; ++udf) {

            uint8_t currentUDFAddress = aKey->udfList[udf].baseAndOffset;

            uint32_t UDFAccomodated = FALSE;
            uint32_t freeSlot = ETHSWT_CFP_MAX_UDFS;

            /* There can be holes in the allocated UDFs so search through */
            /* the complete list. Also store any free slots just in case  */
            /* the search fails completely                                */
            for (slot = 0UL ; slot < ETHSWT_CFP_MAX_UDFS; ++slot) {
                if(1U == aActiveUDFList->udfs[slice][slot].enable) {

                    if (aActiveUDFList->udfs[slice][slot].address ==
                            currentUDFAddress) {

                        /* No need to look at any more UDF slots */
                        UDFAccomodated = TRUE;
                        break;
                    }
                } else {
                    /* Store any free slot so that it is easy to */
                    /* allocate                                  */
                    if (ETHSWT_CFP_MAX_UDFS == freeSlot) {
                        freeSlot = slot;
                    }
                }
            } /* All UDF slots in current slice */

            if (TRUE == UDFAccomodated) {
                ETHSWT_CFPUDFQueueEntryType* entry = &aProgramUDFQ[slot];
                /* Insert into the queue so that it can */
                /* be unrolled if required              */
                entry->enable  = 1U;
                entry->address = currentUDFAddress;
                entry->value   = aKey->udfList[udf].value;
                entry->mask    = aKey->udfList[udf].mask;
                entry->created = 1U;
            } else if (ETHSWT_CFP_MAX_UDFS > freeSlot) {
                ETHSWT_CFPUDFQueueEntryType* entry = &aProgramUDFQ[freeSlot];
                /* Use this free UDF */
                aActiveUDFList->udfs[slice][freeSlot].enable = 1U;
                aActiveUDFList->udfs[slice][freeSlot].address = currentUDFAddress;

                /* Insert into the queue so that it can */
                /* be unrolled if required              */
                entry->enable  = 1U;
                entry->address = currentUDFAddress;
                entry->value   = aKey->udfList[udf].value;
                entry->mask    = aKey->udfList[udf].mask;
                entry->created = 0U;
            } else {
                /* If even a single UDF is not accomodated, */
                /* unroll and hope that the next slice will */
                /* be able to accomodate                    */
                /* Unroll: Deallocate all the allocated UDFs */
                for (slot = 0UL ; slot < ETHSWT_CFP_MAX_UDFS; ++slot) {
                    if ((TRUE == aProgramUDFQ[slot].enable) &&
                        (FALSE == aProgramUDFQ[slot].created)) {
                        aActiveUDFList->udfs[slice][slot].enable = 0U;
                        aActiveUDFList->udfs[slice][slot].address = 0U;
                    }
                }
                /* The rule does not fit into the current slice */
                ruleFitsInCurrSlice = FALSE;
                break;
            }
        } /* All UDFs in the UDFList in the config */

        if (TRUE == ruleFitsInCurrSlice) {
            ret = BCM_ERR_OK;
            *aSlice = (uint32_t)slice;
            break;
        }
    }
    return ret;
}
/** @brief CFP program rule

    @behavior Sync, Re-entrant

    @pre None

    @param[in]     aID              Switch index
    @param[in]     aKey             Pointer to key configuration
    @param[in]     aAction          Pointer to action configuration
    @param[inout]  aRow             Pointer to row number
    @param[inout]  aSlice           Slice number

    Return values are documented in reverse-chronological order
    @retval  #BCM_ERR_OK            Rule is programmed successfully
    @retval  #BCM_ERR_NOMEM         Rule is not programmed
    @return  Others                 As retunrned by #ETHSWT_CFPDrvAllocateRow

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @limitations None
    @code{.unparsed}
    validate rule
    for all slices: ETHSWT_CFP_MAX_SLICES->0
        for all valid UDFs in config: 0->numEnabledUDFs
            for all UDFs in current slice: 0->ETHSWT_CFP_MAX_UDFS
                if slice UDF == config UDF
                    UDFAccomodated = true
                    break
                else if slice UDF free
                    store UDF number
                    UDFAccomodated = true
                    slice UDF = config UDF
                else
                    UDFAccomodated = false
            if true == UDFAccomodated
                push to UDF scratch queue
            else
                slice UDF = free
        if all UDFs in config accomodated
            if row allocation succeeds
                program action policy RAM
                program rate meter RAM
                program UDFs
                program TCAM
                for all slice UDFs: 0->ETHSWT_CFP_MAX_UDFS
                    if slice UDF == config UDF
                        mark slice UDF having current row
                update S/W cache
                increment rule count
                clear stats in H/W
    @endcode
*/
static int32_t ETHSWT_CFPDrvProgramRule(ETHSWT_HwIDType aID,
                                  const ETHSWT_CFPKeyType* const aKey,
                                  const ETHSWT_CFPActionType* const aAction,
                                  uint32_t* const aRow,
                                  uint32_t* const aSlice)
{
    uint32_t                    format;
    uint32_t                    slot;
    int32_t                     ret            = BCM_ERR_OK;
    ETHSWT_CFPUDFAllocListType *list           = NULL;
    uint32_t                    line           = 0UL;
    uint32_t                    row            = *aRow;
    uint32_t                    slice          = *aSlice;
    uint32_t                    udfMap         = 0UL;
    ETHSWT_CFPStatsType         stats          = {0UL, 0UL, 0UL};
    ETHSWT_CFPUDFQueueEntryType udfScratchQ[ETHSWT_CFP_MAX_UDFS];

    if (ETHSWT_CFPHandle.numRules >= ETHSWT_CFPHandle.numAllowedRules) {
        ret     = BCM_ERR_NOMEM;
        line    = __LINE__;
        goto err_exit;
    }

    /* Validate input row number */
    if (ETHSWT_CFPHandle.numAllowedRules < *aRow) {
        ret     = BCM_ERR_INVAL_PARAMS;
        line    = __LINE__;
        row = *aRow;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvValidateKey(aID, aKey));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvValidateAction(aID, aAction));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvGetFormat(aKey->l3Framing, &format));

    list = &ETHSWT_CFPHandle.udfList[format];

    ret = ETHSWT_CFPDrvFindSlice(aID, aKey, &slice, list, udfScratchQ);
    if (BCM_ERR_OK == ret) {
        /* Generate the row number if required */
        ret = ETHSWT_CFPDrvAllocateRow(aID, &row);
        if (BCM_ERR_OK == ret) {
            ETHSWT_CFPHandle.numRules++;

            /* Write to HW: First disable any existing rule at the row. Once this is done */
            /* we can safely clear the statistics and then proceed with programming the   */
            /* new rule                                                                   */
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetRuleValid(aID, row, FALSE));
            /* Clear the stats in HW */
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetStats(aID, row, &stats));
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramTCAM(aID, row, slice, aKey, udfScratchQ));
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramActionPolicyRAM(aID, row, aAction));
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramRateMeterRAM(aID, row, &aAction->meter));
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramUDFs(aID, format, slice, &ETHSWT_CFPRegs->a1_udf_0_a_0, udfScratchQ));
            ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetRuleValid(aID, row, TRUE));

            /* Store in cache */
            ETHSWT_CFPHandle.rules[row] = (ETHSWT_CFPRuleDataType)((ETHSWT_CFP_RULEDATA_ENABLE_MASK) |
                                    ((slice << ETHSWT_CFP_RULEDATA_SLICE_SHIFT) & ETHSWT_CFP_RULEDATA_SLICE_MASK) |
                                    ((format << ETHSWT_CFP_RULEDATA_FORMAT_SHIFT) & ETHSWT_CFP_RULEDATA_FORMAT_MASK));

            /* Once the row number is allocated, mark all the UDFs */
            /* associated with this rule                           */
            udfMap = 0UL;
            for (slot = 0UL ; slot < ETHSWT_CFP_MAX_UDFS; ++slot) {
                if (TRUE == udfScratchQ[slot].enable) {
                    udfMap |= (1UL << slot);
                }
            }

            ETHSWT_CFPHandle.rules[row] |= (ETHSWT_CFPRuleDataType)((udfMap << ETHSWT_CFP_RULEDATA_UDFMAP_SHIFT) & ETHSWT_CFP_RULEDATA_UDFMAP_MASK);

            *aRow   = row;
            *aSlice = slice;
        } else {
            /* Clean up if row number allocation fails */
            for (slot = 0UL ; slot < ETHSWT_CFP_MAX_UDFS; ++slot) {
                if ((TRUE == udfScratchQ[slot].enable) &&
                    (FALSE == udfScratchQ[slot].created)) {
                    list->udfs[slice][slot].enable = 0U;
                    list->udfs[slice][slot].address = 0U;
                }
            }
            line = __LINE__;
        }
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVPROGRAMRULE_PART_PROC, ret,
                        line, row, slice, 0UL);
    }
    return ret;
}

/**
    @brief CFP Driver Initialization

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Switch index
    @param[inout]   aConfig     Pointer to configuration structure

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On success
    @retval     #BCM_ERR_INVAL_STATE    (If CFP is not initialized state) or
                                        (If CFP rule size is > max rules)
    @return     Others                 As returned by #ETHSWT_CFPDrvResetAndClearTCAM or
                                        by #ETHSWT_CFPDrvValidatePktLenCorr or
                                        by #ETHSWT_CFPDrvProgramRule

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if state == RESET
        reset and clear CFP
        enable CFP
        validate packet length correction
        set the packet length correction in rate meter global control register
        enable global rate meter
        set state = INITIALIZED
        for all rules in config: 0->ruleListSz
            add rule
    @endcode
*/
static int32_t ETHSWT_CFPDrvInit(ETHSWT_HwIDType aID,
                    const ETHSWT_CFPConfigType* const aConfig)
{
    uint16_t regVal;
    uint32_t line;
    uint32_t row   = ETHSWT_CFP_MAX_INIT_RULES;
    uint32_t slice = ETHSWT_CFP_MAX_SLICES;
    int32_t  ret   = BCM_ERR_OK;
    uint32_t i     = 0UL;

    if (ETHSWT_CFP_STATE_RESET != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    if (aConfig->ruleListSz > ETHSWT_CFP_MAX_INIT_RULES) {
        ret     = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_CFPDrvResetAndClearTCAM(aID);
    if (BCM_ERR_OK != ret) {
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_CFPDrvValidatePktLenCorr(aID, aConfig->pktLenCorr);
    if (BCM_ERR_OK != ret) {
        line = __LINE__;
        goto err_exit;
    }

    /* Clear the CFP context structure */
    BCM_MemSet(&ETHSWT_CFPHandle, 0U, sizeof(ETHSWT_CFPHandle));
    /* Set the number of rows available for CFP */
    ETHSWT_CFPHandle.numAllowedRules = ETHSWT_CFP_MAX_RULES;

    /* Rate Meter Global Ctrl */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter_global_ctl,
                               &regVal));
    regVal |= (uint16_t)((aConfig->pktLenCorr << SWITCH_PA0RMGC_PAGE_A0_RATE_METER_GLOBAL_CTL_PKT_LEN_CORR_SHIFT) &
               SWITCH_PA0RMGC_PAGE_A0_RATE_METER_GLOBAL_CTL_PKT_LEN_CORR_MASK);

    regVal |= SWITCH_PA0RMGC_PA0RMGCRRE_MASK;

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter_global_ctl,
                                regVal));

    for (; i < aConfig->ruleListSz; ++i) {
        row   = (uint32_t)((aConfig->ruleList[i].rowAndSlice & ETHSWT_CFP_ROWANDSLICE_ROW_MASK) >> ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT);
        slice = (uint32_t)((aConfig->ruleList[i].rowAndSlice & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK) >> ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT);
        ret = ETHSWT_CFPDrvProgramRule(aID, &aConfig->ruleList[i].key, &aConfig->ruleList[i].action, &row, &slice);
        if (BCM_ERR_OK != ret) {
            line = __LINE__;
            break;
        }
        /* Rules received during initialization are treated as RO */
        ETHSWT_CFPHandle.rules[row] |= ETHSWT_CFP_RULEDATA_STATIC_MASK;
    }

    if (BCM_ERR_OK == ret) {
        regVal = 0U;
#if (1UL == SWITCH_CFP_UDP_END_OF_L2_BUG_FIX)
        /* Bit to enable fix for End of L2 bug during UDF parsing */
        regVal = ((SWITCH_CFP_UDP_END_OF_L2_BUG_FIX <<
                   SWITCH_PA1CUCR_PAGE_A1_CFP_UDF_CTL_REG_END_OF_L2_FIX_EN_SHIFT) & SWITCH_PA1CUCR_PAGE_A1_CFP_UDF_CTL_REG_END_OF_L2_FIX_EN_MASK);
#endif
        /* Enable CFP feature on ports enabled in the config */
        regVal |= (SWITCH_PAGE_A1_CFP_CTL_REG_EN_MAP_MASK & aConfig->portEnableMask);
        ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, regVal));

        /* Initialize the state */
        ETHSWT_CFPHandle.state = ETHSWT_CFP_STATE_INITIALIZED;
    }

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVINIT_PROC, ret,
                           line, i, row, slice);
    }
    return ret;
}

/**
    @brief CFP Add rule

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Switch index
    @param[in]      aKey            Pointer to key configuration
    @param[in]      aAction         Pointer to action configuration
    @param[inout]   aRow            Pointer to row number
    @param[inout]   aSlice          Slice number

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_INVAL_STATE    If CFP is not in Initialized state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if state == INITIALIZED
        program rule
    @endcode
*/
static int32_t ETHSWT_CFPDrvAddRule(ETHSWT_HwIDType aID,
                       const ETHSWT_CFPKeyType* const aKey,
                       const ETHSWT_CFPActionType* const aAction,
                       uint32_t* const aRow,
                       uint32_t* const aSlice)
{
    int32_t  ret  = BCM_ERR_OK;
    uint32_t line = 0UL;

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret  = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramRule(aID, aKey, aAction, aRow, aSlice));
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVADDRULE_PROC, ret,
                           line, *aRow, *aSlice, 0UL);
    }
    return ret;
}

/**
    @brief CFP Remove rule

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID         Switch Index
    @param[in]  aRow        Row number

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in Initialized state
    @retval     #BCM_ERR_NOPERM         If rule is static

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if state == INITIALIZED
        if rule exists
            invalidate TCAM entry
            clear the green statistics counter
            clear the yellow statistics counter
            clear the green statistics counter
            for all UDFs in the slice: 0->ETHSWT_CFP_MAX_UDFS
                if rulesAssociated bitmap has rowNum set
                    clear rowNum from rulesAssociated bitmap
                    if rulesAssociated bitmap is zero
                        remove UDF from H/W
                        remove UDF from S/W cache
            remove rule from S/W cache
            decrement rule count
    @endcode
*/
static int32_t ETHSWT_CFPDrvRemoveRule(ETHSWT_HwIDType aID,
                          uint32_t aRow)
{
    int32_t                     ret = BCM_ERR_OK;
    ETHSWT_CFPUDFAllocListType *list = NULL;
    uint32_t                    format;
    uint32_t                    udf;
    uint32_t                    udfMap;
    uint8_t                     slice;
    uint32_t                    i;
    uint32_t                    total;
    uint32_t                    line;
    ETHSWT_CFPStatsType        stats = {0UL, 0UL, 0UL};

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvCheckIfRuleExists(aRow));

    if (BCM_ERR_OK == ETHSWT_CFPDrvCheckIfRuleIsStatic(aRow)) {
        ret = BCM_ERR_NOPERM;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetRuleValid(aID, aRow, FALSE));

    /* Clear the statistics RAM so that the counters can be reused if the */
    /* row gets enabled in the future                                     */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetStats(aID, aRow, &stats));

    /* Check if any UDFs can be freed up. Need to restrict the search to the */
    /* particular format and slice                                           */
    format = (uint32_t)((ETHSWT_CFPHandle.rules[aRow] & ETHSWT_CFP_RULEDATA_FORMAT_MASK) >> ETHSWT_CFP_RULEDATA_FORMAT_SHIFT);
    slice  = (uint8_t)((ETHSWT_CFPHandle.rules[aRow] & ETHSWT_CFP_RULEDATA_SLICE_MASK)  >> ETHSWT_CFP_RULEDATA_SLICE_SHIFT);
    udfMap = (uint32_t)((ETHSWT_CFPHandle.rules[aRow] & ETHSWT_CFP_RULEDATA_UDFMAP_MASK) >> ETHSWT_CFP_RULEDATA_UDFMAP_SHIFT);
    list   = &ETHSWT_CFPHandle.udfList[format];

    /* Remove rule from SW */
    ETHSWT_CFPHandle.rules[aRow] = 0U;
    ETHSWT_CFPHandle.numRules--;

    /* Check if any UDFs can be freed */
    for (udf = 0UL ; udf < ETHSWT_CFP_MAX_UDFS; ++udf) {
        if (0UL != (udfMap & (1UL << udf))) {
            /* Check if there are any leftover rules using this UDF */
            total = 0UL;
            for (i = 0UL; i < ETHSWT_CFPHandle.numAllowedRules; ++i) {
                if ((BCM_ERR_OK == ETHSWT_CFPDrvCheckIfRuleExists(i)) &&
                    (0UL != ((uint32_t)((ETHSWT_CFPHandle.rules[i] & ETHSWT_CFP_RULEDATA_UDFMAP_MASK) >> ETHSWT_CFP_RULEDATA_UDFMAP_SHIFT) & (1UL << udf)))) {
                    total++;
                    break;
                }
            }
            if (0UL == total) {
                /* Remove UDF from HW */
                ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg(aID, (uint32_t)&ETHSWT_CFPRegs->a1_udf_0_a_0 +
                            (format  * 0x30UL) +
                            (slice * 0x10UL) + udf, 0ULL));

                /* Remove UDF from SW */
                list->udfs[slice][udf].enable  = 0U;
                list->udfs[slice][udf].address = 0U;
            }
        }
    }
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVREMOVERULE_PROC, ret,
                        line, aRow, (uint32_t)ETHSWT_CFPHandle.state, 0UL);
    }
    return ret;
}

/**
    @brief CFP Update rule

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID     Switch Index
    @param[in]  aRow    Row Number
    @param[in]  aAction Pointer to action configuration

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in Initialize state
    @retval     #BCM_ERR_NOPERM         If rule is static

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if state is INITIALIZED
        if rule exists and is not static
            program action policy RAM
    @endcode
*/
static int32_t ETHSWT_CFPDrvUpdateRule(ETHSWT_HwIDType aID,
                          uint32_t aRow,
                          const ETHSWT_CFPActionType* const aAction)
{
    ETHSWT_CFPStatsType stats = {0UL, 0UL, 0UL};
    int32_t       ret = BCM_ERR_OK;
    uint32_t      line;

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvCheckIfRuleExists(aRow));

    if (BCM_ERR_OK == ETHSWT_CFPDrvCheckIfRuleIsStatic(aRow)) {
        ret = BCM_ERR_NOPERM;
        line = __LINE__;
        goto err_exit;
    }

    /* First disable the rule */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetRuleValid(aID, aRow, FALSE));
    /* Reset the statistics */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetStats(aID, aRow, &stats));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramActionPolicyRAM(aID, aRow, aAction));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvProgramRateMeterRAM(aID, aRow, &aAction->meter));
    /* Re-enable the rule */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvSetRuleValid(aID, aRow, TRUE));
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVUPDATERULE_PROC, ret,
                        line, aRow, (uint32_t)ETHSWT_CFPHandle.state, 0UL);
    }
    return ret;
}

/** @brief CFP Get snapshot

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID         Switch Index
    @param[inout]   aSnapshot   Snapshot

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On success
    @retval         #BCM_ERR_INVAL_STATE    If CFP is not in initialized state

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_CFPDrvGetSnapshot(ETHSWT_HwIDType aID,
                                  ETHSWT_CFPSnapshotType *const aSnapshot)
{
    uint16_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;
    uint32_t i;

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    aSnapshot->numValidEntries = ETHSWT_CFPHandle.numRules;
    BCM_MemSet(aSnapshot->entry, 0U, sizeof(ETHSWT_CFPEntrySnapshotType)*ETHSWT_CFP_MAX_RULES);
    for (i = 0UL; i < ETHSWT_CFPHandle.numAllowedRules; ++i) {
        aSnapshot->entry[i] = (ETHSWT_CFPEntrySnapshotType)((ETHSWT_CFPHandle.rules[i] >>
                               ETHSWT_CFP_RULEDATA_FORMAT_SHIFT) << ETHSWT_CFP_ENTRYSNAPSHOT_FORMAT_SHIFT);
    }
    BCM_MemCpy(&aSnapshot->udfList, &ETHSWT_CFPHandle.udfList, sizeof(aSnapshot->udfList));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, &regVal));
    aSnapshot->portEnableMask = regVal & SWITCH_PAGE_A1_CFP_CTL_REG_EN_MAP_MASK;

err_exit:
    if (BCM_ERR_OK != ret)  {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVGETSNAPSHOT_PART_PROC, ret,
                           line, (uint32_t)ETHSWT_CFPHandle.state, 0UL, 0UL);
    }
    return ret;

}

/**
    @brief CFP Driver get key config for specified row

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVGETKEY_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_CFPDrvGetKey(ETHSWT_HwIDType aID,
                            uint32_t aRow,
                            ETHSWT_CFPKeyType *const aKey,
                            uint16_t *const aSlice,
                            volatile uint8_t *aUDFBaseAddr)
{
    uint32_t regVal;
    uint32_t regVal2;
    uint32_t counter;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;
    uint32_t i;
    uint32_t format;
    uint16_t udfValid;
    uint32_t slice = ETHSWT_CFP_MAX_SLICES;
    uint32_t isUDFValid = FALSE;
    ETHSWT_CFPAcceptableFrameType frame;

    /* Initialize the data structures */
    BCM_MemSet(aKey, 0U, sizeof(ETHSWT_CFPKeyType));

    /* Read the Key */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_TCAM << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK) |
                SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK
                )));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* DATA0 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data0, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask0, &regVal2));

    if ((regVal2 & SWITCH_CFP_DATA0_SLICEID_MASK) >> SWITCH_CFP_DATA0_SLICEID_SHIFT) {
        slice = (regVal & SWITCH_CFP_DATA0_SLICEID_MASK) >> SWITCH_CFP_DATA0_SLICEID_SHIFT;
        *aSlice = (uint16_t)((slice <<ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT) & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK);
    } else {
        goto err_exit;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA0_UDF0_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA0_UDF0_MASK) >> SWITCH_CFP_DATA0_UDF0_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA0_UDF0_MASK) >> SWITCH_CFP_DATA0_UDF0_SHIFT);
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA0_UDF1_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA0_UDF1_MASK) >> SWITCH_CFP_DATA0_UDF1_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA0_UDF1_MASK) >> SWITCH_CFP_DATA0_UDF1_SHIFT);
        isUDFValid = TRUE;
    }

    /* DATA1 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data1, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask1, &regVal2));

    if (0UL != (regVal2 & SWITCH_CFP_DATA1_UDF1_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value |= (uint16_t)(((regVal & SWITCH_CFP_DATA1_UDF1_MASK) >> SWITCH_CFP_DATA1_UDF1_SHIFT) << 8UL);
        aKey->udfList[aKey->numEnabledUDFs].mask  |= (uint16_t)(((regVal2 & SWITCH_CFP_DATA1_UDF1_MASK) >> SWITCH_CFP_DATA1_UDF1_SHIFT) << 8UL);
        isUDFValid = TRUE;
    }
    if (TRUE == isUDFValid) {
        aKey->numEnabledUDFs++;
        isUDFValid = FALSE;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA1_UDF2_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA1_UDF2_MASK) >> SWITCH_CFP_DATA1_UDF2_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA1_UDF2_MASK) >> SWITCH_CFP_DATA1_UDF2_SHIFT);
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA1_UDF3_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA1_UDF3_MASK) >> SWITCH_CFP_DATA1_UDF3_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA1_UDF3_MASK) >> SWITCH_CFP_DATA1_UDF3_SHIFT);
        isUDFValid = TRUE;
    }

    /* DATA2 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data2, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask2, &regVal2));

    if (0UL != (regVal2 & SWITCH_CFP_DATA2_UDF3_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value |= (uint16_t)(((regVal & SWITCH_CFP_DATA2_UDF3_MASK) >> SWITCH_CFP_DATA2_UDF3_SHIFT) << 8UL);
        aKey->udfList[aKey->numEnabledUDFs].mask  |= (uint16_t)(((regVal2 & SWITCH_CFP_DATA2_UDF3_MASK) >> SWITCH_CFP_DATA2_UDF3_SHIFT) << 8UL);
        isUDFValid = TRUE;
    }
    if (TRUE == isUDFValid) {
        aKey->numEnabledUDFs++;
        isUDFValid = FALSE;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA2_UDF4_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA2_UDF4_MASK) >> SWITCH_CFP_DATA2_UDF4_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA2_UDF4_MASK) >> SWITCH_CFP_DATA2_UDF4_SHIFT);
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA2_UDF5_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA2_UDF5_MASK) >> SWITCH_CFP_DATA2_UDF5_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA2_UDF5_MASK) >> SWITCH_CFP_DATA2_UDF5_SHIFT);
        isUDFValid = TRUE;
    }

    /* DATA3 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data3, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask3, &regVal2));

    if (0UL != (regVal2 & SWITCH_CFP_DATA3_UDF5_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value |= (uint16_t)(((regVal & SWITCH_CFP_DATA3_UDF5_MASK) >> SWITCH_CFP_DATA3_UDF5_SHIFT) << 8UL);
        aKey->udfList[aKey->numEnabledUDFs].mask  |= (uint16_t)(((regVal2 & SWITCH_CFP_DATA3_UDF5_MASK) >> SWITCH_CFP_DATA3_UDF5_SHIFT) << 8UL);
        isUDFValid = TRUE;
    }
    if (TRUE == isUDFValid) {
        aKey->numEnabledUDFs++;
        isUDFValid = FALSE;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA3_UDF6_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA3_UDF6_MASK) >> SWITCH_CFP_DATA3_UDF6_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA3_UDF6_MASK) >> SWITCH_CFP_DATA3_UDF6_SHIFT);
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA3_UDF7_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA3_UDF7_MASK) >> SWITCH_CFP_DATA3_UDF7_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA3_UDF7_MASK) >> SWITCH_CFP_DATA3_UDF7_SHIFT);
        isUDFValid = TRUE;
    }

    /* DATA4 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data4, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask4, &regVal2));

    if (0UL != (regVal2 & SWITCH_CFP_DATA4_UDF7_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value |= (uint16_t)(((regVal & SWITCH_CFP_DATA4_UDF7_MASK) >> SWITCH_CFP_DATA4_UDF7_SHIFT) << 8UL);
        aKey->udfList[aKey->numEnabledUDFs].mask  |= (uint16_t)(((regVal2 & SWITCH_CFP_DATA4_UDF7_MASK) >> SWITCH_CFP_DATA4_UDF7_SHIFT) << 8UL);
        isUDFValid = TRUE;
    }
    if (TRUE == isUDFValid) {
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA4_UDF8_MASK)) {
        aKey->udfList[aKey->numEnabledUDFs].value = (uint16_t)((regVal & SWITCH_CFP_DATA4_UDF8_MASK) >> SWITCH_CFP_DATA4_UDF8_SHIFT);
        aKey->udfList[aKey->numEnabledUDFs].mask  = (uint16_t)((regVal2 & SWITCH_CFP_DATA4_UDF8_MASK) >> SWITCH_CFP_DATA4_UDF8_SHIFT);
        aKey->numEnabledUDFs++;
    }

    if (0UL != (regVal2 & SWITCH_CFP_DATA4_CTAG_MASK)) {
        aKey->cTagFlags = ((regVal & SWITCH_CFP_DATA4_CTAG_MASK) >> SWITCH_CFP_DATA4_CTAG_SHIFT) << ETHSWT_CFP_KEY_TAG_ID_SHIFT;
        aKey->cTagMask = (uint16_t)(((regVal2 & SWITCH_CFP_DATA4_CTAG_MASK) >> SWITCH_CFP_DATA4_CTAG_SHIFT) << ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        aKey->cTagFlags |= ETHSWT_CFP_KEY_TAG_ID_VALID_MASK;
    }

    /* DATA5 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data5, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask5, &regVal2));

    if (0x10UL == (regVal2 & 0x10UL)) {
        aKey->cTagFlags |= ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK;
        aKey->cTagFlags |= ((uint32_t) regVal & 0x10UL) << 10UL;
    }
    if (0UL != (regVal2 & 0xE0UL)) {
        aKey->cTagFlags |= ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK;
        aKey->cTagFlags |= (regVal & 0xE0UL) << 10UL;
        aKey->cTagMask  |= (uint16_t)(((regVal2 & 0xE0UL) >> 5UL) << ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
    }
    if (0UL != (regVal2 & 0x0FUL)) {
        aKey->cTagFlags |= ((regVal & 0x0FUL) >> SWITCH_CFP_DATA5_CTAG_SHIFT) << 10UL;
        aKey->cTagMask  |= (uint16_t)(((regVal2 & 0x0FUL) >> SWITCH_CFP_DATA5_CTAG_SHIFT) << 8UL);
        aKey->cTagFlags |= ETHSWT_CFP_KEY_TAG_ID_VALID_MASK;
    }

    if (0UL != (regVal2 & 0x100000UL)) {
        aKey->sTagFlags  = ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK;
        aKey->sTagFlags |= ((regVal & 0x100000UL) >> 20UL) << ETHSWT_CFP_KEY_TAG_DEI_SHIFT;
    }

    if (0UL != (regVal2 & 0xE00000UL)) {
        aKey->sTagFlags |= ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK;
        aKey->sTagFlags |= ((regVal & 0xE00000UL) >> 21UL) << ETHSWT_CFP_KEY_TAG_PCP_SHIFT;
        aKey->sTagMask   = (uint16_t)(((regVal2 & 0xE00000UL) >> 21UL) << ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
    }

    if (0UL != (regVal2 & 0xFFF00UL)) {
        aKey->sTagFlags |= ((regVal & SWITCH_CFP_DATA5_STAG_MASK) >> SWITCH_CFP_DATA5_STAG_SHIFT) << ETHSWT_CFP_KEY_TAG_ID_SHIFT;
        aKey->sTagMask  |= (uint16_t)(((regVal2 & SWITCH_CFP_DATA5_STAG_MASK) >> SWITCH_CFP_DATA5_STAG_SHIFT) << ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        aKey->sTagFlags |= ETHSWT_CFP_KEY_TAG_ID_VALID_MASK;
    }

    udfValid = (uint16_t)((regVal & SWITCH_CFP_DATA5_UDFVALID_7_0_MASK) >> SWITCH_CFP_DATA5_UDFVALID_7_0_SHIFT);
    udfValid &= (uint16_t)((regVal2 & SWITCH_CFP_DATA5_UDFVALID_7_0_MASK) >> SWITCH_CFP_DATA5_UDFVALID_7_0_SHIFT);

    /* DATA6 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_data6, &regVal));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask6, &regVal2));

    if (SWITCH_CFP_DATA6_UDFVALID_8_MASK == (regVal2 & SWITCH_CFP_DATA6_UDFVALID_8_MASK)) {
        udfValid |= (uint16_t)(((regVal & SWITCH_CFP_DATA6_UDFVALID_8_MASK) >> SWITCH_CFP_DATA6_UDFVALID_8_SHIFT) << 8UL);
    }

    aKey->l2Framing  = (ETHSWT_CFPL2FramingType)((regVal & SWITCH_CFP_DATA6_L2FRAMING_MASK) >> SWITCH_CFP_DATA6_L2FRAMING_SHIFT);
    aKey->l3Framing  = (ETHSWT_CFPL3FramingType)((regVal & SWITCH_CFP_DATA6_L3FRAMING_MASK) >> SWITCH_CFP_DATA6_L3FRAMING_SHIFT);

    switch(aKey->l3Framing) {
        case ETHSWT_CFP_L3FRAMING_IPV4:
            /* Fall through intentional */
        case ETHSWT_CFP_L3FRAMING_IPV6:
            aKey->flagsMask = (regVal2 >> SWITCH_CFP_DATA6_TTL_SHIFT) & ETHSWT_CFP_KEY_IP_MASK;
            aKey->flags     = (regVal >> SWITCH_CFP_DATA6_TTL_SHIFT) & ETHSWT_CFP_KEY_IP_MASK;
            break;
        case ETHSWT_CFP_L3FRAMING_NONIP:
            aKey->flagsMask = (regVal2 >> SWITCH_CFP_DATA6_ETHTYPE_SHIFT) & ETHSWT_CFP_KEY_NONIP_MASK;
            aKey->flags     = (regVal >> SWITCH_CFP_DATA6_ETHTYPE_SHIFT) & ETHSWT_CFP_KEY_NONIP_MASK;
            break;
        default:
            ret = BCM_ERR_INVAL_PARAMS;
            line = __LINE__;
            break;
    }
    if (ret != BCM_ERR_OK) {
        goto err_exit;
    }

    frame = ETHSWT_CFPDrvTagStatustoAFT(aID,((regVal & SWITCH_CFP_DATA6_CTAGSTATUS_MASK) >> SWITCH_CFP_DATA6_CTAGSTATUS_SHIFT),
             ((regVal2 & SWITCH_CFP_DATA6_CTAGSTATUS_MASK) >> SWITCH_CFP_DATA6_CTAGSTATUS_SHIFT));

    aKey->cTagFlags |= frame << ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT;

    frame = ETHSWT_CFPDrvTagStatustoAFT(aID, ((regVal & SWITCH_CFP_DATA6_STAGSTATUS_MASK) >> SWITCH_CFP_DATA6_STAGSTATUS_SHIFT),
             ((regVal2 & SWITCH_CFP_DATA6_STAGSTATUS_MASK) >> SWITCH_CFP_DATA6_STAGSTATUS_SHIFT));

    aKey->sTagFlags |= frame << ETHSWT_CFP_KEY_TAG_UN_TAGGED_SHIFT;

    /* DATA7 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_mask7, &regVal2));
    aKey->ingressPortBitmap = (uint16_t)(~(regVal2 >> SWITCH_CFP_DATA7_SRCPRTMAP_SHIFT) & SWITCH_CFP_DATA7_SRCPRTMAP_MASK);

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvGetFormat(aKey->l3Framing, &format));

    /* Get the UDFs */
    counter = 0UL;
    for (i = 0UL; i < ETHSWT_CFP_MAX_UDFS; ++i) {
        if (0UL != ((1UL << i) & udfValid)) {
            ret = ETHSWT_DrvReadReg32(aID, (uint32_t)aUDFBaseAddr +
                                     (format * 0x30UL) +
                                     (slice * 0x10UL) + i, &regVal);
            if (BCM_ERR_OK == ret) {
                aKey->udfList[counter++].baseAndOffset = (uint8_t)regVal;
            }
        }
    }

err_exit:
    if ((BCM_ERR_OK != ret) && (BCM_ERR_NOT_FOUND != ret)) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVGETKEY_PROC, ret,
                           line, aRow, slice, 0UL);
    }
    return ret;
}

/** @brief CFP Get action configuration for specified row

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aID             Switch Index
    @param[in]      aRow            Row number
    @param[out]     aAction         Pointer to action structure

    Return values are documented in reverse-chronological order
    @retval         #BCM_ERR_OK             On success
    @return         Others                  As returned by #ETHSWT_DrvReadReg

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
static int32_t ETHSWT_CFPDrvGetAction(ETHSWT_HwIDType aID,
                                      uint32_t aRow,
                                      ETHSWT_CFPActionType *const aAction)
{
    uint32_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;

    /* Initialize the data structures */
    BCM_MemSet(aAction, 0U, sizeof(ETHSWT_CFPActionType));

    /* Read the action policy RAM */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
            (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
            ((SWITCH_CFP_ACC_RAM_SEL_ACT_POL << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
            SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
            ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)|
            SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* ACT_POL_DATA0 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data0, &regVal));
    aAction->otherFlags = (uint8_t)((regVal & SWITCH_CFP_ACT_POL_DATA0_BYPASS_MASK) >> SWITCH_CFP_ACT_POL_DATA0_BYPASS_SHIFT);
    aAction->otherFlags |= (uint8_t)((((regVal & SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_LOOP_BK_EN_MASK) >>
                                  SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_LOOP_BK_EN_SHIFT) << ETHSWT_CFP_ACTION_LPBK_EN_SHIFT) &
                                  ETHSWT_CFP_ACTION_LPBK_EN_MASK);

    aAction->reasonCode = (uint8_t)((regVal & SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_REASON_CODE_MASK) >> SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_REASON_CODE_SHIFT);
    aAction->tcFlags = (uint8_t)((regVal & SWITCH_CFP_ACT_POL_DATA0_TC_MASK) >> SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_TC_SHIFT);
    aAction->dstMapIBFlags = (regVal & SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_DST_MAP_IB_MASK) >> SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_DST_MAP_IB_SHIFT;
    aAction->dstMapIBFlags |= ((regVal & SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_CHANGE_FWRD_MAP_IB_MASK) >>
                                     SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_CHANGE_FWRD_MAP_IB_SHIFT) << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT;
    aAction->tosIBFlags = (uint8_t)((regVal & SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_DSCP_IB_MASK) >> SWITCH_PA0APD0_PAGE_A0_ACT_POL_DATA0_NEW_DSCP_IB_SHIFT);

    /* ACT_POL_DATA1 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data1, &regVal));

    aAction->tosIBFlags |= (uint8_t)((((regVal & SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_DSCP_IB_MASK) >>
                                   SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_DSCP_IB_SHIFT) << ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) &
                                   ETHSWT_CFP_ACTION_CHANGE_TOS_MASK);
    aAction->dstMapOBFlags = (regVal & SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_DST_MAP_OB_MASK) >> SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_DST_MAP_OB_SHIFT;
    aAction->dstMapOBFlags |= ((regVal & SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_FWRD_MAP_OB_MASK) >>
                                     SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_FWRD_MAP_OB_SHIFT) << ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT;
    aAction->tosOBFlags = (uint8_t)((regVal & SWITCH_CFP_ACT_POL_DATA1_TOS_MASK) >> SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_NEW_DSCP_OB_SHIFT);
    aAction->chainID = (uint16_t)((regVal & SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHAIN_ID_MASK) >> SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHAIN_ID_SHIFT);
    aAction->colorFlags = (uint8_t)((regVal & SWITCH_CFP_ACT_POL_DATA1_COLOR_MASK) >> SWITCH_PA0APD1_PAGE_A0_ACT_POL_DATA1_CHANGE_COLOR_SHIFT);
#if defined(__BCM8953X__)
    aAction->otherFlags |= (((regVal & SWITCH_CFP_ACT_POL_DATA1_REDDFLT_MASK) >>
                                   SWITCH_CFP_ACT_POL_DATA1_REDDFLT_SHIFT) << ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) &
                                   ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK;
#endif

#if defined(__BCM8956X__) || defined(__BCM8957X__)
    /* ACT_POL_DATA2 */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_act_pol_data2, &regVal));
    aAction->otherFlags |= (uint8_t)((((regVal & ETHSWT_CFP_ACTION_MIRROR_OB_MASK) >>
                                   ETHSWT_CFP_ACTION_MIRROR_OB_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_OB_SHIFT) &
                                   SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_OB_MASK);
    aAction->otherFlags |= (uint8_t)((((regVal & ETHSWT_CFP_ACTION_MIRROR_IB_MASK) >>
                                   ETHSWT_CFP_ACTION_MIRROR_IB_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_IB_SHIFT) &
                                   SWITCH_CFP_ACT_POL_DATA2_MIR_ENABLE_IB_MASK);
    aAction->otherFlags |= (uint8_t)((((regVal & ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK) >>
                                   ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) << SWITCH_CFP_ACT_POL_DATA2_REDDFLT_SHIFT) &
                                   SWITCH_CFP_ACT_POL_DATA2_REDDFLT_MASK);
    aAction->otherFlags |= (uint8_t)((((regVal & SWITCH_CFP_ACT_POL_DATA2_MAC_LIMIT_BYPASS_MASK) >>
                                   SWITCH_CFP_ACT_POL_DATA2_MAC_LIMIT_BYPASS_SHIFT) << ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_SHIFT) &
                                   ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_MASK);
#endif

    /* Read rate meter */
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_cfp_acc,
                (((aRow << SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_SHIFT) & SWITCH_PAGE_A0_CFP_ACC_XCESS_ADDR_MASK)|
                ((SWITCH_CFP_ACC_RAM_SEL_RATE_METER << SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_RAM_SEL_MASK) |
                ((SWITCH_CFP_ACC_OP_SEL_RD << SWITCH_PAGE_A0_CFP_ACC_OP_SEL_SHIFT) &
                SWITCH_PAGE_A0_CFP_ACC_OP_SEL_MASK)| SWITCH_PAGE_A0_CFP_ACC_OP_STR_DONE_MASK)));

    ETHSWT_CFP_ERR_EXIT(ETHSWT_CFPDrvWaitForAccess(aID));

    /* RATE_METER0*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter0, &regVal));
    aAction->meter.policerFlags = (uint8_t)(regVal & SWITCH_CFP_RATE_METER0_MASK);

    /* RATE_METER1*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter1, &regVal));
    aAction->meter.eirTkBkt = regVal & SWITCH_PAGE_A0_RATE_METER1_EIR_TK_BKT_MASK;

    /* RATEMETER2*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter2, &regVal));
    aAction->meter.eirBktSize = regVal & SWITCH_PA0RM2_PAGE_A0_RATE_METER2_EIR_BKT_SIZE_MASK;

    /* RATEMETER3*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter3, &regVal));
    aAction->meter.eirRefCnt = regVal & SWITCH_PA0RM3_PAGE_A0_RATE_METER3_EIR_REF_CNT_MASK;

    /* RATEMETER4*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter4, &regVal));
    aAction->meter.cirTkBkt = regVal & SWITCH_PAGE_A0_RATE_METER4_CIR_TK_BKT_MASK;

    /* RATEMETER5*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter5, &regVal));
    aAction->meter.cirBktSize = regVal & SWITCH_PA0RM5_PAGE_A0_RATE_METER5_CIR_BKT_SIZE_MASK;

    /* RATEMETER6*/
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg32(aID, (uint32_t)&ETHSWT_CFPRegs->a0_rate_meter6, &regVal));
    aAction->meter.cirRefCnt = regVal & SWITCH_PA0RM6_PAGE_A0_RATE_METER6_CIR_REF_CNT_MASK;

err_exit:
    if ((BCM_ERR_OK != ret) && (BCM_ERR_NOT_FOUND != ret)) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVGETACTION_PROC, ret,
                           line, aRow, 0UL, 0UL);
    }
    return ret;
}


/**
    @brief CFP Driver enable port

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID     Switch Index
    @param[in]  aPort   Port number

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   If port number is invalid
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in initialized state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if state == INITIALIZED
        set bit corresponding to port in CFP Control register
    @endcode
*/
static int32_t ETHSWT_CFPDrvEnablePort(ETHSWT_HwIDType aID,
                          uint32_t aPort)
{
    uint16_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;

    if (aPort >= ETHSWT_PORT_ID_MAX) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, &regVal));
    regVal |= (uint16_t)(1UL << aPort);
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, regVal));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVENABLEPORT_PROC, ret,
                           line, aPort, (uint32_t)ETHSWT_CFPHandle.state, 0UL);
    }
    return ret;
}

/**
    @brief CFP Driver disable port

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID     Switch Index
    @param[in]  aPort   Port number

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_PARAMS   If port number is invalid
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in initialized state

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if state == INITIALIZED
        clear bit corresponding to port in CFP Control register
    @endcode
*/
static int32_t ETHSWT_CFPDrvDisablePort(ETHSWT_HwIDType aID,
                           uint32_t aPort)
{
    uint16_t regVal;
    int32_t  ret = BCM_ERR_OK;
    uint32_t line;

    if (aPort >= ETHSWT_PORT_ID_MAX) {
        ret = BCM_ERR_INVAL_PARAMS;
        line = __LINE__;
        goto err_exit;
    }

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvReadReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, &regVal));
    regVal &= (uint16_t)(~(1UL << aPort));
    ETHSWT_CFP_ERR_EXIT(ETHSWT_DrvWriteReg16(aID, (uint32_t)&ETHSWT_CFPRegs->a1_cfp_ctl_reg, regVal));

err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVDISABLEPORT_PROC, ret,
                        line, aPort, (uint32_t)ETHSWT_CFPHandle.state, 0UL);
    }
    return ret;
}

/**
    @brief CFP Driver Deinitialization

    @behavior Sync, Re-entrant

    @pre None

    @param[in]  aID     Switch Index

    Return values are documented in reverse-chronological order
    @retval     #BCM_ERR_OK             On Success
    @retval     #BCM_ERR_INVAL_STATE    If CFP is not in initialized state
    @return     Others                  As returned by #ETHSWT_CFPDrvResetAndClearTCAM

    @post None

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if state != RESET
        reset and clear CFP
        set state = RESET
    @endcode
*/
static int32_t ETHSWT_CFPDrvDeInit(ETHSWT_HwIDType aID)
{
    uint32_t line;
    int32_t  ret = BCM_ERR_OK;

    if (ETHSWT_CFP_STATE_RESET == ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
        line = __LINE__;
        goto err_exit;
    }

    ret = ETHSWT_CFPDrvResetAndClearTCAM(aID);
    if (BCM_ERR_OK != ret) {
        line = __LINE__;
        goto err_exit;
    }

    /* Update the state */
    BCM_MemSet(&ETHSWT_CFPHandle, 0U, sizeof(ETHSWT_CFPHandle));
    ETHSWT_CFPHandle.state = ETHSWT_CFP_STATE_RESET;
err_exit:
    if (BCM_ERR_OK != ret) {
        ETHSWT_CFPDrvReportError(BCM_CFP_ID, aID, BRCM_SWDSGN_ETHSWT_CFP_DRVDEINIT_PROC, ret,
                        line, (uint32_t)ETHSWT_CFPHandle.state, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Driver Initialization

    @trace #BRCM_SWARCH_ETHSWT_CFP_INIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if aID is valid and aConfig is non-NULL
        if aConfig magic is valid
            Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPInit(ETHSWT_HwIDType aID,
                 const ETHSWT_CFPConfigType* const aConfig)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;
    uint32_t magic = 0UL;
    if ((aID < SWITCH_MAX_HW_ID) && (NULL != aConfig)){
        if (ETHSWT_CFP_CONFIG_MAGIC_ID == aConfig->magicId) {
            swtIO.cfpIO = &cfpIO;
            cfpIO.cfpCfg  = aConfig;
            swtIO.retVal  = BCM_ERR_UNKNOWN;
            swtIO.swtHwID = aID;
            ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_INIT, &swtIO);
        } else {
            ret = BCM_ERR_INVAL_MAGIC;
            magic = aConfig->magicId;
        }
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_INIT_PROC, ret,
                         __LINE__, (uint32_t) aConfig, magic, 0UL);
    }
    return ret;
}

/**
    @brief CFP Add rule

    @trace #BRCM_SWARCH_ETHSWT_CFP_ADD_RULE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if aID is valid and aKey, aAction, aRow and aSlice are non-NULL
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPAddRule(ETHSWT_HwIDType aID,
                    const ETHSWT_CFPKeyType* const aKey,
                    const ETHSWT_CFPActionType* const aAction,
                    uint32_t* const aRow,
                    uint32_t* const aSlice)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (NULL != aKey) &&
        (NULL != aAction) && (NULL != aRow) && (NULL != aSlice)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.keyCfg    = aKey;
        cfpIO.actionCfg = aAction;
        cfpIO.row       = aRow;
        cfpIO.slice     = aSlice;
        swtIO.retVal    = BCM_ERR_UNKNOWN;
        swtIO.swtHwID   = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_ADDRULE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWDSGN_ETHSWT_CFP_ADD_RULE, ret,
                         (uint32_t) aKey, (uint32_t) aAction,
                         (NULL != aRow) ? (uint32_t) *aRow: 0xFFFFFFFFUL,
                         (NULL != aSlice) ? (uint32_t) *aSlice : 0xFFFFFFFFUL);
    }
    return ret;
}

/**
    @brief CFP remove rule

    @trace #BRCM_SWARCH_ETHSWT_CFP_REMOVE_RULE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if aID is valid and aRow is within limits
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPRemoveRule(ETHSWT_HwIDType aID,
                       uint32_t aRow)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aRow < ETHSWT_CFPHandle.numAllowedRules)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.row     = &aRow;
        swtIO.retVal  = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_REMOVERULE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_REMOVE_RULE_PROC, ret,
                         __LINE__, aRow, 0UL, 0uL);
    }
    return ret;
}

/**
    @brief CFP Update rule

    @trace #BRCM_SWARCH_ETHSWT_CFP_UPDATE_RULE_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if aID is valid and aRow is within limits and aAction is non-NULL
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPUpdateRule(ETHSWT_HwIDType aID,
                       uint32_t aRow,
                       const ETHSWT_CFPActionType* const aAction)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aRow < ETHSWT_CFPHandle.numAllowedRules) &&
        (NULL != aAction)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.row       = &aRow;
        cfpIO.actionCfg = aAction;
        swtIO.retVal    = BCM_ERR_UNKNOWN;
        swtIO.swtHwID   = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_UPDATERULE, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_UPDATE_RULE_PROC, ret,
                         __LINE__, aRow, (uint32_t) aAction, 0uL);
    }
    return ret;
}

/**
    @brief CFP Get stats

    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_STATS_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @code{.unparsed}
    if aID is valid and aRow is within limits and aStats is non-NULL
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPGetStats(ETHSWT_HwIDType aID,
                     uint32_t aRow,
                     ETHSWT_CFPStatsType *const aStats)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aRow < ETHSWT_CFPHandle.numAllowedRules) && (NULL != aStats)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.row        = &aRow;
        cfpIO.cfpStats   = aStats;
        swtIO.retVal     = BCM_ERR_UNKNOWN;
        swtIO.swtHwID    = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_GETSTATS, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_GET_STATS_PROC, ret,
                         aRow, (uint32_t) aStats, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Get row configuration

    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_ROW_CONFIG_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @code{.unparsed}
    if aID is valid and aRow is within limits and aConfig is non-NULL
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPGetRowConfig(ETHSWT_HwIDType aID,
                         uint32_t aRow,
                         ETHSWT_CFPRuleType *const aConfig)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aRow < ETHSWT_CFPHandle.numAllowedRules) && (NULL != aConfig)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.row        = &aRow;
        cfpIO.ruleCfg    = aConfig;
        swtIO.retVal     = BCM_ERR_UNKNOWN;
        swtIO.swtHwID    = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_GETROWCONFIG, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if ((ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND)) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_GET_ROW_CONFIG_PROC, ret,
                         aRow, (uint32_t) aConfig, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Get snapshot

    @trace #BRCM_SWARCH_ETHSWT_CFP_GET_SNAPSHOT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY

    @code{.unparsed}
    if aID is valid and aRow is within limits and aConfig is non-NULL
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPGetSnapshot(ETHSWT_HwIDType aID,
                        ETHSWT_CFPSnapshotType *const aSnapshot)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (NULL != aSnapshot)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.snapShot   = aSnapshot;
        swtIO.retVal     = BCM_ERR_UNKNOWN;
        swtIO.swtHwID    = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_GETSNAPSHOT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if ((ret != BCM_ERR_OK) && (ret != BCM_ERR_NOT_FOUND))  {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_GET_SNAPSHOT_PROC, ret,
                         (uint32_t) aSnapshot, 0UL, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Enable port

    @trace #BRCM_SWARCH_ETHSWT_CFP_ENABLE_PORT_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if aID is valid and aPortNum is valid
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPEnablePort(ETHSWT_HwIDType aID,
                       uint32_t aPortNum)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aPortNum < ETHSWT_PORT_ID_MAX)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.portHwID  = aPortNum;
        swtIO.retVal    = BCM_ERR_UNKNOWN;
        swtIO.swtHwID   = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_ENABLEPORT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_ENABLE_PORT_PROC, ret,
                         aPortNum, 0UL, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Disable port

    @trace #BRCM_SWARCH_ETHSWT_CFP_DISABLE_PORT_PROC
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION

    @code{.unparsed}
    if aID is valid and aPortNum is valid
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPDisablePort(ETHSWT_HwIDType aID,
                       uint32_t aPortNum)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if ((aID < SWITCH_MAX_HW_ID) && (aPortNum < ETHSWT_PORT_ID_MAX)) {
        swtIO.cfpIO = &cfpIO;
        cfpIO.portHwID  = aPortNum;
        swtIO.retVal    = BCM_ERR_UNKNOWN;
        swtIO.swtHwID   = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_DISABLEPORT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_DISABLE_PORT_PROC, ret,
                         aPortNum, 0UL, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief Set table size for CFP

    @trace #BRCM_SWARCH_ETHSWT_CFP_DRVSETTBLSIZE_PROC
    @trace #BRCM_SWARCH_ETHSWT_CFPTBLSIZE_TYPE
    @trace #BRCM_SWREQ_ETHSWT_DYNAMIC_CONFIGURATION
*/
int32_t ETHSWT_CFPDrvSetTblSize(ETHSWT_HwIDType aID,
                                ETHSWT_CFPTblSizeType aTblSize)
{
    int32_t ret;

    if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
        ret = BCM_ERR_INVAL_STATE;
    } else if (aID >= SWITCH_MAX_HW_ID) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHSWT_CFPTBLSIZE_RESTRICTED == aTblSize) {
#if (ETHSWT_CFPTBLSIZE_RESTRICTED < ETHSWT_CFP_MAX_RULES)
            uint32_t i;
            for (i = ETHSWT_CFPTBLSIZE_RESTRICTED;
                i < ETHSWT_CFP_MAX_RULES;
                i++) {
                ret = ETHSWT_CFPDrvCheckIfRuleExists(i);
                if (ret == BCM_ERR_OK) {
                    break;
                }
            }
            if (i == ETHSWT_CFP_MAX_RULES) {
                ETHSWT_CFPHandle.numAllowedRules = ETHSWT_CFPTBLSIZE_RESTRICTED;
                ret = BCM_ERR_OK;
            } else {
                ret = BCM_ERR_NOMEM;
            }
#else
            ret = BCM_ERR_NOMEM;
#endif
#if (ETHSWT_CFPTBLSIZE_RESTRICTED != ETHSWT_CFPTBLSIZE_MAX)
        } else if (ETHSWT_CFPTBLSIZE_MAX == aTblSize) {
            ETHSWT_CFPHandle.numAllowedRules = ETHSWT_CFPTBLSIZE_MAX;
            ret = BCM_ERR_OK;
#endif
        } else {
            ret = BCM_ERR_INVAL_PARAMS;
        }
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_DRVSETTBLSIZE_PROC, ret,
                         __LINE__, (uint32_t)aTblSize, aID, 0UL);
    }
    return ret;
}

/**
    @brief CFP DeInitialization

    @trace #BRCM_SWARCH_ETHSWT_CFP_DEINIT_PROC
    @trace #BRCM_SWREQ_ETHSWT_INITIALISATION

    @code{.unparsed}
    if aID is valid
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPDeInit(ETHSWT_HwIDType aID)
{
    ETHSWT_IOType swtIO;
    ETHSWT_CFPIOType cfpIO;
    int32_t  ret = BCM_ERR_INVAL_PARAMS;

    if (aID < SWITCH_MAX_HW_ID) {
        swtIO.cfpIO = &cfpIO;
        swtIO.retVal  = BCM_ERR_UNKNOWN;
        swtIO.swtHwID = aID;
        ret = ETHSWT_SysCmdReq(ETHSWT_IO_CMD_CFP_DEINIT, &swtIO);
    } else {
        ret = BCM_ERR_INVAL_PARAMS;
    }

    if (ret != BCM_ERR_OK) {
        ETHSWT_CFPDrvReportError((BCM_CFP_ID & BCM_LOGMASK_USER), aID,
                         BRCM_SWARCH_ETHSWT_CFP_DEINIT_PROC, ret,
                         __LINE__, 0UL, 0UL, 0UL);
    }
    return ret;
}

/**
    @brief CFP Command handler

    @trace #BRCM_SWARCH_ETHSWT_CFP_CMDHANDLER_PROC
    @trace #BRCM_SWREQ_ETHSWT_KERNEL_HANDLER

    @code{.unparsed}
    if aID is valid
        Invoke SVC
    @endcode
*/
int32_t ETHSWT_CFPCmdHandler(ETHSWT_HwIDType aSwtHwID,
                                ETHSWT_IOCmdType aCmd,
                                ETHSWT_CFPIOType *const aIO)
{
    int32_t ret = BCM_ERR_UNKNOWN;
    if (NULL != aIO) {
        switch (aCmd) {
            case ETHSWT_IO_CMD_CFP_INIT:
                ret = ETHSWT_CFPDrvInit(aSwtHwID, aIO->cfpCfg);
                break;
            case ETHSWT_IO_CMD_CFP_ADDRULE:
                ret = ETHSWT_CFPDrvAddRule(aSwtHwID, aIO->keyCfg, aIO->actionCfg, aIO->row, aIO->slice);
                break;
            case ETHSWT_IO_CMD_CFP_REMOVERULE:
                ret = ETHSWT_CFPDrvRemoveRule(aSwtHwID, *aIO->row);
                break;
            case ETHSWT_IO_CMD_CFP_UPDATERULE:
                ret = ETHSWT_CFPDrvUpdateRule(aSwtHwID, *aIO->row, aIO->actionCfg);
                break;
            case ETHSWT_IO_CMD_CFP_GETSTATS:
                ret = ETHSWT_CFPDrvGetStats(aSwtHwID, *aIO->row, aIO->cfpStats);
                break;
            case ETHSWT_IO_CMD_CFP_GETSNAPSHOT:
                ret = ETHSWT_CFPDrvGetSnapshot(aSwtHwID, aIO->snapShot);
                break;
            case ETHSWT_IO_CMD_CFP_GETROWCONFIG:
                if (ETHSWT_CFP_STATE_INITIALIZED != ETHSWT_CFPHandle.state) {
                    ret = BCM_ERR_INVAL_STATE;
                } else {
                    ret = ETHSWT_CFPDrvCheckIfRuleExists(*aIO->row);
                    if (BCM_ERR_OK == ret) {
                        ret = ETHSWT_CFPDrvGetKey(aSwtHwID, *aIO->row,
                                                  &aIO->ruleCfg->key,
                                                  &aIO->ruleCfg->rowAndSlice,
                                                  &ETHSWT_CFPRegs->a1_udf_0_a_0);
                        if (BCM_ERR_OK == ret) {
                            ret = ETHSWT_CFPDrvGetAction(aSwtHwID, *aIO->row,
                                                         &aIO->ruleCfg->action);
                        }
                    }
                }
                break;
            case ETHSWT_IO_CMD_CFP_ENABLEPORT:
                ret = ETHSWT_CFPDrvEnablePort(aSwtHwID, aIO->portHwID);
                break;
            case ETHSWT_IO_CMD_CFP_DISABLEPORT:
                ret = ETHSWT_CFPDrvDisablePort(aSwtHwID, aIO->portHwID);
                break;
            case ETHSWT_IO_CMD_CFP_DEINIT:
                ret = ETHSWT_CFPDrvDeInit(aSwtHwID);
                break;
            default:
                ret = BCM_ERR_NOSUPPORT;
                break;
        }
    }
    return ret;
}
/** @} */
