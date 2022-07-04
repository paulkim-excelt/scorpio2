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
    @defgroup grp_ethsrv_swt_cfp_host_impl CFP Host Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_cfp_host_impl
    @{

    @file ethswtm_cfp_host.c

    @brief Ethernet CFP host helpers Design

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <ethernet_swt_cfp.h>

/**
    @name Ethernet switch CFP Helper Design ID's
    @{
    @brief Ethernet switch CFP Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_CFP_CMD_INT_PARSE_STATUS_GLOBAL        (0xBF01U)    /**< @brief #ETHSWT_CFP_CMD_INT_PARSE_STATUS        */
#define BRCM_SWDSGN_ETHSWT_CFP_HELPER_CTX_GLOBAL                  (0xBF02U)    /**< @brief #ETHSWT_CFPHelperCtx                    */
#define BRCM_SWDSGN_ETHSWT_CFPHELP_GLOBAL                         (0xBF03U)    /**< @brief #ETHSWT_CFPHelpCmds                     */
#define BRCM_SWDSGN_ETHSWT_CFP_CONVERTTONATIVE_PROC               (0xBF04U)    /**< @brief #ETHSWT_CFPConvertToNative              */
#define BRCM_SWDSGN_ETHSWT_CFP_FORMATTOL3_PROC                    (0xBF05U)    /**< @brief #ETHSWT_CFPFormatToL3                   */
#define BRCM_SWDSGN_ETHSWT_CFP_FORMATL3TOSTR_PROC                 (0xBF06U)    /**< @brief #ETHSWT_CFPFormatL3ToStr                */
#define BRCM_SWDSGN_ETHSWT_CFP_BASEIDTOSTR_PROC                   (0xBF07U)    /**< @brief #ETHSWT_CFPBaseIdToStr                  */
#define BRCM_SWDSGN_ETHSWT_CFP_PRINTTAG_PROC                      (0xBF08U)    /**< @brief #ETHSWT_CFPPrintTag                     */
#define BRCM_SWDSGN_ETHSWT_CFP_SHOWRULE_PROC                      (0xBF09U)    /**< @brief #ETHSWT_CFPShowRule                     */
#define BRCM_SWDSGN_ETHSWT_CFP_SHOWPRINT_PROC                     (0xBF0AU)    /**< @brief #ETHSWT_CFPShowPrint                    */
#define BRCM_SWDSGN_ETHSWT_CFP_ADDRULEPREPCTXINT_PROC             (0xBF0BU)    /**< @brief #ETHSWT_CFPAddRulePrepCtxInt            */
#define BRCM_SWDSGN_ETHSWT_CFP_ADDRULEHDLR_PROC                   (0xBF0CU)    /**< @brief #ETHSWT_CFPAddRuleHdlr                  */
#define BRCM_SWDSGN_ETHSWT_CFP_DELETERULEPREPCTXINT_PROC          (0xBF0DU)    /**< @brief #ETHSWT_CFPDeleteRulePrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_CFP_DELETERULEHDLR_PROC                (0xBF0EU)    /**< @brief #ETHSWT_CFPDeleteRuleHdlr               */
#define BRCM_SWDSGN_ETHSWT_CFP_UPDATERULEPREPCTXINT_PROC          (0xBF0FU)    /**< @brief #ETHSWT_CFPUpdateRulePrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_CFP_UPDATERULEHDLR_PROC                (0xBF10U)    /**< @brief #ETHSWT_CFPUpdateRuleHdlr               */
#define BRCM_SWDSGN_ETHSWT_CFP_SNAPSHOTPREPCTXINT_PROC            (0xBF11U)    /**< @brief #ETHSWT_CFPSnapshotPrepCtxInt           */
#define BRCM_SWDSGN_ETHSWT_CFP_GETSNAPSHOTHDLR_PROC               (0xBF12U)    /**< @brief #ETHSWT_CFPGetSnapshotHdlr              */
#define BRCM_SWDSGN_ETHSWT_CFP_GETROWCFGHDLR_PROC                 (0xBF13U)    /**< @brief #ETHSWT_CFPGetRowCfgHdlr                */
#define BRCM_SWDSGN_ETHSWT_CFP_GETSTATUSPREPCTXINT_PROC           (0xBF14U)    /**< @brief #ETHSWT_CFPGetStatusPrepCtxInt          */
#define BRCM_SWDSGN_ETHSWT_CFP_GETSTATSHDLR_PROC                  (0xBF15U)    /**< @brief #ETHSWT_CFPGetStatsHdlr                 */
#define BRCM_SWDSGN_ETHSWT_CFP_SETPORTMODECTXINT_PROC             (0xBF16U)    /**< @brief #ETHSWT_CFPSetPortModeCtxInt            */
#define BRCM_SWDSGN_ETHSWT_CFP_SETPORTMODEHDLR_PROC               (0xBF17U)    /**< @brief #ETHSWT_CFPSetPortModeHdlr              */
#define BRCM_SWDSGN_ETHSWT_CFP_HELPERPREPCTX_PROC                 (0xBF18U)    /**< @brief #ETHSWT_CFPHelperPrepCtx                */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERADDHELPERPREPCTXINT_PROC    (0xBF19U)    /**< @brief #ETHSWT_CFPPolicerAddHelperPrepCtxInt   */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERDELHELPERPREPCTXINT_PROC    (0xBF1AU)    /**< @brief #ETHSWT_CFPPolicerDelHelperPrepCtxInt   */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERBLOCKHELPERPREPCTXINT_PROC  (0xBF1BU)    /**< @brief #ETHSWT_CFPPolicerBlockHelperPrepCtxInt */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERRESHELPERPREPCTXINT_PROC    (0xBF1CU)    /**< @brief #ETHSWT_CFPPolicerResHelperPrepCtxInt   */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERSHOWPREPCTXINT_PROC         (0xBF1DU)    /**< @brief #ETHSWT_CFPPolicerShowPrepCtxInt        */
#define BRCM_SWDSGN_ETHSWT_CFP_POLICERFINDPREPCTXINT_PROC         (0xBF1EU)    /**< @brief #ETHSWT_CFPPolicerFindPrepCtxInt        */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMPOLICER_ADD_HDLR_PROC          (0xBF1FU)    /**< @brief #ETHSWT_CFPStrmPolicerAddHdlr           */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMPOLICER_DEL_HDLR_PROC          (0xBF20U)    /**< @brief #ETHSWT_CFPStrmPolicerDelHdlr           */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMBLOCK_HDLR_PROC                (0xBF21U)    /**< @brief #ETHSWT_CFPStrmBlockHdlr                */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMRESUME_HDLR_PROC               (0xBF22U)    /**< @brief #ETHSWT_CFPStrmResumeHdlr               */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMPOLICER_SNAPSHOT_HDLR_PROC     (0xBF23U)    /**< @brief #ETHSWT_CFPStrmPolicerSnapshotHdlr      */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMPOLICER_GETSTATUS_HDLR_PROC    (0xBF24U)    /**< @brief #ETHSWT_CFPStrmPolicerGetStatusHdlr     */
#define BRCM_SWDSGN_ETHSWT_CFP_STRMPOLICER_FINDIDX_HDLR_PROC      (0xBF25U)    /**< @brief #ETHSWT_CFPStrmPolicerFindIdxHdlr       */
#define BRCM_SWDSGN_ETHSWT_CFP_HELPERPROCESS_PROC                 (0xBF26U)    /**< @brief #ETHSWT_CFPHelperProcess                */
#define BRCM_SWDSGN_ETHSWT_CFP_PRINT_GLOBAL                       (0xBF27U)    /**< @brief #ETHSWT_CFPPrintHelper                  */
#define BRCM_SWDSGN_ETHSWT_CFP_HELPER_GLOBAL                      (0xBF28U)    /**< @brief #ETHSWT_CFPHelper                       */
#define BRCM_SWDSGN_ETHSWT_CFPHELPERCTX_TYPE                      (0xBF29U)    /**< @brief #ETHSWT_CFPHelperCtxType */
/** @} */

/**
    @brief CFP Integer parse status

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
#define ETHSWT_CFP_CMD_INT_PARSE_STATUS(status)  if(status != BCM_ERR_OK) {  \
    goto done;                                                         \
}

/**
    @brief CFP Helper Module Context Type

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_CFPHelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context     */
    ETHSWT_CFPHostContextType ctx;    /**< @brief CFP Host context */
    uint32_t idx;                               /**< @brief Index to use
                                                       between stages for Add Rule         */
    uint32_t fileSz;                            /**< @brief Total File Size  of CFp Config */
    uint8_t buff[ETHSWT_CFP_MAX_FILESIZE];    /**< @brief Buffer to store
                                                   the file data  for Add and Update Rule  */
    ETHSWT_CFPEntrySnapshotType  cfpRuleSnapBuff[ETHSWT_CFP_MAX_RULES]; /**< @brief cfp snapshot Entry Rules data context  */
} ETHSWT_CFPHelperCtxType;

/**
    @brief CFP Helper Module Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_CFPHelperCtxType ETHSWT_CFPHelperCtx;

/**
    @brief CFP Supported commands

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_CFPHelpCmds[] =
"add <row> <slice> <filename>\n"
"delete <row>\n"
"update <row> <filename>\n"
"stats <row>\n"
"show\n"
"show <row>\n"
"port <num> enable\n"
"port <num> disable\n"
"policer add <mac address> <vlan> <rate> <burst> <src_mask> <threshold> <interval> <report> <block>\n"
"policer del <stream index>\n"
"policer block <stream index>\n"
"policer resume <stream index>\n"
"policer show [stream index]\n"
"policer find <mac address> <vlan> <src_mask>\n"
;

/**
    @brief CFP Supported commands

    aRule->rowAndSlice is expected to be in Native endianness

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static void ETHSWT_CFPConvertToNative (ETHSWT_CFPRuleType* aRule)
{
    uint32_t i;

    aRule->rowAndSlice            = CPU_LEToNative16(aRule->rowAndSlice);
    aRule->key.flags              = CPU_LEToNative32(aRule->key.flags);
    aRule->key.flagsMask          = CPU_LEToNative32(aRule->key.flagsMask);
    aRule->key.ingressPortBitmap  = CPU_LEToNative16(aRule->key.ingressPortBitmap);
    aRule->key.cTagFlags          = CPU_LEToNative32(aRule->key.cTagFlags);
    aRule->key.cTagMask           = CPU_LEToNative16(aRule->key.cTagMask);
    aRule->key.sTagFlags          = CPU_LEToNative32(aRule->key.sTagFlags);
    aRule->key.sTagMask           = CPU_LEToNative16(aRule->key.sTagMask);
    for (i = 0UL; i < aRule->key.numEnabledUDFs; ++i) {
        aRule->key.udfList[i].value  = CPU_LEToNative16(aRule->key.udfList[i].value);
        aRule->key.udfList[i].mask  = CPU_LEToNative16(aRule->key.udfList[i].mask);
    }

    aRule->action.dstMapIBFlags      = CPU_LEToNative32(aRule->action.dstMapIBFlags);
    aRule->action.dstMapOBFlags      = CPU_LEToNative32(aRule->action.dstMapOBFlags);
    aRule->action.meter.cirTkBkt     = CPU_LEToNative32(aRule->action.meter.cirTkBkt);
    aRule->action.meter.cirRefCnt    = CPU_LEToNative32(aRule->action.meter.cirRefCnt);
    aRule->action.meter.cirBktSize   = CPU_LEToNative32(aRule->action.meter.cirBktSize);
    aRule->action.meter.eirTkBkt     = CPU_LEToNative32(aRule->action.meter.eirTkBkt);
    aRule->action.meter.eirRefCnt    = CPU_LEToNative32(aRule->action.meter.eirRefCnt);
    aRule->action.meter.eirBktSize   = CPU_LEToNative32(aRule->action.meter.eirBktSize);
}

/**
    @brief Format To L3 Frame

    This API Format the string to L3 frame

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      format        Frame Number

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static ETHSWT_CFPL3FramingType ETHSWT_CFPFormatToL3(uint32_t aFormat)
{
    switch(aFormat) {
        case 0UL:
            return ETHSWT_CFP_L3FRAMING_IPV4;
        case 1UL:
            return ETHSWT_CFP_L3FRAMING_IPV6;
        case 2UL:
            return ETHSWT_CFP_L3FRAMING_NONIP;
        default:
            return ETHSWT_CFP_L3FRAMING_NONIP+1U;
    }
}

/**
    @brief Format L3 Frame to string

    This API Format L3 frame to string

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      l3Framing        Frame Number

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static char* ETHSWT_CFPFormatL3ToStr(ETHSWT_CFPL3FramingType aL3Frame)
{

    switch (aL3Frame) {
        case ETHSWT_CFP_L3FRAMING_NONIP:
            return "Non-IP\0";
        case ETHSWT_CFP_L3FRAMING_IPV4:
            return "IPv4\0";
        case ETHSWT_CFP_L3FRAMING_IPV6:
            return "IPv6\0";
        default:
            return "Invalid L3Framing\0";
    }
}

/**
    @brief Format Base ID to String

    This API Format the base ID to string

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      format        Frame Number

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static char* ETHSWT_CFPBaseIdToStr(uint32_t aBaseID)
{
    switch (aBaseID) {
        case ETHSWT_CFP_UDFBASE_SOP:
            return "SOP";
        case ETHSWT_CFP_UDFBASE_ENDL2HDR:
            return "End-L2-Header";
        case ETHSWT_CFP_UDFBASE_ENDL3HDR:
            return "End-L3-Header";
        default:
            return "Invalid BaseId";
    }
}

/**
    @brief Print CFP Tag and Mask

    This API Prints the CFP Tag and Mask

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aTag            CFP Tag
    @param[in]      aTagMask        CFP Tag Mask

    Return values are documented in reverse-chronological order
    @retval         void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_CFPPrintTag(uint32_t aTag, uint32_t aTagMask)
{
    char *unTagged   = "Un-Tagged";
    char *prioTagged = "Priority-Tagged";
    char *vlanTagged = "VLAN-Tagged";
    uint8_t flag     = FALSE;

    /* check for invalid case
       1. Un-tagged or VLAN-Tagged is not a supported combination
       2. Tag-status bit-map should not be zero */
    if(((aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) && (aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK)
       && (!(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK))) ||
        ((!(aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) && (!(aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK)))
       && (!(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK)))) {
        (void)MODULE_HostHelperLog("%s","Invalid Acceptable Frame Type");
    } else {
        if(aTag & ETHSWT_CFP_KEY_TAG_UN_TAGGED_MASK) {
            (void)MODULE_HostHelperLog("%s", unTagged);
            flag = TRUE;
        }
        if(aTag & ETHSWT_CFP_KEY_TAG_PRIO_TAGGED_MASK) {
            if(FALSE == flag) {
                (void)MODULE_HostHelperLog("%s", prioTagged);
            } else {
                (void)MODULE_HostHelperLog(", %s", prioTagged);
            }
            flag = TRUE;
        }
        if(aTag & ETHSWT_CFP_KEY_TAG_VLAN_TAGGED_MASK) {
            if(FALSE == flag) {
                (void)MODULE_HostHelperLog("%s", vlanTagged);
            } else {
                (void)MODULE_HostHelperLog(", %s", vlanTagged);
            }
        }
    }

    if ((aTag & ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) == ETHSWT_CFP_KEY_TAG_ID_VALID_MASK) {
        (void)MODULE_HostHelperLog(" VID %lu", (aTag & ETHSWT_CFP_KEY_TAG_ID_MASK) >> ETHSWT_CFP_KEY_TAG_ID_SHIFT);
        if(0xFFFUL != (aTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT) {
            (void)MODULE_HostHelperLog(" VID Mask 0x%lx", (aTagMask & ETHSWT_CFP_KEY_TAG_IDMASK_MASK) >> ETHSWT_CFP_KEY_TAG_IDMASK_SHIFT);
        }
    }
    if ((aTag & ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) == ETHSWT_CFP_KEY_TAG_DEI_VALID_MASK) {
        (void)MODULE_HostHelperLog(" DEI %lu", (aTag & ETHSWT_CFP_KEY_TAG_DEI_MASK) >> ETHSWT_CFP_KEY_TAG_DEI_SHIFT);
    }
    if ((aTag & ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) == ETHSWT_CFP_KEY_TAG_PCP_VALID_MASK) {
        (void)MODULE_HostHelperLog(" PCP %lu", (aTag & ETHSWT_CFP_KEY_TAG_PCP_MASK) >> ETHSWT_CFP_KEY_TAG_PCP_SHIFT);
        if(ETHSWT_CFP_KEY_TAG_PCPMASK_MASK != (aTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK)) {
            (void)MODULE_HostHelperLog(" PCP Mask 0x%lx", (aTagMask & ETHSWT_CFP_KEY_TAG_PCPMASK_MASK) >> ETHSWT_CFP_KEY_TAG_PCPMASK_SHIFT);
        }
    }
}

/**
    @brief Print CFP Show Rule

    This API Prints the CFP Rule

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aRule            CFP Rule to print

    Return values are documented in reverse-chronological order
    @retval         void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPShowRule(ETHSWT_CFPRuleType* aRule)
{
    uint32_t i;
    int32_t  retVal = -1;
    uint16_t slice = (aRule->rowAndSlice & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK) >> ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT;

    if (ETHSWT_CFP_MAX_SLICES > slice) {
        (void)MODULE_HostHelperLog("\nSlice                    : %u\n", slice);
        (void)MODULE_HostHelperLog("================== Key ==================\n");
        (void)MODULE_HostHelperLog("L3 Framing               : %s\n", ETHSWT_CFPFormatL3ToStr(aRule->key.l3Framing));
        (void)MODULE_HostHelperLog("L2 Framing               : ");
        switch (aRule->key.l2Framing) {
            case ETHSWT_CFP_L2FRAMING_DIXV2:
                (void)MODULE_HostHelperLog("DIXv2\n");
                break;
            case ETHSWT_CFP_L2FRAMING_SNAP_PUB:
                (void)MODULE_HostHelperLog("SNAP Public\n");
                break;
            case ETHSWT_CFP_L2FRAMING_SNAP_PVT:
                (void)MODULE_HostHelperLog("SNAP Private\n");
                break;
            case ETHSWT_CFP_L2FRAMING_LLC:
                (void)MODULE_HostHelperLog("LLC\n");
                break;
            default:
                break;
        }
        (void)MODULE_HostHelperLog("Ingress Port Bitmap      : 0x%.4x\n", aRule->key.ingressPortBitmap);
        (void)MODULE_HostHelperLog("C-Tag                    : ");
        ETHSWT_CFPPrintTag(aRule->key.cTagFlags, aRule->key.cTagMask);
        (void)MODULE_HostHelperLog("\nS-Tag                    : ");
        ETHSWT_CFPPrintTag(aRule->key.sTagFlags, aRule->key.sTagMask);

        (void)MODULE_HostHelperLog("\n");
        if (aRule->key.l3Framing == ETHSWT_CFP_L3FRAMING_NONIP) {
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK) != 0UL) {
                (void)MODULE_HostHelperLog("Ethertype                : 0x%lx\n", aRule->key.flags & ETHSWT_CFP_KEY_ETHTYPE_MASK);
                if(0xFFFF != (aRule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK)) {
                    (void)MODULE_HostHelperLog("Ethertype Mask           : 0x%lx\n", aRule->key.flagsMask & ETHSWT_CFP_KEY_ETHTYPE_MASK);
                }
            }
        } else {
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_TTL_MASK) == ETHSWT_CFP_KEY_TTL_MASK) {
                (void)MODULE_HostHelperLog("TTL                      : ");
                switch(aRule->key.flags & ETHSWT_CFP_KEY_TTL_MASK) {
                    case 0U ... 1U:
                      (void)MODULE_HostHelperLog("%lu\n", aRule->key.flags & ETHSWT_CFP_KEY_TTL_MASK);
                      break;
                    case 2U:
                      (void)MODULE_HostHelperLog("Others\n");
                      break;
                    case 3U:
                      (void)MODULE_HostHelperLog("255\n");
                      break;
                    default:
                      (void)MODULE_HostHelperLog("Error\n");
                      break;
                }
            }
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_AUTH_MASK) == ETHSWT_CFP_KEY_AUTH_MASK) {
                (void)MODULE_HostHelperLog("Auth                     : %lu\n", (aRule->key.flags & ETHSWT_CFP_KEY_AUTH_MASK) >> ETHSWT_CFP_KEY_AUTH_SHIFT);
            }
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_FRAG_MASK) == ETHSWT_CFP_KEY_FRAG_MASK) {
                (void)MODULE_HostHelperLog("Fragmentation            : %lu\n", (aRule->key.flags & ETHSWT_CFP_KEY_FRAG_MASK) >> ETHSWT_CFP_KEY_FRAG_SHIFT);
            }
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) == ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) {
                (void)MODULE_HostHelperLog("Non-First Fragment       : %lu\n", (aRule->key.flags & ETHSWT_CFP_KEY_NONFIRSTFRAG_MASK) >> ETHSWT_CFP_KEY_NONFIRSTFRAG_SHIFT);
            }
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_PROTO_MASK) != 0UL) {
                (void)MODULE_HostHelperLog("Protocol                 : %lu\n", (aRule->key.flags & ETHSWT_CFP_KEY_PROTO_MASK) >> ETHSWT_CFP_KEY_PROTO_SHIFT);
                (void)MODULE_HostHelperLog("Protocol Mask            : %#x\n", (aRule->key.flagsMask & ETHSWT_CFP_KEY_PROTO_MASK) >> ETHSWT_CFP_KEY_PROTO_SHIFT);
            }
            if ((aRule->key.flagsMask & ETHSWT_CFP_KEY_TOS_MASK) != 0UL) {
                (void)MODULE_HostHelperLog("Type Of Service          : %lu\n", (aRule->key.flags & ETHSWT_CFP_KEY_TOS_MASK) >> ETHSWT_CFP_KEY_TOS_SHIFT);
                (void)MODULE_HostHelperLog("Type Of Service Mask     : %#x\n", (aRule->key.flagsMask & ETHSWT_CFP_KEY_TOS_MASK) >> ETHSWT_CFP_KEY_TOS_SHIFT);
            }
        }

        for (i = 0UL; i < aRule->key.numEnabledUDFs; i++) {
            (void)MODULE_HostHelperLog("UDF[%u] Base: ", i);
            switch ((aRule->key.udfList[i].baseAndOffset & ETHSWT_CFP_UDF_DEFS_BASE_MASK) >> ETHSWT_CFP_UDF_DEFS_BASE_SHIFT) {
                case ETHSWT_CFP_UDFBASE_SOP:
                    (void)MODULE_HostHelperLog("Start of Packet ");
                    break;
                case ETHSWT_CFP_UDFBASE_ENDL2HDR:
                    (void)MODULE_HostHelperLog("End of L2 Header");
                    break;
                case ETHSWT_CFP_UDFBASE_ENDL3HDR:
                    (void)MODULE_HostHelperLog("End of L2 Header");
                    break;
                default:
                    break;
            }
            (void)MODULE_HostHelperLog(" Offset: %u Value: 0x%.4x Mask: 0x%.4x\n", (aRule->key.udfList[i].baseAndOffset & ETHSWT_CFP_UDF_DEFS_OFFSET_MASK) >> ETHSWT_CFP_UDF_DEFS_OFFSET_SHIFT,
                    aRule->key.udfList[i].value, aRule->key.udfList[i].mask);
        }

        (void)MODULE_HostHelperLog("\n================ Action =================\n");
        switch ((aRule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >> ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) {
            case ETHSWT_CFP_CHANGEFWDMAP_REM:
                (void)MODULE_HostHelperLog("Destination InBand Map : Remove 0x%x\n", (aRule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_REP:
                (void)MODULE_HostHelperLog("Destination InBand Map : Replace 0x%x\n", (aRule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_ADD:
                (void)MODULE_HostHelperLog("Destination InBand Map : Add 0x%x\n", (aRule->action.dstMapIBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            default:
                break;
        }
        switch ((aRule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_CHANGE_FWDMAP_MASK) >> ETHSWT_CFP_ACTION_CHANGE_FWDMAP_SHIFT) {
            case ETHSWT_CFP_CHANGEFWDMAP_REM:
                (void)MODULE_HostHelperLog("Destination OutOfBand Map: Remove 0x%x\n", (aRule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_REP:
                (void)MODULE_HostHelperLog("Destination OutOfBand Map: Replace 0x%x\n", (aRule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            case ETHSWT_CFP_CHANGEFWDMAP_ADD:
                (void)MODULE_HostHelperLog("Destination OutOfBand Map: Add 0x%x\n", (aRule->action.dstMapOBFlags & ETHSWT_CFP_ACTION_DSTMAP_MASK) >> ETHSWT_CFP_ACTION_DSTMAP_SHIFT);
                break;
            default:
                break;
        }
        if ((aRule->action.tosIBFlags & ETHSWT_CFP_ACTION_CHANGE_TOS_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) {
            (void)MODULE_HostHelperLog("InBand Type Of Service : %u\n", (aRule->action.tosIBFlags & ETHSWT_CFP_ACTION_TOS_MASK) >> ETHSWT_CFP_ACTION_TOS_SHIFT);
        }
        if ((aRule->action.tosOBFlags & ETHSWT_CFP_ACTION_CHANGE_TOS_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TOS_SHIFT) {
            (void)MODULE_HostHelperLog("OutOfBand Type Of Service: %u\n", (aRule->action.tosOBFlags & ETHSWT_CFP_ACTION_TOS_MASK) >> ETHSWT_CFP_ACTION_TOS_SHIFT);
        }
        if ((aRule->action.tcFlags & ETHSWT_CFP_ACTION_CHANGE_TC_MASK) >> ETHSWT_CFP_ACTION_CHANGE_TC_SHIFT) {
            (void)MODULE_HostHelperLog("Trafic Class             : %u\n", (aRule->action.tcFlags & ETHSWT_CFP_ACTION_TC_MASK) >> ETHSWT_CFP_ACTION_TC_SHIFT);
        }
        if ((aRule->action.colorFlags & ETHSWT_CFP_ACTION_CHANGE_COLOR_MASK) >> ETHSWT_CFP_ACTION_CHANGE_COLOR_SHIFT) {
            (void)MODULE_HostHelperLog("Color                    : ");
            switch((aRule->action.colorFlags & ETHSWT_CFP_ACTION_COLOR_MASK) >> ETHSWT_CFP_ACTION_COLOR_SHIFT) {
                case ETHSWT_CFP_COLOR_GREEN:
                    (void)MODULE_HostHelperLog("Green\n");
                    break;
                case ETHSWT_CFP_COLOR_YELLOW:
                    (void)MODULE_HostHelperLog("Yellow\n");
                    break;
                case ETHSWT_CFP_COLOR_RED:
                    (void)MODULE_HostHelperLog("Red\n");
                    break;
                default:
                    break;
            }
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_VLAN_MASK) >> ETHSWT_CFP_ACTION_BYPASS_VLAN_SHIFT) {
            (void)MODULE_HostHelperLog("Bypass VLAN              : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_EAP_MASK) >> ETHSWT_CFP_ACTION_BYPASS_EAP_SHIFT) {
            (void)MODULE_HostHelperLog("Bypass EAP               : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_BYPASS_STP_MASK) >> ETHSWT_CFP_ACTION_BYPASS_STP_SHIFT) {
            (void)MODULE_HostHelperLog("Bypass STP               : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_LPBK_EN_MASK) >> ETHSWT_CFP_ACTION_LPBK_EN_SHIFT) {
            (void)MODULE_HostHelperLog("Loopback                 : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_USE_DFLT_RED_MASK) >> ETHSWT_CFP_ACTION_USE_DFLT_RED_SHIFT) {
            (void)MODULE_HostHelperLog("Use default RED profile  : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_MIRROR_OB_MASK) >> ETHSWT_CFP_ACTION_MIRROR_OB_SHIFT) {
            (void)MODULE_HostHelperLog("Mirror OutOfBand data : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_MIRROR_IB_MASK) >> ETHSWT_CFP_ACTION_MIRROR_IB_SHIFT) {
            (void)MODULE_HostHelperLog("Mirror InBand data     : Yes\n");
        }
        if ((aRule->action.otherFlags & ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_MASK) >> ETHSWT_CFP_ACTION_MAC_LIMIT_BYPASS_SHIFT) {
            (void)MODULE_HostHelperLog("Bypass MAC limit         : Yes\n");
        }
        if (aRule->action.reasonCode != 0U) {
            (void)MODULE_HostHelperLog("Reason code              : %u\n", aRule->action.reasonCode);
        }
        if (aRule->action.chainID != 0U) {
            (void)MODULE_HostHelperLog("Chain ID                 : %u\n", aRule->action.chainID);
        }

        if (((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) != ETHSWT_CFP_POLICERMODE_DISABLED) {
            (void)MODULE_HostHelperLog("Meter mode               : ");
            switch ((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) {
                case ETHSWT_CFP_POLICERMODE_RFC2698:
                    (void)MODULE_HostHelperLog("RFC2698\n");
                    break;
                case ETHSWT_CFP_POLICERMODE_RFC4115:
                    (void)MODULE_HostHelperLog("RFC4115\n");
                    break;
                case ETHSWT_CFP_POLICERMODE_MEF:
                    (void)MODULE_HostHelperLog("MEF\n");
                    break;
                default:
                    break;
            }
            if ((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_CF_MASK) >> ETHSWT_CFP_METER_CF_SHIFT) {
                (void)MODULE_HostHelperLog("Coupling flag            : Yes\n");
            }
            if ((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_CM_MASK) >> ETHSWT_CFP_METER_CM_SHIFT) {
                (void)MODULE_HostHelperLog("Color Mode               : Blind\n");
            }
            if (((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_MODE_MASK) >> ETHSWT_CFP_METER_MODE_SHIFT) != ETHSWT_CFP_POLICERMODE_MEF) {
                if ((aRule->action.meter.policerFlags & ETHSWT_CFP_METER_ACT_MASK) >> ETHSWT_CFP_METER_ACT_SHIFT) {
                    (void)MODULE_HostHelperLog("Red packets treated as   : OutOfBands\n");
                }
            }
            (void)MODULE_HostHelperLog("CIR                      : %u Kbps\n", (aRule->action.meter.cirRefCnt * 1000)/256);
            (void)MODULE_HostHelperLog("CBS                      : %u bytes\n", aRule->action.meter.cirBktSize);
            (void)MODULE_HostHelperLog("CTB                      : %u bytes\n", aRule->action.meter.cirTkBkt/8);
            (void)MODULE_HostHelperLog("EIR                      : %u Kbps\n", (aRule->action.meter.eirRefCnt * 1000) /256);
            (void)MODULE_HostHelperLog("EBS                      : %u bytes\n", aRule->action.meter.eirBktSize);
            (void)MODULE_HostHelperLog("ETB                      : %u bytes\n", aRule->action.meter.eirTkBkt/8);
        }
    }

    return retVal;
}

/**
    @brief Print CFP Show Response

    This API Prints the CFP Show response

    @behavior Sync, Non-reentrant

    @pre None

    @param[in]      aCtx                NVM Helper Context

    Return values are documented in reverse-chronological order
    @retval     void

    @post None

    @limitations None

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static void ETHSWT_CFPShowPrint (ETHSWT_CFPHelperCtxType *aCtx)
{
    uint32_t i;
    uint32_t j;
    uint32_t k;

    (void)MODULE_HostHelperLog("Total entries: %u\n", aCtx->ctx.msg.cfpSnapshot.numValidEntries);
    (void)MODULE_HostHelperLog("Ports enabled: 0x%x\n", aCtx->ctx.msg.cfpSnapshot.portEnableMask);
    (void)MODULE_HostHelperLog("======= UDFs =========\n");
    for (k = 0UL; k < ETHSWT_CFP_NUM_FORMATS; ++k) {
        (void)MODULE_HostHelperLog("----- Format %s ------\n", ETHSWT_CFPFormatL3ToStr(ETHSWT_CFPFormatToL3(k)));
        for (i = 0UL; i < ETHSWT_CFP_MAX_SLICES; ++i) {
            (void)MODULE_HostHelperLog("Slice %u:\n", i);
            for (j = 0UL; j < ETHSWT_CFP_MAX_UDFS; ++j) {
                if (0U != aCtx->ctx.msg.cfpSnapshot.udfList[k].udfs[i][j].enable) {
                    (void)MODULE_HostHelperLog("%u) Base %s Offset %u\n", j,
                    ETHSWT_CFPBaseIdToStr((aCtx->ctx.msg.cfpSnapshot.udfList[k].udfs[i][j].address & ETHSWT_CFP_UDF_DEFS_BASE_MASK) >> ETHSWT_CFP_UDF_DEFS_BASE_SHIFT),
                    (aCtx->ctx.msg.cfpSnapshot.udfList[k].udfs[i][j].address & ETHSWT_CFP_UDF_DEFS_OFFSET_MASK) >> ETHSWT_CFP_UDF_DEFS_OFFSET_SHIFT);
                }
            }
        }
    }

    (void)MODULE_HostHelperLog("======= Rules =========\n");
    for (i = 0UL; i < ETHSWT_CFP_MAX_RULES; ++i) {
        if (0U != (aCtx->cfpRuleSnapBuff[i] & ETHSWT_CFP_ENTRYSNAPSHOT_ENABLE_MASK)) {
            (void)MODULE_HostHelperLog("%u) Slice %u Format %s Static %u\n", i,
                    (aCtx->cfpRuleSnapBuff[i] & ETHSWT_CFP_ENTRYSNAPSHOT_SLICE_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_SLICE_SHIFT,
                    ETHSWT_CFPFormatL3ToStr(ETHSWT_CFPFormatToL3(
                        (aCtx->cfpRuleSnapBuff[i] & ETHSWT_CFP_ENTRYSNAPSHOT_FORMAT_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_FORMAT_SHIFT)),
                        (aCtx->cfpRuleSnapBuff[i] & ETHSWT_CFP_ENTRYSNAPSHOT_STATIC_MASK) >> ETHSWT_CFP_ENTRYSNAPSHOT_STATIC_SHIFT);
        }
    }

}

/**
    @brief Prepare CFP Add Rule context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPAddRulePrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    char fileName[100];
    uint32_t value1;
    uint32_t value2;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPConfigType cfpConfig;

    /* parse row number */
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    value1 = MODULE_MsgParseInt(remStr, &parseStatus);
    ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

    currStr = remStr;
    currStrLen = remStrLen;
    /* parse slice number */
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    value2 = MODULE_MsgParseInt(remStr, &parseStatus);
    ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

    currStr = remStr;
    currStrLen = remStrLen;
    /* parse file name */
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    memcpy(fileName, currStr, currStrLen);
    fileName[currStrLen] = '\0';
    memset(aCtx->buff, 0U, ETHSWT_CFP_MAX_FILESIZE);
    retVal = MODULE_BufferFromFile(fileName, ETHSWT_CFP_MAX_FILESIZE, aCtx->buff, &aCtx->fileSz);
    if (BCM_ERR_OK == retVal) {
        if (aCtx->fileSz != sizeof(ETHSWT_CFPConfigType)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            memcpy(&cfpConfig, aCtx->buff, aCtx->fileSz);
            if (cfpConfig.magicId != CPU_LEToNative32(ETHSWT_CFP_CONFIG_MAGIC_ID)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            } else {
                /* Perform basic validation */
                if ((value1 >= ETHSWT_CFP_MAX_RULES) || (value2 >= ETHSWT_CFP_MAX_SLICES)) {
                    (void)MODULE_HostHelperLog("CFP Add Rule Ranges: row number: [0,%lu] slice number: [0, %lu]\n",
                                                       ETHSWT_CFP_MAX_RULES-1UL, ETHSWT_CFP_MAX_SLICES-1UL);
                    (void)MODULE_HostHelperLog("CFP Add Rule Failed\n");
                    retVal = BCM_ERR_UNKNOWN;
                    goto done;
                }
                /* Configuration mage is already in the target's endianness */
                memcpy(&aCtx->ctx.msg.cfpRule, &cfpConfig.ruleList[0], aCtx->fileSz);
                aCtx->ctx.msg.cfpRule.rowAndSlice = ((value1 <<  ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK) |
                                                  ((value2 << ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT) & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK);
                aCtx->ctx.id = ETHSWT_CFPCMDID_ADDRULE;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Add Rule Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPAddRuleHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                uint32_t       aInputLen,
                                uint32_t      *aOutLen,
                                uint32_t       aMaxLength,
                                int32_t        aResponse,
                                ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            memcpy(&cmdMsg.cfpRule, &aCtx->ctx.msg.cfpRule, sizeof(ETHSWT_CFPRuleType));
            /* This will be converted back to native before printing */
            aCtx->ctx.msg.cfpRule.rowAndSlice = CPU_NativeToLE16(aCtx->ctx.msg.cfpRule.rowAndSlice);
            cmdMsg.cfpRule.rowAndSlice = aCtx->ctx.msg.cfpRule.rowAndSlice;
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_ADDRULE);
            *aOutLen = sizeof(ETHSWT_CFPRuleType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.cfpRule, sizeof(ETHSWT_CFPRuleType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP add rule returned %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRuleType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                ETHSWT_CFPConvertToNative(&aCtx->ctx.msg.cfpRule);
                ETHSWT_CFPShowRule(&aCtx->ctx.msg.cfpRule);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Delete Rule Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPDeleteRulePrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    uint32_t value1;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    /* parse row number */
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            value1 = MODULE_MsgParseInt(currStr, &parseStatus);
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
            if (value1 >= ETHSWT_CFP_MAX_RULES) {
                (void)MODULE_HostHelperLog("CFP row number must be in the range [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
            aCtx->ctx.msg.cfpRule.rowAndSlice = ((value1 <<  ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);
            aCtx->ctx.id = ETHSWT_CFPCMDID_REMOVERULE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Delete Rule Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPDeleteRuleHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.cfpRule.rowAndSlice = CPU_NativeToLE16(aCtx->ctx.msg.cfpRule.rowAndSlice);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_REMOVERULE);
            *aOutLen = sizeof(ETHSWT_CFPRuleType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.cfpRule, sizeof(ETHSWT_CFPRuleType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP delete rule failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRuleType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Update Rule Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPUpdateRulePrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    char fileName[100];
    uint32_t value1;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    ETHSWT_CFPConfigType cfpConfig;

    /* parse row number */
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        /* parse file name */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen != 0)) {
            value1 = MODULE_MsgParseInt(currStr, &parseStatus);
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
            if (value1 >= ETHSWT_CFP_MAX_RULES) {
                (void)MODULE_HostHelperLog("CFP row number must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            /* No More Input */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                memcpy(fileName, currStr, currStrLen);
                fileName[currStrLen] = '\0';
                memset(aCtx->buff, 0U, ETHSWT_CFP_MAX_FILESIZE);
                retVal = MODULE_BufferFromFile(fileName, ETHSWT_CFP_MAX_FILESIZE, aCtx->buff, &aCtx->fileSz);
                if (BCM_ERR_OK == retVal) {
                    if (aCtx->fileSz != sizeof(ETHSWT_CFPConfigType)) {
                        retVal = BCM_ERR_INVAL_PARAMS;
                    } else {
                        memcpy(&cfpConfig, aCtx->buff, aCtx->fileSz);
                        if (cfpConfig.magicId != CPU_LEToNative32(ETHSWT_CFP_CONFIG_MAGIC_ID)) {
                            retVal = BCM_ERR_INVAL_PARAMS;
                        } else {
                            /* Configuration mage is already in the target's endianness */
                            memcpy(&aCtx->ctx.msg.cfpRule, &cfpConfig.ruleList[0], aCtx->fileSz);
                            /* Update the Row in rule */
                            aCtx->ctx.msg.cfpRule.rowAndSlice = ((value1 <<  ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);
                            aCtx->ctx.id = ETHSWT_CFPCMDID_UPDATERULE;
                            retVal = BCM_ERR_OK;
                        }
                    }
                }

            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Update Rule Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPUpdateRuleHdlr(BCM_CmdType    *aMsg,
                                   uint8_t       *aBuff,
                                   uint32_t       aInputLen,
                                   uint32_t      *aOutLen,
                                   uint32_t       aMaxLength,
                                   int32_t        aResponse,
                                   ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            memcpy(&cmdMsg.cfpRule, &aCtx->ctx.msg.cfpRule, sizeof(ETHSWT_CFPRuleType));
            cmdMsg.cfpRule.rowAndSlice = CPU_NativeToLE16(aCtx->ctx.msg.cfpRule.rowAndSlice);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_UPDATERULE);
            *aOutLen = sizeof(ETHSWT_CFPRuleType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.cfpRule, sizeof(ETHSWT_CFPRuleType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP update rule Failed. returned %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRuleType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Shapshot Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPSnapshotPrepCtxInt(char          *aStr,
                                             uint32_t      aStrLen,
                                             ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    uint32_t value1;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) && (remStrLen == 0)) {
        aCtx->ctx.id = ETHSWT_CFPCMDID_GETSNAPSHOT;
        retVal = BCM_ERR_OK;
    } else  {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            /* parse row number */
            value1 = MODULE_MsgParseInt(currStr, &parseStatus);
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
            if (value1 >= ETHSWT_CFP_MAX_RULES) {
                (void)MODULE_HostHelperLog("CFP row number must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                (void)MODULE_HostHelperLog("CFP row number must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_RULES-1UL);
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
            memset(aCtx->buff, 0U, ETHSWT_CFP_MAX_FILESIZE);
            aCtx->ctx.msg.cfpRule.rowAndSlice = ((value1 <<  ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK);
            aCtx->ctx.id = ETHSWT_CFPCMDID_GETROWCONFIG;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Get Snapshot Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPGetSnapshotHdlr(BCM_CmdType    *aMsg,
                                    uint8_t       *aBuff,
                                    uint32_t       aInputLen,
                                    uint32_t      *aOutLen,
                                    uint32_t       aMaxLength,
                                    int32_t        aResponse,
                                    ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETSNAPSHOT);
            *aOutLen = sizeof(ETHSWT_CFPTableSnapshotType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP get snapshot failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPTableSnapshotType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.cfpSnapshot, aBuff, sizeof(ETHSWT_CFPTableSnapshotType));
                aCtx->ctx.msg.cfpSnapshot.numValidEntries     = CPU_LEToNative32(msgUnion.cfpSnapshot.numValidEntries);
                memcpy(&aCtx->ctx.msg.cfpSnapshot.udfList, &msgUnion.cfpSnapshot.udfList, sizeof(aCtx->ctx.msg.cfpSnapshot.udfList));
                aCtx->ctx.msg.cfpSnapshot.portEnableMask      = CPU_LEToNative16(msgUnion.cfpSnapshot.portEnableMask);

                memset(&msgUnion.cfpRuleList, 0, aMaxLength);
                memset(aCtx->cfpRuleSnapBuff, 0UL, sizeof(ETHSWT_CFPEntrySnapshotType) * (ETHSWT_CFP_MAX_RULES));
                aCtx->idx = 0UL;
                msgUnion.cfpRuleList.num = 0UL;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETRULELIST);
                *aOutLen = sizeof(ETHSWT_CFPRuleListType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                memcpy(aBuff, &msgUnion.cfpRuleList, sizeof(ETHSWT_CFPRuleListType));
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP get snapshot failed, retVal = %d\n",
                                                          CPU_LEToNative32(aResponse));
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRuleListType))) {
                MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                memcpy(&msgUnion.cfpRuleList, aBuff, sizeof(ETHSWT_CFPRuleListType));
                memcpy(&aCtx->cfpRuleSnapBuff[aCtx->idx], &msgUnion.cfpRuleList.entry[0], CPU_LEToNative32(msgUnion.cfpRuleList.num));
                aCtx->idx += CPU_LEToNative32(msgUnion.cfpRuleList.num);
                if(ETHSWT_CFP_MAX_RULES <= aCtx->idx) {
                    ETHSWT_CFPShowPrint(aCtx);
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                } else {
                    memset(&msgUnion.cfpRuleList, 0, aMaxLength);
                    msgUnion.cfpRuleList.num = aCtx->idx;
                    *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETRULELIST);
                    *aOutLen = sizeof(ETHSWT_CFPRuleListType);
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                    memcpy(aBuff, &msgUnion.cfpRuleList, sizeof(ETHSWT_CFPRuleListType));
                }
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief CFP Get Row Config Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPGetRowCfgHdlr(BCM_CmdType    *aMsg,
                                  uint8_t       *aBuff,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse,
                                  ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            msgUnion.cfpRule.rowAndSlice = CPU_NativeToLE16(aCtx->ctx.msg.cfpRule.rowAndSlice);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETROWCONFIG);
            *aOutLen = sizeof(ETHSWT_CFPRuleType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &msgUnion.cfpRule, sizeof(ETHSWT_CFPRuleType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP get row config failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRuleType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&aCtx->ctx.msg.cfpRule, aBuff, aInputLen);
                ETHSWT_CFPConvertToNative(&aCtx->ctx.msg.cfpRule);
                ETHSWT_CFPShowRule(&aCtx->ctx.msg.cfpRule);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Get Status Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPGetStatusPrepCtxInt(char          *aStr,
                                              uint32_t      aStrLen,
                                              ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    /* parse row number */
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            aCtx->ctx.msg.cfpStats.row = MODULE_MsgParseInt(currStr, &parseStatus);
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
            aCtx->ctx.id = ETHSWT_CFPCMDID_GETSTATS;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Get Stats Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPGetStatsHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            msgUnion.cfpStats.row = CPU_NativeToLE32(aCtx->ctx.msg.cfpStats.row);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_GETSTATS);
            *aOutLen = sizeof(ETHSWT_CFPRowStatsType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &msgUnion.cfpStats, sizeof(ETHSWT_CFPRowStatsType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP get stats failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPRowStatsType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.cfpStats, aBuff, sizeof(ETHSWT_CFPRowStatsType));
                aCtx->ctx.msg.cfpStats.stats.green  = CPU_LEToNative32(msgUnion.cfpStats.stats.green);
                aCtx->ctx.msg.cfpStats.stats.yellow = CPU_LEToNative32(msgUnion.cfpStats.stats.yellow);
                aCtx->ctx.msg.cfpStats.stats.red    = CPU_LEToNative32(msgUnion.cfpStats.stats.red);
                (void)MODULE_HostHelperLog("Green : %u\n", aCtx->ctx.msg.cfpStats.stats.green);
                (void)MODULE_HostHelperLog("Yellow: %u\n", aCtx->ctx.msg.cfpStats.stats.yellow);
                (void)MODULE_HostHelperLog("Red   : %u\n", aCtx->ctx.msg.cfpStats.stats.red);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Set port mode Context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPSetPortModeCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    /* parse port number */
    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) && (remStrLen != 0)) {
        aCtx->ctx.msg.cfpPortMode.port = MODULE_MsgParseInt(remStr, &parseStatus);
        ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
        currStr = remStr;
        currStrLen = remStrLen;
        /* parse file name */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen != 0)) {
            currStr = remStr;
            currStrLen = remStrLen;
            /* parse file name */
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                retVal = BCM_ERR_OK;
                if (!strncmp(currStr, "enable", 6)) {
                    aCtx->ctx.msg.cfpPortMode.mode = 1UL;
                } else if (!strncmp(currStr, "disable", 7)) {
                    aCtx->ctx.msg.cfpPortMode.mode = 0UL;
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
                aCtx->ctx.id = ETHSWT_CFPCMDID_SETPORTMODE;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Set Port Mode Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPSetPortModeHdlr(BCM_CmdType    *aMsg,
                                    uint8_t       *aBuff,
                                    uint32_t       aInputLen,
                                    uint32_t      *aOutLen,
                                    uint32_t       aMaxLength,
                                    int32_t        aResponse,
                                    ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.cfpPortMode.port = CPU_NativeToLE32(aCtx->ctx.msg.cfpPortMode.port);
            cmdMsg.cfpPortMode.mode = CPU_NativeToLE32(aCtx->ctx.msg.cfpPortMode.mode);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_SETPORTMODE);
            *aOutLen = sizeof(ETHSWT_CFPPortModeType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.cfpPortMode, sizeof(ETHSWT_CFPPortModeType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("CFP set port mode failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPPortModeType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Policer Add Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerAddHelperPrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    char macStr[18];
    uint32_t block;
    uint32_t report;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, aStr, sizeof(macStr));
        macStr[17]='\0';

        parseStatus = MODULE_ConvertStrToMac(macStr, &aCtx->ctx.msg.streamPolicerEntry.macAddr[0]);
        if(BCM_ERR_OK == parseStatus) {


            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.vlanID = MODULE_MsgParseInt(currStr, &parseStatus); /* vlan */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.policerParams.rate  = MODULE_MsgParseInt(currStr, &parseStatus); /* rate */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.policerParams.burstSize = MODULE_MsgParseInt(currStr, &parseStatus); /* burst */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.policerParams.portMask = MODULE_MsgParseInt(currStr, &parseStatus); /* src_mask */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.policerParams.dropThreshold = MODULE_MsgParseInt(currStr, &parseStatus); /* threshold */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.policerParams.monitoringInterval = MODULE_MsgParseInt(currStr, &parseStatus); /* interval */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            report = MODULE_MsgParseInt(currStr, &parseStatus); /* report */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            block = MODULE_MsgParseInt(currStr, &parseStatus); /* block */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.streamPolicerEntry.policerParams.action  = (block & ETHSWT_CFPSTREAMPOLICERACTION_BLOCK_MASK) |
                                                                 ((report << ETHSWT_CFPSTREAMPOLICERACTION_REPORT_SHIFT) &
                                                                 ETHSWT_CFPSTREAMPOLICERACTION_REPORT_MASK);
            aCtx->ctx.id = ETHSWT_CFPCMDID_STREAMPOLICER_ADD;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Stream Policer Add Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmPolicerAddHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            msgUnion.streamPolicerEntry.vlanID    = CPU_NativeToLE16(aCtx->ctx.msg.streamPolicerEntry.vlanID);
            memcpy(&msgUnion.streamPolicerEntry.macAddr[0], &aCtx->ctx.msg.streamPolicerEntry.macAddr[0], 6UL);
            msgUnion.streamPolicerEntry.policerParams.portMask           = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.portMask);
            msgUnion.streamPolicerEntry.policerParams.rate               = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.rate);
            msgUnion.streamPolicerEntry.policerParams.burstSize          = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.burstSize);
            msgUnion.streamPolicerEntry.policerParams.dropThreshold      = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.dropThreshold);
            msgUnion.streamPolicerEntry.policerParams.monitoringInterval = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.monitoringInterval);
            msgUnion.streamPolicerEntry.policerParams.action             = aCtx->ctx.msg.streamPolicerEntry.policerParams.action;

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_ADD);
            *aOutLen = sizeof(ETHSWT_CFPStreamType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            memcpy(aBuff, &msgUnion.streamPolicerEntry, sizeof(ETHSWT_CFPStreamType));
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to add stream policer, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.streamPolicerEntry, aBuff, sizeof(ETHSWT_CFPStreamType));
                aCtx->ctx.msg.streamPolicerEntry.streamIdx = CPU_LEToNative32(msgUnion.streamPolicerEntry.streamIdx);
                (void)MODULE_HostHelperLog("SUCCESS: Added stream policer id %u\n", aCtx->ctx.msg.streamPolicerEntry.streamIdx);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Policer Delete Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerDelHelperPrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  ETHSWT_CFPHelperCtxType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            aCtx->ctx.msg.streamPolicerEntry.streamIdx = MODULE_MsgParseInt(aStr, &parseStatus); /* stream index */
            if(BCM_ERR_OK == parseStatus) {
                aCtx->ctx.id = ETHSWT_CFPCMDID_STREAMPOLICER_DEL;
                retVal = BCM_ERR_OK;
            }
        }
    }

return retVal;
}

/**
    @brief CFP Get Stats Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmPolicerDelHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.streamPolicerEntry.streamIdx = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.streamIdx);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_DEL);
            *aOutLen = sizeof(ETHSWT_CFPStreamType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.streamPolicerEntry, sizeof(ETHSWT_CFPStreamType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to delete stream policer, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}


/**
    @brief Prepare CFP Policer Block Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerBlockHelperPrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  ETHSWT_CFPHelperCtxType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            aCtx->ctx.msg.streamPolicerEntry.streamIdx = MODULE_MsgParseInt(aStr, &parseStatus); /* stream index */
            if(BCM_ERR_OK == parseStatus) {
                aCtx->ctx.id = ETHSWT_CFPCMDID_BLOCKSTREAM;
                retVal = BCM_ERR_OK;
            }
        }
    }

return retVal;
}

/**
    @brief CFP policer stream block Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmBlockHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.streamPolicerEntry.streamIdx = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.streamIdx);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_BLOCKSTREAM);
            *aOutLen = sizeof(ETHSWT_CFPStreamType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.streamPolicerEntry, sizeof(ETHSWT_CFPStreamType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to block stream policer, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Policer Resume Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerResHelperPrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  ETHSWT_CFPHelperCtxType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            aCtx->ctx.msg.streamPolicerEntry.streamIdx = MODULE_MsgParseInt(aStr, &parseStatus); /* stream index */
            if(BCM_ERR_OK == parseStatus) {
                aCtx->ctx.id = ETHSWT_CFPCMDID_RESUMESTREAM;
                retVal = BCM_ERR_OK;
            }
        }
    }

return retVal;
}

/**
    @brief CFP Stream Resume Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmResumeHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.streamPolicerEntry.streamIdx = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.streamIdx);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_RESUMESTREAM);
            *aOutLen = sizeof(ETHSWT_CFPStreamType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.streamPolicerEntry, sizeof(ETHSWT_CFPStreamType));
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to delete stream policer, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Policer Resume Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerShowPrepCtxInt(char          *aStr,
                                                uint32_t      aStrLen,
                                                ETHSWT_CFPHelperCtxType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            /* parse stream index */
            aCtx->ctx.msg.streamPolicerStatus.idx = MODULE_MsgParseInt(aStr, &parseStatus);
            if(BCM_ERR_OK == parseStatus) {
                if (aCtx->ctx.msg.streamPolicerStatus.idx >= ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES) {
                    (void)MODULE_HostHelperLog("Stream policer index must be in the range: [0,%lu]\n", ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES-1UL);
                } else {
                    aCtx->ctx.id = ETHSWT_CFPCMDID_STREAMPOLICER_GET;
                    retVal = BCM_ERR_OK;
                }
            }
        }
    } else {
        aCtx->ctx.id = ETHSWT_CFPCMDID_STREAMPOLICER_SNAPSHOT;
        retVal = BCM_ERR_OK;
    }

 return retVal;

}

/**
    @brief CFP Get Stats Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmPolicerSnapshotHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint32_t i;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_SNAPSHOT);
            *aOutLen = sizeof(ETHSWT_CFPStreamPolicerSnapshotType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
               break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Stream policer get snapshot failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamPolicerSnapshotType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&aCtx->ctx.msg.streamPolicerSnapshot, aBuff, sizeof(ETHSWT_CFPStreamPolicerSnapshotType));
                (void)MODULE_HostHelperLog("======= Stream Policer Snapshot =====\n");
                for (i = 0UL; i < ETHSWT_CFP_MAX_STREAM_POLICER_ENTRIES; ++i) {
                    if( 0U != (aCtx->ctx.msg.streamPolicerSnapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_VALID_MASK)) {
                        (void)MODULE_HostHelperLog("Stream ID %u: Static: %u Blocked: %u\n", i,
                        (aCtx->ctx.msg.streamPolicerSnapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_STATIC_MASK) >> ETHSWT_CFPSTREAMPOLICERSTATE_STATIC_SHIFT,
                        (aCtx->ctx.msg.streamPolicerSnapshot.policer[i] & ETHSWT_CFPSTREAMPOLICERSTATE_BLOCKED_MASK) >> ETHSWT_CFPSTREAMPOLICERSTATE_BLOCKED_SHIFT);
                    }
                }
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}


/**
    @brief CFP Get Stats Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmPolicerGetStatusHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            msgUnion.streamPolicerStatus.idx    = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerStatus.idx);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_GET);
            *aOutLen = sizeof(ETHSWT_CFPStreamPolicerStatusType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            memcpy(aBuff, &msgUnion.streamPolicerStatus, sizeof(ETHSWT_CFPStreamPolicerStatusType));
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Stream policer get failed, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamPolicerStatusType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.streamPolicerStatus, aBuff, sizeof(ETHSWT_CFPStreamPolicerStatusType));
                memcpy(aCtx->ctx.msg.streamPolicerStatus.macAddress, msgUnion.streamPolicerStatus.macAddress, 6U);
                aCtx->ctx.msg.streamPolicerStatus.idx       = CPU_LEToNative32(msgUnion.streamPolicerStatus.idx);
                aCtx->ctx.msg.streamPolicerStatus.vlan      = CPU_LEToNative16(msgUnion.streamPolicerStatus.vlan);
                aCtx->ctx.msg.streamPolicerStatus.portMask  = CPU_LEToNative32(msgUnion.streamPolicerStatus.portMask);
                aCtx->ctx.msg.streamPolicerStatus.blocked   = CPU_LEToNative32(msgUnion.streamPolicerStatus.blocked);
                aCtx->ctx.msg.streamPolicerStatus.isStatic  = CPU_LEToNative32(msgUnion.streamPolicerStatus.isStatic);
                aCtx->ctx.msg.streamPolicerStatus.greenCntr = CPU_LEToNative32(msgUnion.streamPolicerStatus.greenCntr);
                aCtx->ctx.msg.streamPolicerStatus.redCntr   = CPU_LEToNative32(msgUnion.streamPolicerStatus.redCntr);
                (void)MODULE_HostHelperLog("Stream Idx:          %u\n", aCtx->ctx.msg.streamPolicerStatus.idx);
                (void)MODULE_HostHelperLog("MAC Address:         %02x:%02x:%02x:%02x:%02x:%02x\n",
                        aCtx->ctx.msg.streamPolicerStatus.macAddress[0], aCtx->ctx.msg.streamPolicerStatus.macAddress[1],
                        aCtx->ctx.msg.streamPolicerStatus.macAddress[2], aCtx->ctx.msg.streamPolicerStatus.macAddress[3],
                        aCtx->ctx.msg.streamPolicerStatus.macAddress[4], aCtx->ctx.msg.streamPolicerStatus.macAddress[5]);
                (void)MODULE_HostHelperLog("VLAN:                %u\n", aCtx->ctx.msg.streamPolicerStatus.vlan);
                (void)MODULE_HostHelperLog("PortMask:            0x%x\n", aCtx->ctx.msg.streamPolicerStatus.portMask);
                (void)MODULE_HostHelperLog("Blocked:             %s\n", (TRUE == aCtx->ctx.msg.streamPolicerStatus.blocked) ? "TRUE": "FALSE");
                (void)MODULE_HostHelperLog("Static:              %s\n", (TRUE == aCtx->ctx.msg.streamPolicerStatus.isStatic) ? "TRUE": "FALSE");
                (void)MODULE_HostHelperLog("InBand stats:      %u\n", aCtx->ctx.msg.streamPolicerStatus.greenCntr);
                (void)MODULE_HostHelperLog("OutOfBand stats:  %u\n", aCtx->ctx.msg.streamPolicerStatus.redCntr);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}


/**
    @brief Prepare CFP Policer Find Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPolicerFindPrepCtxInt(char          *aStr,
                                                uint32_t      aStrLen,
                                                ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    char macStr[18];
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, aStr, sizeof(macStr));
        macStr[17]='\0';

        parseStatus = MODULE_ConvertStrToMac(macStr, &aCtx->ctx.msg.streamPolicerEntry.macAddr[0]);
        if(BCM_ERR_OK == parseStatus) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.streamPolicerEntry.vlanID = MODULE_MsgParseInt(currStr, &parseStatus); /* vlan */
            ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            if ((remStr == NULL) &&(remStrLen == 0)) {
                aCtx->ctx.msg.streamPolicerEntry.policerParams.portMask  = MODULE_MsgParseInt(currStr, &parseStatus); /* srcMask */
                ETHSWT_CFP_CMD_INT_PARSE_STATUS(parseStatus);
                aCtx->ctx.id = ETHSWT_CFPCMDID_STREAMPOLICER_FIND;
                retVal = BCM_ERR_OK;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief CFP Get Stats Handler

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPStrmPolicerFindIdxHdlr(BCM_CmdType    *aMsg,
                                 uint8_t       *aBuff,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_CFPMsgUnionType msgUnion;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            msgUnion.streamPolicerEntry.vlanID    = CPU_NativeToLE16(aCtx->ctx.msg.streamPolicerEntry.vlanID);
            memcpy(&msgUnion.streamPolicerEntry.macAddr[0], &aCtx->ctx.msg.streamPolicerEntry.macAddr[0], 6UL);
            msgUnion.streamPolicerEntry.policerParams.portMask           = CPU_NativeToLE32(aCtx->ctx.msg.streamPolicerEntry.policerParams.portMask);

            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_CFP_ID, ETHSWT_CFPCMDID_STREAMPOLICER_FIND);
            *aOutLen = sizeof(ETHSWT_CFPStreamType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            memcpy(aBuff, &msgUnion.streamPolicerEntry, sizeof(ETHSWT_CFPStreamType));
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to find stream policer, retVal = %d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_CFPStreamType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.streamPolicerEntry, aBuff, sizeof(ETHSWT_CFPStreamType));
                aCtx->ctx.msg.streamPolicerEntry.streamIdx = CPU_LEToNative32(msgUnion.streamPolicerEntry.streamIdx);
                (void)MODULE_HostHelperLog("SUCCESS: Stream policer index %u\n", aCtx->ctx.msg.streamPolicerEntry.streamIdx);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare CFP Helper context

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_CFPHelperPrepCtx(char          *aStr,
                                 uint32_t      *aStrLen,
                                 ETHSWT_CFPHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        /* skip the first string which is validated in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            if (!strncmp(remStr, "add", 3)) {
                retVal = ETHSWT_CFPAddRulePrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "delete", 6)) {
                retVal = ETHSWT_CFPDeleteRulePrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "update", 6)) {
                retVal = ETHSWT_CFPUpdateRulePrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "show", 4)) {
                retVal = ETHSWT_CFPSnapshotPrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "stats", 5)) {
                retVal = ETHSWT_CFPGetStatusPrepCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "port", 4)) {
                retVal = ETHSWT_CFPSetPortModeCtxInt(remStr, remStrLen, aCtx);
            } else if (!strncmp(remStr, "policer", 4)) {
                currStr = remStr;
                currStrLen = remStrLen;
                /* Find and prepare the sub commands for policer */
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) && (remStrLen > 1UL)) {
                    currStr = remStr;
                    currStrLen = remStrLen;
                    /* Find and prepare the sub commands for policer */
                    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                    if (!strncmp(currStr, "add", 3)) {
                        retVal = ETHSWT_CFPPolicerAddHelperPrepCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "del", 3)) {
                        retVal = ETHSWT_CFPPolicerDelHelperPrepCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "block", 5)) {
                        retVal = ETHSWT_CFPPolicerBlockHelperPrepCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "resume", 6)) {
                        retVal = ETHSWT_CFPPolicerResHelperPrepCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "show", 4)) {
                        retVal = ETHSWT_CFPPolicerShowPrepCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "find", 4)) {
                        retVal = ETHSWT_CFPPolicerFindPrepCtxInt(remStr, remStrLen, aCtx);
                    } else {
                        /* Invalid Command */
                    }
                }
            } else {
                /* Invalid Command */
            }
        } else {
            /* Invalid Command */
        }
    }

    return retVal;
}

/** @brief Process CFP request string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPHelperProcess(BCM_CmdType    *aMsg,
                                  char          *aStr,
                                  uint32_t      *aStrLen,
                                  uint8_t       *aInOut,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_CFPHelperCtx.modCtx.substate) {
        retVal = ETHSWT_CFPHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_CFPHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_CFPHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_CFPHelperCtx.ctx.id) {
        case ETHSWT_CFPCMDID_ADDRULE:
            retVal = ETHSWT_CFPAddRuleHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_REMOVERULE:
            retVal = ETHSWT_CFPDeleteRuleHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_UPDATERULE:
            retVal = ETHSWT_CFPUpdateRuleHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_GETSNAPSHOT:
            retVal = ETHSWT_CFPGetSnapshotHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_GETROWCONFIG:
            retVal = ETHSWT_CFPGetRowCfgHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_GETSTATS:
            retVal = ETHSWT_CFPGetStatsHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_SETPORTMODE:
            retVal = ETHSWT_CFPSetPortModeHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_STREAMPOLICER_ADD:
            retVal = ETHSWT_CFPStrmPolicerAddHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_STREAMPOLICER_DEL:
            retVal = ETHSWT_CFPStrmPolicerDelHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_BLOCKSTREAM:
            retVal = ETHSWT_CFPStrmBlockHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_RESUMESTREAM:
            retVal = ETHSWT_CFPStrmResumeHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_STREAMPOLICER_SNAPSHOT:
            retVal = ETHSWT_CFPStrmPolicerSnapshotHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_STREAMPOLICER_GET:
            retVal = ETHSWT_CFPStrmPolicerGetStatusHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        case ETHSWT_CFPCMDID_STREAMPOLICER_FIND:
            retVal = ETHSWT_CFPStrmPolicerFindIdxHdlr(aMsg, aInOut, aInputLen,
                                                aOutLen, aMaxLength, aResponse,
                                                &ETHSWT_CFPHelperCtx);
            break;
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}


/** @brief CFP Print Helper

    Print CFP Messages

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_CFPPrintHelper(BCM_CmdType    aCmd,
                                  uint8_t *aMsg, uint32_t aSize)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint8_t notificationId;
    ETHSWT_CFPMsgUnionType respMsg;

    if (NULL != aMsg) {
        if (0UL != (aCmd & BCM_CMD_ASYNC_MASK)) {
            notificationId = BCM_GET_CMDID(aCmd);

            if(ETHSWT_CFPASYNCID_STREAM_EXCEEDED == notificationId) {
                if (aSize == sizeof(ETHSWT_CFPStreamPolicerStatusType)) {
                    memcpy(&respMsg.streamPolicerStatus, aMsg, sizeof(ETHSWT_CFPStreamPolicerStatusType));
                    (void)MODULE_HostHelperLog("%s: Stream: %u exceeded, blocked %u\n",
                            __func__,
                            CPU_LEToNative32(respMsg.streamPolicerStatus.idx),
                            CPU_LEToNative32(respMsg.streamPolicerStatus.blocked));
                    retVal = BCM_ERR_OK;
                } else {
                    (void)MODULE_HostHelperLog("%s: Invalid parameter notificationId:0x%x size=%d\n",
                        __func__,  notificationId, aSize);
                }
            } else {
                (void)MODULE_HostHelperLog("%s: Invalid parameter notificationId:0x%x size=%d\n",
                    __func__,  notificationId, aSize);
            }
        }
    }

    return retVal;
}

/**
    @brief Switch CFP Helper

    @trace #BRCM_SWARCH_ETHSWT_CFPHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_CFPHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_CFP_ID,
    .helpstr = ETHSWT_CFPHelpCmds,
    .context = &ETHSWT_CFPHelperCtx.modCtx,
    .process = ETHSWT_CFPHelperProcess,
    .print   = ETHSWT_CFPPrintHelper,
};
/** @} */
