/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_ethswt_arl_host_impl ARL Host Helpers Design
    @ingroup grp_ethernet_abstract

    @addtogroup grp_ethswt_arl_host_impl
    @{

    @file ethswt_arl_host.c

    @brief Ethernet ARL Command Helper

    @version 0.1 Initial version
*/
#include <stdio.h>
#include <string.h>
#include <bcm_comp.h>
#include <cpu_utils.h>
#include <ethernet_swt_arl.h>

/**
    @name Ethernet switch ARL Helper Design ID's
    @{
    @brief Ethernet switch ARL Helper Design ID's
*/
#define BRCM_SWDSGN_ETHSWT_ARL_HELPER_CTX_GLOBAL     (0xC001U) /**< @brief #ETHSWT_ARLHelperCtx                */
#define BRCM_SWDSGN_ETHSWT_ARLHELPCMDS_GLOBAL        (0xC002U) /**< @brief #ETHSWT_ARLHelpCmds                 */
#define BRCM_SWDSGN_ETHSWT_ARL_HELPERPREP_CTX_PROC   (0xC003U) /**< @brief #ETHSWT_ARLHelperPrepCtx            */
#define BRCM_SWDSGN_ETHSWT_ARL_ADD_CTXINT_PROC       (0xC004U) /**< @brief #ETHSWT_ARLAddCtxInt                */
#define BRCM_SWDSGN_ETHSWT_ARL_ADD_HELPER_HDLR_PROC  (0xC005U) /**< @brief #ETHSWT_ARLAddHelperHdlr            */
#define BRCM_SWDSGN_ETHSWT_ARL_DEL_CTXINT_PROC       (0xC006U) /**< @brief #ETHSWT_ARLDelCtxInt                */
#define BRCM_SWDSGN_ETHSWT_ARL_DEL_HELPER_HDLR_PROC  (0xC007U) /**< @brief #ETHSWT_ARLDelHelperHdlr            */
#define BRCM_SWDSGN_ETHSWT_ARL_ARLSHOWCTX_PROC       (0xC008U) /**< @brief #ETHSWT_ARLShowCtxInt               */
#define BRCM_SWDSGN_ETHSWT_ARL_SHOWHELPER_HDLR_PROC  (0xC009U) /**< @brief #ETHSWT_ARLShowHelperHdlr           */
#define BRCM_SWDSGN_ETHSWT_ARL_HELPERPROCESS_PROC    (0xC00AU) /**< @brief #ETHSWT_ARLHelperProcess            */
#define BRCM_SWDSGN_ETHSWT_ARLHELPER_GLOBAL          (0xC00BU) /**< @brief #ETHSWT_ARLHelper                   */
#define BRCM_SWDSGN_ETHSWT_ARLHELPERCTX_TYPE         (0xC00CU) /**< @brief #ETHSWT_ARLHelperCtxType */
/** @} */

/**
    @brief ARL Helper Module Context Type

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
typedef struct sETHSWT_ARLHelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context     */
    ETHSWT_ARLHostContextType ctx;    /**< @brief ARL Host context */
    ETHSWT_ARLEntryType ARLEntries[ETHSWT_ARL_HOST_MAX_ENTRIES];  /**< @brief ARL Entries captured on show */
    uint32_t idx;                                /**< @brief Index to track the entries   */
} ETHSWT_ARLHelperCtxType;

/**
    @brief ARL Helper Module Context

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
ETHSWT_ARLHelperCtxType ETHSWT_ARLHelperCtx;

/**
    @brief ARL Supported commands

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
static const char ETHSWT_ARLHelpCmds[] =
"add <mac address(xx:xx:xx:xx:xx:xx)> <vlan> <port_mask>\n"
"del <mac address(xx:xx:xx:xx:xx:xx)> <vlan>\n"
"show\n"
;

/**
    @brief Prepare ARL Add context

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_ARLAddCtxInt(char          *aStr,
                                     uint32_t      aStrLen,
                                     ETHSWT_ARLHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    char macStr[18];
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, aStr, sizeof(macStr));
        macStr[17]='\0';
        parseStatus = MODULE_ConvertStrToMac(macStr, &aCtx->ctx.msg.arlEntry.macAddr[0]);
        if(BCM_ERR_OK == parseStatus) {
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.arlEntry.vlanID = MODULE_MsgParseInt(currStr, &parseStatus); /* vlan */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

            aCtx->ctx.msg.arlEntry.portMask = MODULE_MsgParseInt(currStr, &parseStatus); /* port */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_ARLCMDID_ADD;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief ARL Add Helper handler

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ARLAddHelperHdlr(BCM_CmdType    *aMsg,
                                  uint8_t       *aBuff,
                                  uint32_t       aInputLen,
                                  uint32_t      *aOutLen,
                                  uint32_t       aMaxLength,
                                  int32_t        aResponse,
                                  ETHSWT_ARLHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ARLMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.arlEntry.vlanID = CPU_NativeToLE16(aCtx->ctx.msg.arlEntry.vlanID);
            cmdMsg.arlEntry.portMask = CPU_NativeToLE32(aCtx->ctx.msg.arlEntry.portMask);
            memcpy(&cmdMsg.arlEntry.macAddr[0], &aCtx->ctx.msg.arlEntry.macAddr[0], 6UL);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_ADD);
            *aOutLen = sizeof(ETHSWT_ARLEntryType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            memcpy(aBuff, &cmdMsg.arlEntry, sizeof(ETHSWT_ARLEntryType));
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to add ARL\n");
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ARLEntryType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare ARL Delete context

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_ARLDelCtxInt(char          *aStr,
                                      uint32_t      aStrLen,
                                      ETHSWT_ARLHelperCtxType *aCtx)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    char macStr[18];
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if((NULL != aStr) && (0UL != aStrLen)) {
        MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, aStr, sizeof(macStr));  /* Mac */
        macStr[17]='\0';
        parseStatus = MODULE_ConvertStrToMac(macStr, &aCtx->ctx.msg.arlEntry.macAddr[0]);
        if(BCM_ERR_OK == parseStatus) {
            if ((remStr == NULL) || (remStrLen == 0)) {
                goto done;
            }
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            aCtx->ctx.msg.arlEntry.vlanID = MODULE_MsgParseInt(currStr, &parseStatus); /* vlan */
            if(BCM_ERR_OK != parseStatus) {
                goto done;
            }

            if ((remStr != NULL) || (remStrLen != 0)) {
                goto done;
            }
            aCtx->ctx.id = ETHSWT_ARLCMDID_DELETE;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

/**
    @brief ARL Delete Helper handler

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ARLDelHelperHdlr(BCM_CmdType    *aMsg,
                                      uint8_t       *aBuff,
                                      uint32_t       aInputLen,
                                      uint32_t      *aOutLen,
                                      uint32_t       aMaxLength,
                                      int32_t        aResponse,
                                      ETHSWT_ARLHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ARLMsgUnionType cmdMsg;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            cmdMsg.arlEntry.vlanID = CPU_NativeToLE16(aCtx->ctx.msg.arlEntry.vlanID);
            memcpy(&cmdMsg.arlEntry.macAddr[0], &aCtx->ctx.msg.arlEntry.macAddr[0], 6UL);
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_DELETE);
            *aOutLen = sizeof(ETHSWT_ARLEntryType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            memcpy(aBuff, &cmdMsg.arlEntry, sizeof(ETHSWT_ARLEntryType));
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to delete ARL entry, ret=%d\n",
                                                          aResponse);
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ARLEntryType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            }
        default:
            break;
    }

    return retVal;
}

/**
    @brief Prepare ARL Show context

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
 static int32_t ETHSWT_ARLShowCtxInt(char          *aStr,
                                      uint32_t      aStrLen,
                                      ETHSWT_ARLHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if ((aStr == NULL) && (aStrLen == 0)) {
        aCtx->ctx.id = ETHSWT_ARLCMDID_SNAPSHOT;
        retVal = BCM_ERR_OK;
    }

    return retVal;
}

/**
    @brief Show ARL Helper handler

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ARLShowHelperHdlr(BCM_CmdType    *aMsg,
                                          uint8_t       *aBuff,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse,
                                          ETHSWT_ARLHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;
    ETHSWT_ARLMsgUnionType msgUnion;
    uint32_t count;
    uint32_t i;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_SNAPSHOT);
            *aOutLen = sizeof(ETHSWT_ARLListType);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to show ARL\n");
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ARLListType))) {
                (void)MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_UNKNOWN;
            } else {
                memcpy(&msgUnion.arlList, aBuff, sizeof(ETHSWT_ARLListType));
                aCtx->ctx.msg.arlList.num = CPU_LEToNative32(msgUnion.arlList.num);
                memset(aCtx->ARLEntries, 0UL, (sizeof(ETHSWT_ARLEntryType) * (ETHSWT_ARL_HOST_MAX_ENTRIES)));
                aCtx->idx = 0UL;
                msgUnion.arlList.num = 0UL;
                *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_GET);
                *aOutLen = sizeof(ETHSWT_ARLListType);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                memcpy(aBuff, &msgUnion.arlList, sizeof(ETHSWT_ARLListType));
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to show ARL\n");
                retVal = BCM_ERR_UNKNOWN;
            } else if (aInputLen != (sizeof(ETHSWT_ARLListType))) {
                MODULE_HostHelperLog("%s len:0x%x\n", __func__, aInputLen);
                retVal = BCM_ERR_DATA_INTEG;
            } else {
                memcpy(&msgUnion.arlList, aBuff, sizeof(ETHSWT_ARLListType));
                count = CPU_LEToNative32(msgUnion.arlList.num);
                for (i = 0; i < count; i++) {
                    memcpy(&aCtx->ARLEntries[aCtx->idx].macAddr[0], &msgUnion.arlList.entries[i].macAddr[0], 6UL);
                    aCtx->ARLEntries[aCtx->idx].vlanID = CPU_LEToNative16(msgUnion.arlList.entries[i].vlanID);
                    aCtx->ARLEntries[aCtx->idx].portMask = CPU_LEToNative32(msgUnion.arlList.entries[i].portMask);
                    aCtx->ARLEntries[aCtx->idx].reserved = CPU_LEToNative16(msgUnion.arlList.entries[i].reserved);
                    aCtx->idx++;
                }
                if(aCtx->ctx.msg.arlList.num <= aCtx->idx) {
                    (void)MODULE_HostHelperLog("\tMAC\t\tVLAN\tPortMask\n");
                    for (i = 0; i < aCtx->ctx.msg.arlList.num; i++) {
                        (void)MODULE_HostHelperLog("%02x:%02x:%02x:%02x:%02x:%02x\t",
                                aCtx->ARLEntries[i].macAddr[0], aCtx->ARLEntries[i].macAddr[1],
                                aCtx->ARLEntries[i].macAddr[2], aCtx->ARLEntries[i].macAddr[3],
                                aCtx->ARLEntries[i].macAddr[4], aCtx->ARLEntries[i].macAddr[5]);
                        (void)MODULE_HostHelperLog("%u\t", aCtx->ARLEntries[i].vlanID);
                        (void)MODULE_HostHelperLog("0x%x\n", aCtx->ARLEntries[i].portMask);
                    }
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                } else {
                    msgUnion.arlList.num = CPU_NativeToLE32(aCtx->idx);
                    *aMsg = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_ARL_ID, ETHSWT_ARLCMDID_GET);
                    *aOutLen = sizeof(ETHSWT_ARLListType);
                    aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                    memcpy(aBuff, &msgUnion.arlList, sizeof(ETHSWT_ARLListType));
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
    @brief Prepare ARL Helper context

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
int32_t ETHSWT_ARLHelperPrepCtx(char          *aStr,
                                  uint32_t      *aStrLen,
                                  ETHSWT_ARLHelperCtxType *aCtx)
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
        /* skip the first 2 strings which are checked in the above layer */
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* switch */
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* arl */
            if ((remStr != NULL) && (remStrLen > 1UL)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if ((currStr != NULL) && (currStrLen > 1UL)) {
                    if (!strncmp(currStr, "add", 3)) {
                        retVal = ETHSWT_ARLAddCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "del", 3)){
                        retVal = ETHSWT_ARLDelCtxInt(remStr, remStrLen, aCtx);
                    } else if (!strncmp(currStr, "show", 4)) {
                        retVal = ETHSWT_ARLShowCtxInt(remStr, remStrLen, aCtx);
                    } else {
                        retVal = BCM_ERR_INVAL_PARAMS;
                    }
                }
            }
        }
    }

    return retVal;
}

/** @brief Process ARL request string or response byte array

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT

    @code{.unparsed}
    @endcode
*/
static int32_t ETHSWT_ARLHelperProcess(BCM_CmdType    *aMsg,
                                          char          *aStr,
                                          uint32_t      *aStrLen,
                                          uint8_t       *aInOut,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == ETHSWT_ARLHelperCtx.modCtx.substate) {
        retVal = ETHSWT_ARLHelperPrepCtx(aStr, aStrLen,
                                          &ETHSWT_ARLHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            ETHSWT_ARLHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(ETHSWT_ARLHelperCtx.ctx.id) {
        case ETHSWT_ARLCMDID_ADD:
            retVal = ETHSWT_ARLAddHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_ARLHelperCtx);
            break;
        case ETHSWT_ARLCMDID_DELETE:
            retVal = ETHSWT_ARLDelHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_ARLHelperCtx);
            break;
        case ETHSWT_ARLCMDID_SNAPSHOT:
            retVal = ETHSWT_ARLShowHelperHdlr(aMsg, aInOut, aInputLen,
                                             aOutLen, aMaxLength, aResponse,
                                             &ETHSWT_ARLHelperCtx);
            break;
        default:
            if(BCM_ERR_OK == retVal) {
                retVal = BCM_ERR_UNKNOWN;
            }
            break;
    }

    return retVal;
}

/**
    @brief Switch ARL Helper

    @trace #BRCM_SWARCH_ETHSWT_ARLHELPER_GLOBAL
    @trace #BRCM_SWREQ_ETHSWT
*/
const MODULE_MsgConverterType ETHSWT_ARLHelper = {
    .groupId = BCM_GROUPID_ETHSRV,
    .compId  = BCM_ARL_ID,
    .helpstr = ETHSWT_ARLHelpCmds,
    .context = &ETHSWT_ARLHelperCtx.modCtx,
    .process = ETHSWT_ARLHelperProcess,
};
/** @} */
