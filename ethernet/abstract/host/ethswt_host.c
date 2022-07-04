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
    @defgroup grp_ethsrv_swt_host_impl Switch Host Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethsrv_swt_host_impl
    @{

    @file ethswtm_host.c

    @brief Switch Host Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <module_msg.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <ethernet_swt_debug.h>
#include <ethernet_swt_ext.h>
#include <bcm_utils.h>
#include "ethswt_host_common.h"

/**
    @name Ethernet switch Helper Design ID's
    @{
    @brief Ethernet switch Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_SWT_HELPER_CTX_GLOBAL                (0xC201U)    /**< @brief #ETHSWT_SWTHelperCtx                 */
#define BRCM_SWDSGN_ETHSWT_SWT_DBGHELPER_CTX_GLOBAL             (0xC202U)    /**< @brief #ETHSWT_SWTDbgHelperCtx              */
#define BRCM_SWDSGN_ETHSWT_SWTHOSTCMD_TYPE                      (0xC203U)    /**< @brief #ETHSWT_SWTHostCmdType               */
#define BRCM_SWDSGN_ETHSWT_SWT_HELPCMDS_GLOBAL                  (0xC204U)    /**< @brief #ETHSWT_SWTHelpCmds                  */
#define BRCM_SWDSGN_ETHSWT_SWT_DBGHELPCMDS_GLOBAL               (0xC205U)    /**< @brief #ETHSWT_SWTDbgHelpCmds               */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTINFO_PREPCTXINT_PROC         (0xC206U)    /**< @brief #ETHSWT_SWTPortInfoPrepCtxInt        */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTADMINMODE_PREPCTXINT_PROC    (0xC207U)    /**< @brief #ETHSWT_SWTPortAdminModePrepCtxInt   */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTGETSPEED_PREPCTXINT_PROC     (0xC208U)    /**< @brief #ETHSWT_SWTPortGetSpeedPrepCtxInt    */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTMASTERSLAVE_PREPCTXINT_PROC  (0xC209U)    /**< @brief #ETHSWT_SWTPortMasterSlavePrepCtxInt */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTPHYLBMODE_PREPCTXINT_PROC    (0xC20AU)    /**< @brief #ETHSWT_SWTPortPhyLbModePrepCtxInt   */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTJUMBOFRAME_PREPCTXINT_PROC   (0xC20BU)    /**< @brief #ETHSWT_SWTPortJumboFramePrepCtxInt  */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTTC10_PREPCTXINT_PROC         (0xC20CU)    /**< @brief #ETHSWT_SWTPortTC10PrepCtxInt        */
#define BRCM_SWDSGN_ETHSWT_SWT_PORTLINKSQI_PREPCTXINT_PROC      (0xC20DU)    /**< @brief #ETHSWT_SWTPortLinkSQIPrepCtxInt     */
#define BRCM_SWDSGN_ETHSWT_SWT_PVID_PREPCTXINT_PROC             (0xC20EU)    /**< @brief #ETHSWT_SWTPvidPrepCtxInt            */
#define BRCM_SWDSGN_ETHSWT_SWT_AGETIME_PREPCTXINT_PROC          (0xC20FU)    /**< @brief #ETHSWT_SWTAgeTimePrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_SWT_DUMBFWD_PREPCTXINT_PROC          (0xC210U)    /**< @brief #ETHSWT_SWTDumbFwdPrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_SWT_BRCMHDR_PREPCTXINT_PROC          (0xC211U)    /**< @brief #ETHSWT_SWTBRCMHdrPrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_SWT_MGMTMODE_PREPCTXINT_PROC         (0xC212U)    /**< @brief #ETHSWT_SWTMgmtModePrepCtxInt        */
#define BRCM_SWDSGN_ETHSWT_SWT_READ_PREPCTXINT_PROC             (0xC213U)    /**< @brief #ETHSWT_SWTReadPrepCtxInt            */
#define BRCM_SWDSGN_ETHSWT_SWT_WRITE_PREPCTXINT_PROC            (0xC214U)    /**< @brief #ETHSWT_SWTWritePrepCtxInt           */
#define BRCM_SWDSGN_ETHSWT_SWT_IFILTER_PREPCTXINT_PROC          (0xC215U)    /**< @brief #ETHSWT_SWTiFilterPrepCtxInt         */
#define BRCM_SWDSGN_ETHSWT_SWT_VLANHOPCRTLCTX_PROC              (0xC216U)    /**< @brief #ETHSWT_SWTVlanHopCtrlCtxInt         */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_PORTLIMITCTX_PROC            (0xC217U)    /**< @brief #ETHSWT_SWTArlPortLimitCtxInt        */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_STICKYCTX_PROC               (0xC218U)    /**< @brief #ETHSWT_SWTArlStickyCtxInt           */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_MOVEDETECTCTX_PROC           (0xC219U)    /**< @brief #ETHSWT_SWTArlMoveDetectCtxInt       */
#define BRCM_SWDSGN_ETHSWT_SWT_ARL_TOTALLIMITCTX_PROC           (0xC21AU)    /**< @brief #ETHSWT_SWTArlTotalLimitCtxInt       */
#define BRCM_SWDSGN_ETHSWT_SWT_HELPERPREP_CTX_PROC              (0xC21BU)    /**< @brief #ETHSWT_SWTHelperPrepCtx             */
#define BRCM_SWDSGN_ETHSWT_SWT_HELPERPROCESS_PROC               (0xC21CU)    /**< @brief #ETHSWT_SWTHelperProcess             */
#define BRCM_SWDSGN_ETHSWT_SWTHELPER_GLOBAL                     (0xC21DU)    /**< @brief #ETHSWT_SWTHelper                    */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_HELPERPREP_CTX_PROC          (0xC21EU)    /**< @brief #ETHSWT_SWTDbgHelperPrepCtx          */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_HELPERPROCESS_PROC           (0xC21FU)    /**< @brief #ETHSWT_SWTDbgHelperProcess          */
#define BRCM_SWDSGN_ETHSWT_SWT_PRINT_HELPER_GLOBAL              (0xC220U)    /**< @brief #ETHSWT_SWTPrintHelper               */
#define BRCM_SWDSGN_ETHSWT_SWT_DBG_HELPER_GLOBAL                (0xC221U)    /**< @brief #ETHSWT_SWTDebugHelper               */
#define BRCM_SWDSGN_ETHSWT_EXTHOSTCONTEXTSETUP_PROC             (0xC222U)    /**< @brief #ETHSWT_ExtHostContextSetup          */
#define BRCM_SWDSGN_ETHSWT_EXTHOSTCONTEXTPROCESS_PROC           (0xC223U)    /**< @brief #ETHSWT_ExtHostContextProcess        */
#define BRCM_SWDSGN_ETHSWT_DEBUGHOSTCONTEXTSETUP_PROC           (0xC224U)    /**< @brief #ETHSWT_DebugHostContextSetup        */
#define BRCM_SWDSGN_ETHSWT_DEBUGHOSTCONTEXTPROCESS_PROC         (0xC225U)    /**< @brief #ETHSWT_DebugHostContextProcess      */
/** @} */

/**
    @brief Switch Helper Module Context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_SWTHelperCtxType ETHSWT_SWTHelperCtx;

/**
    @brief Switch HelperDebug Module Context

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_SWTDbgHelperCtxType ETHSWT_SWTDbgHelperCtx;

/** @brief  Switch commands Type

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
typedef uint32_t ETHSWT_SWTHostCmdType;
#define ETHSWT_SWTHOSTCMD_PORTGETINFO               (0xFF000001UL)
#define ETHSWT_SWTHOSTCMD_PORTSETINFO               (0xFF000002UL)
#define ETHSWT_SWTHOSTCMD_PORTSETADMINMODE          (0xFF000003UL)
#define ETHSWT_SWTHOSTCMD_PORTGETADMINMODE          (0xFF000004UL)
#define ETHSWT_SWTHOSTCMD_PORTGETPORTSPEED          (0xFF000005UL)
#define ETHSWT_SWTHOSTCMD_PORTSETMASTERSLAVE        (0xFF000006UL)
#define ETHSWT_SWTHOSTCMD_PORTGETMASTERSLAVE        (0xFF000007UL)
#define ETHSWT_SWTHOSTCMD_PORTSETPHYLBMODE          (0xFF000008UL)
#define ETHSWT_SWTHOSTCMD_PORTGETPHYLBMODE          (0xFF000009UL)
#define ETHSWT_SWTHOSTCMD_PORTSETJUMBOFRAME         (0xFF00000AUL)
#define ETHSWT_SWTHOSTCMD_PORTGETJUMBOFRAME         (0xFF00000BUL)
#define ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPMODE     (0xFF00000CUL)
#define ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPREASON   (0xFF00000DUL)
#define ETHSWT_SWTHOSTCMD_PORTGETLINKSQI            (0xFF00000EUL)
#define ETHSWT_SWTHOSTCMD_PORTGETLINKSQIPORT        (0xFF00000FUL)
#define ETHSWT_SWTHOSTCMD_PORTSETPVID               (0xFF000010UL)
#define ETHSWT_SWTHOSTCMD_CTRLRSETAGETIME           (0xFF000011UL)
#define ETHSWT_SWTHOSTCMD_CTRLRGETAGETIME           (0xFF000012UL)
#define ETHSWT_SWTHOSTCMD_CTRLRSETDUMBFWD           (0xFF000013UL)
#define ETHSWT_SWTHOSTCMD_CTRLRGETDUMBFWD           (0xFF000014UL)
#define ETHSWT_SWTHOSTCMD_CTRLRSETBRCMHDR           (0xFF000015UL)
#define ETHSWT_SWTHOSTCMD_CTRLRGETBRCMHDR           (0xFF000016UL)
#define ETHSWT_SWTHOSTCMD_CTRLRSETMGMT              (0xFF000017UL)
#define ETHSWT_SWTHOSTCMD_CTRLRGETMGMT              (0xFF000018UL)
#define ETHSWT_SWTHOSTCMD_CTRLRSETIFILTER           (0xFF000019UL)
#define ETHSWT_SWTHOSTCMD_CTRLRGETIFILTER           (0xFF00001AUL)
#define ETHSWT_SWTHOSTCMD_CTRLRREAD                 (0xFF00001BUL)
#define ETHSWT_SWTHOSTCMD_CTRLRWRITE                (0xFF00001CUL)

/**
    @brief Supported Switch Helper commands

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_SWTHelpCmds[] =
"read <addr> <0:master|1:slave>\n"
"write <addr> <dataHigh> <dataLow> <0:master|1:slave>\n"
"port info <port>\n"
"age_time set <age_time>\n"
"age_time get\n"
"dumbfwd set <disable|enable>\n"
"dumbfwd get\n"
"brcmhdr set <disable|enable>\n"
"brcmhdr get\n"
"mgmtmode set <disable|enable>\n"
"mgmtmode get\n"
"admin_mode set <port> <disable|enable>\n"
"admin_mode get <port>\n"
"speed get <port>\n"
"master_slave set <port> <slave|master>\n"
"master_slave get <port>\n"
"phy_lb_mode set <port> <disable|enable>\n"
"phy_lb_mode get <port>\n"
"jumbo_frame set <port> <disable|enable>\n"
"jumbo_frame get <port>\n"
"link sqi [port]\n"
"pvidset <port> <pvid> <priority>\n"
"ifilter [disable|enable]\n"
"tc10 get wakeup_mode <port>\n"
"tc10 get wakeup_reason <port>\n"
#ifdef ENABLE_ETHSWT_SECURITY
"hop_detect_vlan set <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"hop_detect_vlan get\n"
"port_limit_arl set <port> <0:disabled|1:drop pkt|2:redirect to CPU|3:normal|4:copy to CPU> [limit]\n"
"port_limit_arl get <port>\n"
"sticky_arl set <port> <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"sticky_arl get <port>\n"
"move_detect_arl set <port> <0:disabled|1:drop pkt|2:redirect to CPU>\n"
"move_detect_arl get <port>\n"
"total_limit_arl set <limit>\n"
"total_limit_arl get\n"
#endif /* ENABLE_ETHSWT_SECURITY */
;

/**
    @brief Supported Switch Debug Helper commands

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_SWTDbgHelpCmds[] =
"<port> [clear]\n"
;

/**
    @brief Prepare Switch Port info snd Mibs context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortInfoPrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr, "info", 4)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETINFO;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Port Admin Mode context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortAdminModePrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETADMINMODE;
            retVal = BCM_ERR_OK;

        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            if(!strncmp(currStr,"enable", 6)) {
                aCtx->ctx.msg.portInfo.adminMode = ETHXCVR_MODE_ACTIVE;
            }else if(!strncmp(currStr,"disable", 7)) {
                aCtx->ctx.msg.portInfo.adminMode = ETHXCVR_MODE_DOWN;
            }else{
                (void)MODULE_HostHelperLog("switch port admin_mode set <port> <disable|enable>\n");
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTSETADMINMODE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Port Get Speed context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortGetSpeedPrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) && (remStrLen == 0)) {
                    aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
                    if(BCM_ERR_OK == parseStatus) {
                        aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETPORTSPEED;
                        retVal = BCM_ERR_OK;
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @brief Prepare Switch Port Master Slave context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortMasterSlavePrepCtxInt(char          *aStr,
                                                   uint32_t      aStrLen,
                                                   ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETMASTERSLAVE;
            retVal = BCM_ERR_OK;

        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            if (!strncmp(currStr,"slave", 5)) {
                aCtx->ctx.msg.portInfo.masterEnable = ETHXCVR_BOOLEAN_FALSE;
            } else if (!strncmp(currStr,"master", 6)) {
                aCtx->ctx.msg.portInfo.masterEnable = ETHXCVR_BOOLEAN_TRUE;
            } else {
                (void)MODULE_HostHelperLog("port master_slave set <port> <slave|master>\n");
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTSETMASTERSLAVE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Port PHY Loopback context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortPhyLbModePrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK == parseStatus) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETPHYLBMODE;
                retVal = BCM_ERR_OK;
            }
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            if(!strncmp(currStr,"enable", 6)) {
                aCtx->ctx.msg.portInfo.loopbackEnable = ETHXCVR_BOOLEAN_TRUE;
            } else if(!strncmp(currStr,"disable", 7)) {
                aCtx->ctx.msg.portInfo.loopbackEnable = ETHXCVR_BOOLEAN_FALSE;
            } else {
                (void)MODULE_HostHelperLog("port phy_lb_mode set <port> <disable|enable>\n");
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTSETPHYLBMODE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Port Jumbo Frame context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortJumboFramePrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port  = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETJUMBOFRAME;
            retVal = BCM_ERR_OK;
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.portInfo.port  = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            if(!strncmp(currStr,"enable", 6)) {
                aCtx->ctx.msg.portInfo.jumboEnable = ETHXCVR_BOOLEAN_TRUE;
            } else if(!strncmp(currStr,"disable", 7)) {
                aCtx->ctx.msg.portInfo.jumboEnable = ETHXCVR_BOOLEAN_FALSE;
            } else {
                (void)MODULE_HostHelperLog("port jumbo_frame set <port> <disable|enable>\n");
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTSETJUMBOFRAME;
            retVal = BCM_ERR_OK;
        }
    }
done:
    return retVal;
}

/**
    @brief Prepare Switch Port TC10 context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortTC10PrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr, "get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            if (!strncmp(currStr, "wakeup_mode", 11)) {
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }

                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                aCtx->ctx.msg.tc10Wake.port = MODULE_MsgParseInt(currStr, &parseStatus); /* Port index */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPMODE;
                retVal = BCM_ERR_OK;

            } else if (!strncmp(currStr, "wakeup_reason", 13)) {
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->ctx.msg.tc10Wake.port = MODULE_MsgParseInt(currStr, &parseStatus); /* Port index */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPREASON;
                retVal = BCM_ERR_OK;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Port Link SQI context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPortLinkSQIPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr, "sqi", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETLINKSQI;
                retVal = BCM_ERR_OK;
            } else {
                currStr = remStr;
                currStrLen = remStrLen;
                aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTGETLINKSQIPORT;
                retVal = BCM_ERR_OK;
            }
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Pvid context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPvidPrepCtxInt(char          *aStr,
                                        uint32_t      aStrLen,
                                        ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        aCtx->ctx.msg.portInfo.port = MODULE_MsgParseInt(aStr, &parseStatus); /* port */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

        aCtx->ctx.msg.portInfo.pvid = MODULE_MsgParseInt(currStr, &parseStatus); /* pvid */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        if ((remStr == NULL) || (remStrLen == 0)) {
            aCtx->ctx.msg.portInfo.prio = 0xFFFFFFFFUL; /* Indicate Default priority */
            (void)MODULE_HostHelperLog("%s: priority value missing, should be between 0-7\n", __func__);
            retVal = BCM_ERR_INVAL_PARAMS;
            goto done;
        } else {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            aCtx->ctx.msg.portInfo.prio = MODULE_MsgParseInt(currStr, &parseStatus); /* priority */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_PORTSETPVID;
            retVal = BCM_ERR_OK;

        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch Age Time  context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTAgeTimePrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
         if(!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRGETAGETIME;
                retVal = BCM_ERR_OK;
            }
        } else if(!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr == NULL) && (remStrLen == 0)) {
                    aCtx->ctx.msg.switchInfo.ageTime = MODULE_MsgParseInt(currStr, &parseStatus); /* Age Time */
                    if(BCM_ERR_OK == parseStatus) {
                        aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRSETAGETIME;
                        retVal = BCM_ERR_OK;
                    }
                }
            }
        }
    }

    return retVal;
}

/**
    @brief Prepare Switch  Dumb Forward context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTDumbFwdPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRGETDUMBFWD;
                retVal = BCM_ERR_OK;
            }
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen ;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                if (!strncmp(currStr,"enable", 6)) {
                    aCtx->ctx.msg.switchInfo.dumbFwdMode = ETHSWT_DUMBFWD_ENABLE;
                } else if (!strncmp(currStr,"disable", 7)) {
                    aCtx->ctx.msg.switchInfo.dumbFwdMode = ETHSWT_DUMBFWD_DISABLE;
                } else {
                    goto done;
                }
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRSETDUMBFWD;
                retVal = BCM_ERR_OK;
            }
        }
    }
done:
    return retVal;
}

/**
    @brief Prepare Switch BRCM Header context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTBRCMHdrPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRGETBRCMHDR;
                retVal = BCM_ERR_OK;
            }
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen ;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                if (!strncmp(currStr,"enable", 6)) {
                    aCtx->ctx.msg.switchInfo.brcmHdrMode = ETHSWT_BRCMHDR_ENABLE;
                } else if (!strncmp(currStr,"disable", 7)) {
                    aCtx->ctx.msg.switchInfo.brcmHdrMode = ETHSWT_BRCMHDR_DISABLE;
                } else {
                    goto done;
                }

                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRSETBRCMHDR;
                retVal = BCM_ERR_OK;
            }
        }
    }
done:
    return retVal;
}

/**
    @brief Prepare Switch Management Mode context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTMgmtModePrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) && (remStrLen == 0)) {
                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRGETMGMT;
                retVal = BCM_ERR_OK;
            }
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen != 0)) {
                currStr = remStr;
                currStrLen = remStrLen ;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }

                if (!strncmp(currStr,"enable", 6)) {
                    aCtx->ctx.msg.switchInfo.mgmtMode = ETHSWT_MGMTMODE_ENABLE;
                } else if (!strncmp(currStr,"disable", 7)) {
                    aCtx->ctx.msg.switchInfo.mgmtMode = ETHSWT_MGMTMODE_DISABLE;
                } else {
                    goto done;
                }

                aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRSETMGMT;
                retVal = BCM_ERR_OK;
            }
        }
    }
done:
    return retVal;
}

/**
    @brief Prepare Switch iFilter context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTiFilterPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           ETHSWT_SWTHelperCtxType *aCtx)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr == NULL) && (aStrLen == 0)) {
        aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRGETIFILTER;
        retVal = BCM_ERR_OK;
    } else {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) && (remStrLen == 0)) {
            if (!strncmp(aStr,"enable", 6)) {
                aCtx->ctx.msg.switchInfo.iFilter = ETHSWT_VLAN_INGRESS_FILTER_MODE_ENABLED;
            } else if (!strncmp(aStr,"disable", 7)) {
                aCtx->ctx.msg.switchInfo.iFilter = ETHSWT_VLAN_INGRESS_FILTER_MODE_DISABLED;
            } else {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRSETIFILTER;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch read context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTReadPrepCtxInt(char          *aStr,
                                        uint32_t      aStrLen,
                                        ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        /* Fetch the address to be read */
        aCtx->ctx.msg.regAccess.addr = MODULE_MsgParseInt(aStr, &parseStatus); /* addr */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        currStr = remStr;
        currStrLen = remStrLen;

        aCtx->ctx.msg.regAccess.deviceID = MODULE_MsgParseInt(currStr, &parseStatus); /* deviceID */
        if((BCM_ERR_OK != parseStatus) || ((MCU_DEVICE_SLAVE_1 < aCtx->ctx.msg.regAccess.deviceID))) {
            goto done;
        }

        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) || (remStrLen != 0)) {
            goto done;
        }
        aCtx->ctx.msg.regAccess.len = 1UL; /* len */
        aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRREAD;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch write context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTWritePrepCtxInt(char          *aStr,
                                         uint32_t      aStrLen,
                                         ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    uint64_t *u64Val;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr != NULL) && (aStrLen != 0)) {
        /* Fetch the address to be read */
        aCtx->ctx.msg.regAccess.addr = MODULE_MsgParseInt(aStr, &parseStatus); /* addr */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        currStr = remStr;
        currStrLen = remStrLen;

        u64Val = (uint64_t *)aCtx->ctx.msg.regAccess.data ;
        /* Fetch dataHigh*/
        *u64Val = MODULE_MsgParseInt(currStr, &parseStatus);
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        currStr = remStr;
        currStrLen = remStrLen;

        /* Fetch dataLow */
        *u64Val |= MODULE_MsgParseInt(currStr, &parseStatus);
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }

        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }
        currStr = remStr;
        currStrLen = remStrLen;

        aCtx->ctx.msg.regAccess.deviceID = MODULE_MsgParseInt(currStr, &parseStatus); /* deviceID */
        if((BCM_ERR_OK != parseStatus) || ((MCU_DEVICE_SLAVE_1 < aCtx->ctx.msg.regAccess.deviceID))) {
            goto done;
        }

        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) || (remStrLen != 0)) {
            goto done;
        }
        aCtx->ctx.msg.regAccess.len = 1UL; /* len */
        aCtx->ctx.id = ETHSWT_SWTHOSTCMD_CTRLRWRITE;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

#ifdef ENABLE_ETHSWT_SECURITY
/**
    @brief Prepare Switch VLAN Hop Control context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_SWTVlanHopCtrlCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if (!strncmp(aStr,"get", 3)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) || (remStrLen != 0)) {
            goto done;
        }
        aCtx->ctx.id = ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_GET;
        retVal = BCM_ERR_OK;
    } else if (!strncmp(aStr,"set", 3)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            goto done;
        }

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr != NULL) || (remStrLen != 0)) {
            goto done;
        }

        aCtx->ctx.msg.vlanHoppingAction = MODULE_MsgParseInt(currStr, &parseStatus); /* action */
        if(BCM_ERR_OK != parseStatus) {
            goto done;
        }
        aCtx->ctx.id = ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_SET;
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch ARL Port Limit context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_SWTArlPortLimitCtxInt(char          *aStr,
                                             uint32_t      aStrLen,
                                             ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            /* TODO: Check if it is addrLimitPtr OR stickyMACPtr */
            aCtx->ctx.msg.addrLimit.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_GET;
            retVal = BCM_ERR_OK;

        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.addrLimit.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.addrLimit.addressLimitInfo.overLimitAction = MODULE_MsgParseInt(currStr, &parseStatus); /* action */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.msg.addrLimit.addressLimitInfo.macLearningLimit = 0U;
            if(ETHSWT_SECURITY_ACTION_DISABLED == aCtx->ctx.msg.addrLimit.addressLimitInfo.overLimitAction){
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
            } else  {
                if ((remStr == NULL) || (remStrLen == 0)) {
                    goto done;
                }
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((remStr != NULL) || (remStrLen != 0)) {
                    goto done;
                }
                aCtx->ctx.msg.addrLimit.addressLimitInfo.macLearningLimit = MODULE_MsgParseInt(currStr, &parseStatus); /* limit */
                if(BCM_ERR_OK != parseStatus) {
                    goto done;
                }
            }
            aCtx->ctx.id = ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_SET;
            retVal = BCM_ERR_OK;

        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch ARL Sticky context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_SWTArlStickyCtxInt(char          *aStr,
                                          uint32_t      aStrLen,
                                          ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.stickyMAC.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.id = ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_GET;
            retVal = BCM_ERR_OK;

        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.stickyMAC.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            aCtx->ctx.msg.stickyMAC.stickyMACAction = MODULE_MsgParseInt(currStr, &parseStatus); /* action */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.id = ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_SET;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch ARL Move detect context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_SWTArlMoveDetectCtxInt(char          *aStr,
                                              uint32_t      aStrLen,
                                              ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.msg.stationMove.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.id = ETHSWT_EXTCMDID_STATION_MOVE_DETECT_GET;
            retVal = BCM_ERR_OK;
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            aCtx->ctx.msg.stationMove.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            aCtx->ctx.msg.stationMove.stationMoveAction = MODULE_MsgParseInt(currStr, &parseStatus); /* action */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            aCtx->ctx.id = ETHSWT_EXTCMDID_STATION_MOVE_DETECT_SET;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief Prepare Switch ARL Total Limit context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_SWTArlTotalLimitCtxInt(char          *aStr,
                                              uint32_t      aStrLen,
                                              ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        if (!strncmp(aStr,"get", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_GET;
            retVal = BCM_ERR_OK;
        } else if (!strncmp(aStr,"set", 3)) {
            MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }

            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }

            aCtx->ctx.msg.totalAddressLimit.totalMACLearningLimit =
                            MODULE_MsgParseInt(currStr, &parseStatus); /* limit */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_SET;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}
#endif /* ENABLE_ETHSWT_SECURITY */

/**
    @brief Prepare Switch Helper context

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTHelperPrepCtx(char          *aStr,
                                uint32_t      *aStrLen,
                                ETHSWT_SWTHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
        /* skip the first string which is checked in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* switch */
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((currStr != NULL) && (currStrLen > 1UL)) {
                if(!strncmp(currStr, "admin_mode", 10)) {
                    retVal = ETHSWT_SWTPortAdminModePrepCtxInt(remStr, remStrLen, aCtx);
#ifdef ENABLE_ETHSWT_SECURITY
                } else if (!strncmp(currStr, "hop_detect_vlan", 10)) {
                    retVal = ETHSWT_SWTVlanHopCtrlCtxInt(remStr, remStrLen, aCtx);
                } else if (!strncmp(currStr, "port_limit_arl", 10)) {
                    retVal = ETHSWT_SWTArlPortLimitCtxInt(remStr, remStrLen, aCtx);
                } else if (!strncmp(currStr, "sticky_arl", 6)) {
                    retVal = ETHSWT_SWTArlStickyCtxInt(remStr, remStrLen, aCtx);
                } else if (!strncmp(currStr, "move_detect_arl", 11)) {
                    retVal = ETHSWT_SWTArlMoveDetectCtxInt(remStr, remStrLen, aCtx);
                } else if (!strncmp(currStr, "total_limit_arl", 11)) {
                    retVal = ETHSWT_SWTArlTotalLimitCtxInt(remStr, remStrLen, aCtx);
#endif /* ENABLE_ETHSWT_SECURITY */
                } else if (!strncmp(currStr, "port", 4)) {
                    retVal = ETHSWT_SWTPortInfoPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "admin_mode", 10)) {
                    retVal = ETHSWT_SWTPortAdminModePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "speed", 5)){
                    retVal = ETHSWT_SWTPortGetSpeedPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "master_slave", 12)) {
                    retVal = ETHSWT_SWTPortMasterSlavePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "phy_lb_mode", 11)) {
                    retVal = ETHSWT_SWTPortPhyLbModePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "jumbo_frame", 11)) {
                    retVal = ETHSWT_SWTPortJumboFramePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "tc10", 4)) {
                    retVal = ETHSWT_SWTPortTC10PrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "link", 4)){
                    retVal = ETHSWT_SWTPortLinkSQIPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "age_time", 8)){
                    retVal = ETHSWT_SWTAgeTimePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "dumbfwd", 7)){
                    retVal = ETHSWT_SWTDumbFwdPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "brcmhdr", 7)){
                    retVal = ETHSWT_SWTBRCMHdrPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "mgmtmode", 7)){
                    retVal = ETHSWT_SWTMgmtModePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "read", 4)) {
                    retVal = ETHSWT_SWTReadPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "write", 5)) {
                    retVal = ETHSWT_SWTWritePrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "pvidset", 7)) {
                    retVal = ETHSWT_SWTPvidPrepCtxInt(remStr, remStrLen, aCtx);
                } else if(!strncmp(currStr, "ifilter", 7)) {
                    retVal = ETHSWT_SWTiFilterPrepCtxInt(remStr, remStrLen, aCtx);
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            }
        }
    }
    return retVal;
}

/** @brief Process Switch request string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTHelperProcess(BCM_CmdType   *aMsg,
                                       char          *aStr,
                                       uint32_t      *aStrLen,
                                       uint8_t       *aInOut,
                                       uint32_t       aInputLen,
                                       uint32_t      *aOutLen,
                                       uint32_t       aMaxLength,
                                       int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_SWTHelperCtx.modCtx.substate) {
        retVal = ETHSWT_SWTHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_SWTHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_SWTHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_SWTHelperCtx.ctx.id) {
        case ETHSWT_SWTHOSTCMD_PORTGETINFO:
            retVal = ETHSWT_SWTPortInfoHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTSETADMINMODE:
            retVal = ETHSWT_SWTSetAdminModeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETADMINMODE:
            retVal = ETHSWT_SWTGetAdminModeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETPORTSPEED:
            retVal = ETHSWT_SWTGetPortSpeedHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTSETMASTERSLAVE:
            retVal = ETHSWT_SWTSetMasterSlaveHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETMASTERSLAVE:
            retVal = ETHSWT_SWTGetMasterSlaveHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTSETPHYLBMODE:
            retVal = ETHSWT_SWTSetPhyLbModeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETPHYLBMODE:
            retVal = ETHSWT_SWTGetPhyLbModeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTSETJUMBOFRAME:
            retVal = ETHSWT_SWTSetJumboFrameHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETJUMBOFRAME:
            retVal = ETHSWT_SWTGetJumboFrameHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPMODE:
            retVal = ETHSWT_SWTGetTC10WakeUpModeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETTC10WAKEUPREASON:
            retVal = ETHSWT_SWTGetTC10WakeUpReasonHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETLINKSQI:
            retVal = ETHSWT_SWTGetLinkSQIHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTGETLINKSQIPORT:
            retVal = ETHSWT_SWTGetLinkSQIPortHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_PORTSETPVID :
            retVal = ETHSWT_SWTSetPvidHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRSETAGETIME:
            retVal = ETHSWT_SWTCtrlrSetAgeTimeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRGETAGETIME:
            retVal = ETHSWT_SWTCtrlrGetAgeTimeHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRSETDUMBFWD:
            retVal = ETHSWT_SWTCtrlrSetDumpFwdHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRGETDUMBFWD:
            retVal = ETHSWT_SWTCtrlrGetDumbFwdHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRSETBRCMHDR:
            retVal = ETHSWT_SWTCtrlrSetBRCMHdrHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRGETBRCMHDR:
            retVal = ETHSWT_SWTCtrlrGetBRCMHdrHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRSETMGMT:
            retVal = ETHSWT_SWTCtrlrSetMgmtHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRGETMGMT:
            retVal = ETHSWT_SWTCtrlrGetMgmtHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRSETIFILTER:
            retVal = ETHSWT_SWTCtrlrSetIfilterHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRGETIFILTER:
            retVal = ETHSWT_SWTCtrlrGetIFilterHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRREAD:
            retVal = ETHSWT_SWTCtrlrReadHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_SWTHOSTCMD_CTRLRWRITE:
            retVal = ETHSWT_SWTCtrlrWriteHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTHelperCtx);
            break;
#ifdef ENABLE_ETHSWT_SECURITY
        case ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_SET:
            retVal = ETHSWT_SWTVlanSetHopHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_VLAN_HOPPING_DETECTION_GET:
            retVal = ETHSWT_SWTVlanGetHopHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_SET:
            retVal = ETHSWT_SWTArlSetPortLimitHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_PORT_ADDRESS_LIMITING_GET:
            retVal = ETHSWT_SWTArlGetPortLimitHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_SET:
            retVal = ETHSWT_SWTArlSetStickyHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_STICKY_MAC_ADDRESS_GET:
            retVal = ETHSWT_SWTArlGetStickyHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_STATION_MOVE_DETECT_SET:
            retVal = ETHSWT_SWTArlSetMvDetHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_STATION_MOVE_DETECT_GET:
            retVal = ETHSWT_SWTArlGetMvDetHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_SET:
            retVal = ETHSWT_SWTArlSetTotalLimitHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
        case ETHSWT_EXTCMDID_TOTAL_ADDRESS_LIMIT_GET:
            retVal = ETHSWT_SWTArlGetTotalLimitHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_SWTHelperCtx);
            break;
#endif /* ENABLE_ETHSWT_SECURITY */
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}

/**
    @brief Prepare Switch Debug Helper context

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_SWTDbgHelperPrepCtx(char          *aStr,
                                   uint32_t      *aStrLen,
                                   ETHSWT_SWTDbgHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
        /* skip the first string which is checked in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* switch */
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if (!strncmp(currStr, "mibs", 4)) {
                if ((remStr != NULL) && (remStrLen != 0)) {
                    currStr = remStr;
                    currStrLen = remStrLen;
                    aCtx->ctx.msg.mib.port = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
                    if(BCM_ERR_OK == parseStatus) {
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        if ((remStr != NULL) && (remStrLen != 0)){
                            currStr = remStr;
                            currStrLen = remStrLen;
                            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                            if ((remStr == NULL) && (remStrLen == 0)){
                                if (!strncmp(currStr, "clear", 5)) {
                                    aCtx->ctx.id = ETHSWT_DEBUGCMDID_MIBS_CLEAR;
                                    retVal = BCM_ERR_OK;
                                }
                            }
                        } else {
                            aCtx->ctx.id = ETHSWT_DEBUGCMDID_MIBS;
                            retVal = BCM_ERR_OK;
                        }
                    }
                }
            }
        }
    }

    return retVal;
}

/** @brief Process Switch request string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTDbgHelperProcess(BCM_CmdType   *aMsg,
                                          char          *aStr,
                                          uint32_t      *aStrLen,
                                          uint8_t       *aInOut,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_SWTDbgHelperCtx.modCtx.substate) {
        retVal = ETHSWT_SWTDbgHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_SWTDbgHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_SWTDbgHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_SWTDbgHelperCtx.ctx.id) {
        case ETHSWT_DEBUGCMDID_MIBS_CLEAR:
            retVal = ETHSWT_SWTDbgClearPortMibsHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTDbgHelperCtx);
            break;
        case ETHSWT_DEBUGCMDID_MIBS:
            retVal = ETHSWT_SWTDbgGetPortMibsHelperHdlr(aMsg, aInOut, aInputLen,
                                              aOutLen, aMaxLength, aResponse,
                                              &ETHSWT_SWTDbgHelperCtx);
            break;
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}

/** @brief Switch Print Helper

    Print Switch Responses

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_SWTPrintHelper(BCM_CmdType    aCmd,
                                     uint8_t *aMsg, uint32_t aSize)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    uint8_t notificationId;
    ETHSWT_ExtMsgUnionType respMsg;

    if (NULL != aMsg) {
        if (0UL != (aCmd & BCM_CMD_ASYNC_MASK)) {
            notificationId = BCM_GET_CMDID(aCmd);
            BCM_MemCpy(respMsg.data, aMsg, aSize);

            if(ETHSWT_EXTASYNCEVENT_PORT_LINK_INFO == notificationId) {
                if (aSize == sizeof(ETHSWT_ExtPortLinkInfoType)) {
                    (void)MODULE_HostHelperLog("%s: Interface:%u Status:%s ChangeCount:%u\n",
                            __func__,
                            CPU_LEToNative32(respMsg.portLinkInfo.port),
                            (respMsg.portLinkInfo.linkState ==
                            ETHXCVR_LINKSTATE_ACTIVE) ? "Active" : "Down",
                            CPU_LEToNative32(respMsg.portLinkInfo.portStats.linkStateChangeCount));
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

/** @brief Ext Setup function

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ExtHostContextSetup(ETHSWT_ExtHostContextType *aContext, ETHSWT_ExtCmdIdType aCmdID,
                                   const ETHSWT_ExtMsgUnionType *aMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Ext Process function

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ExtHostContextProcess(ETHSWT_ExtHostContextType *aContext, int32_t aResponse,
                                     BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                     BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Debug Setup function

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugHostContextSetup(ETHSWT_DebugHostContextType *aContext, ETHSWT_DebugCmdIdType aCmdID,
                                     const ETHSWT_DebugMsgUnionType *aMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/** @brief Debug Process function

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_DebugHostContextProcess(ETHSWT_DebugHostContextType *aContext, int32_t aResponse,
                                       BCM_CmdType aInMsgID, const uint8_t *aInMsgPayload,
                                       BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @brief Switch Debug Host Helper

    @trace #BRCM_SWARCH_ETHSWT_SWTDEBUGHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_SWTDebugHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_DBG_ID,
    .helpstr = ETHSWT_SWTDbgHelpCmds,
    .context = &ETHSWT_SWTDbgHelperCtx.modCtx,
    .process = ETHSWT_SWTDbgHelperProcess,
};

/**
    @brief Switch Host Helper

    @trace #BRCM_SWARCH_ETHSWT_SWTHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_SWTHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_SWT_ID,
    .helpstr = ETHSWT_SWTHelpCmds,
    .context = &ETHSWT_SWTHelperCtx.modCtx,
    .process = ETHSWT_SWTHelperProcess,
    .print   = ETHSWT_SWTPrintHelper,
};
/** @} */
