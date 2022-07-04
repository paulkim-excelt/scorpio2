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
    @defgroup grp_crypto_secy_host_impl SecY Host Design
    @ingroup grp_crypto_abstract

    @addtogroup grp_crypto_secy_host_impl
    @{

    @file crypto_secy_host.c
    @brief Crypto SecY Host design

    This source file contains the implementation of functions for crypto SecY
    Host APIs for commands

    @version 1.0 Initial version
*/

#include <crypto_module.h>
#include <crypto_secy.h>
#include <bcm_utils.h>
#include <cpu_utils.h>
#include <module_osil.h>
#include <module_msg.h>

/**
    @name Component Design IDs
    @{
    @brief Design IDs for Component
*/
#define BRCM_SWDSGN_SECY_HOST_CONTEXT_SETUP_PROC     (0xB400U)   /**< @brief #SECY_HostContextSetup    */
#define BRCM_SWDSGN_SECY_HOST_CONTEXT_PROCESS_PROC   (0xB401U)   /**< @brief #SECY_HostContextProcess  */
/** @} */

typedef struct sSECY_HostHelperCtxType {
    MODULE_MsgContextType modCtx;                /**< @brief Module's Context             */
    SECY_HostContextType ctx;
} SECY_HostHelperCtxType;

/**
    @brief Crypto SecY Helper Module Context

    @trace #BRCM_SWARCH_SECY_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_SECY
*/
static SECY_HostHelperCtxType SECY_HostCtx;

/**
    @brief Crypto SecY Helper Supported commands

    @trace #BRCM_SWARCH_SECY_HOST_HELPER_GLOBAL
    @trace #BRCM_SWREQ_SECY
*/
/* TODO: Below arguments are not valid. To be updated */
static const char SECY_HelpCmds[] =
"init <port> <chkKay:0/1> <enQTagParse:0/1>\n"
"get_cipher_cap <port> <aes128/aes256> <xpn:0/1>\n"
"add_cprule0 <port> <macStart> <macEnd> <ethType> <ruleMask> <1:egress/2:ingress>\n"
"add_cprule1 <port> <macDA> <macSA> <frameData> <sectag> <vlantag> <macDAMask> <macSAMask> <frameDataMask> <1:egress/2:ingress>\n"
"remove_cprule <port> <rule_hdl>\n"
"secy_create <port> <xpn:0/1> <sci:0/1> <preSecTagAuthStart> <preSecTagAuthLen> <secTagOffset>\n"
"set_cipher_suite <secyHdl> <aes128/aes256> <xpn:0/1> <confOffset>\n"
"set_frame_protect <secyHdl> <0:disable/1:enable>\n"
"set_validate_frame <secyHdl> <0:DISABLED/1:CHECK/2:STRICT/3:NULL>\n"
"set_replay_protect <secyHdl> <0:disable/1:enable> <window>\n"
"add_lookuprule <secyHdl> <macDA> <macSA> <frameData> <sectag> <vlantag> <macDAMask> <macSAMask> <frameDataMask> <1:egress/2:ingress>\n"
"remove_lookuprule <rule_id>\n"
"txsc_create <secyHdl> <macaddr> <port>\n"
"rxsc_create <secyHdl> <macaddr> <port>\n"
"txsa_create <secyHdl> <pn> <an> <ssci> <conf> <macaddr> <port> <sak> <salt> <keyId>\n"
"rxsa_create <secyHdl> <pn> <an> <ssci> <macaddr> <port> <sak> <salt> <keyId>\n"
"sa_set_pn_thrld <saHdl> <pn>\n"
"sa_get_next_pn <saHdl>\n"
"sa_get_status <saHdl>\n"
"sa_enable <port> <saHdl>\n"
"sa_disable <port> <saHdl>\n"
"sa_get_tx_stats <saHdl>\n"
"sa_delete <port> <saHdl>\n"
"txsc_get_stats <secyHdl> <mac> <port>\n"
"rxsc_get_stats <secyHdl> <mac> <port>\n"
"txsc_del <secyHdl> <mac> <port>\n"
"rxsc_del <secyHdl> <mac> <port>\n"
"get_stats <secyHdl>\n"
"secy_delete <port> <secyHdl>\n"
"deinit <port>\n"
;

/** @} */

/**
    @addtogroup grp_crypto_secy_ifc
    @{
*/

uint64_t SECY_HexStrToInt64(char * aStr)
{
    int32_t  parseStatus = 0;
    uint64_t data;

    data = MODULE_MsgParseLongInt(aStr, &parseStatus);
    if (BCM_ERR_OK != parseStatus) {
        data = 0;
        (void)MODULE_HostHelperLog("Parsing Error !! line:%d, string: %s \n", __LINE__, aStr);
    }

    return data;
}

uint8_t SECY_HexStrToInt8(char *aStr)
{
    uint32_t l, h;
    uint8_t str;

    str = aStr[0];
    h = ((str >= 'a' && str <= 'f') ? str - 'a' + 10 :
            (str >= 'A' && str <= 'F') ? str - 'A' + 10 : str - '0');
    str = aStr[1];
    l = ((str >= 'a' && str <= 'f') ? str - 'a' + 10 :
            (str >= 'A' && str <= 'F') ? str - 'A' + 10 : str - '0');

    return (h * 16) + l;
}


/**
    @code{.c}
    if aContext is NULL OR aMsgPayload is NULL
        ret = BCM_ERR_INVAL_PARAMS
    else
        aContext->state = BCM_STATE_READY
        aContext->subState = BCM_STATE_SUB_STATE_RESET
        aContext->id = aSecYID
        aContext->status = BCM_ERR_UNKNOWN
        aContext->msg = *aMsgPayload
        ret = BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SECY_HOST_CONTEXT_SETUP_PROC
    @trace #BRCM_SWREQ_SECY
*/
int32_t SECY_HostContextSetup(SECY_HostContextType *aContext, SECY_IdType aSecYID,
                                    const SECY_MsgUnionType *aMsgPayload)
{
    int32_t ret;

    if ((NULL == aContext) || (NULL == aMsgPayload)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else {
        aContext->state = BCM_STATE_READY;
        aContext->id = aSecYID;
        aContext->status = BCM_ERR_UNKNOWN;
        aContext->msg = *aMsgPayload;
        ret = BCM_ERR_OK;
    }

    return ret;
}

/**
    @code{.c}
    if (aReplyData is NULL) OR (aReplyDataLen is NULL) OR (aHandle is 0)
        OR (aInLen < SECY_MSG_MAX_SIZE)
        ret = BCM_ERR_INVAL_PARAMS
    else
        ret = MSGQ_RecvMsgv2(&SECY_Module.cmdQ, aHandle, &msg);
        if (ret is BUSY)
            DO Nothing
        else if (ret = OK)
            BCM_MemCpy(aReplyData, msg.u.data , aInLen)
            *aReplyDataLen = SECY_MSG_MAX_SIZE
            ret = msg.status
        else
            ret = BCM_ERR_UNKNOWN
            *aReplyDataLen = 0UL;
    return ret
    @endcode

    @trace #BRCM_SWARCH_SECY_HOST_CONTEXT_PROCESS_PROC
    @trace #BRCM_SWREQ_SECY
*/
    int32_t SECY_HostContextProcess(SECY_HostContextType *aContext, int32_t aResponse,
                                            BCM_CmdType aInMsgId, const uint8_t *aInMsgPayload,
                                            BCM_CmdType *aOutMsgId, uint8_t *aOutMsgPayload)
{
    int32_t ret;

    if ((NULL == aContext)
        || (NULL == aInMsgPayload)
        || (NULL == aOutMsgId)
        || (NULL == aOutMsgPayload)) {
        ret = BCM_ERR_INVAL_PARAMS;
    } else if (BCM_STATE_READY == aContext->state) {
        *aOutMsgId = aContext->id;
        BCM_MemCpy(aOutMsgPayload, aContext->msg.data, SECY_MSG_MAX_SIZE);
        aContext->state = BCM_STATE_RUN;
        ret = BCM_ERR_BUSY;
    } else if ((BCM_STATE_RUN == aContext->state) && (aContext->id == aInMsgId)) {
        BCM_MemCpy(aContext->msg.data, aInMsgPayload, SECY_MSG_MAX_SIZE);
        ret = BCM_ERR_OK;
    } else {
        ret = BCM_ERR_UNKNOWN;
    }

    return ret;
}

 static int32_t SECY_InitPrepCtxInt(char          *aStr,
                                          uint32_t      aStrLen,
                                          SECY_HostContextType *aCtx,
                                          uint32_t *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hwInit.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hwInit.cfg.checkKaY = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* checkKaY */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);

        secY.hwInit.cfg.enableQtagParse = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* enableQtagParse */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    *aOutLen = sizeof(SECY_HwInitMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_HW_INIT, &secY);
    }

    return retVal;
}

static int32_t SECY_GetcapPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           SECY_HostContextType *aCtx,
                                           uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char aes[20];
    uint32_t xpn;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.getCipher.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        strcpy(aes, currStr);
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        xpn = MODULE_MsgParseInt(currStr, &parseStatus); /* xpn */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            if (!strncmp(aes, "aes128", 6)) {
                if(0UL == xpn) {
                    secY.getCipher.cipher = CPU_NativeToLE64(SECY_CIPHER_GCM_AES_128);
                } else if (1UL == xpn) {
                    secY.getCipher.cipher = CPU_NativeToLE64(SECY_CIPHER_GCM_AES_XPN_128);
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            } else if (!strncmp(aes, "aes256", 6)) {
                if(0UL == xpn) {
                    secY.getCipher.cipher = CPU_NativeToLE64(SECY_CIPHER_GCM_AES_256);
                } else if (1UL == xpn) {
                    secY.getCipher.cipher = CPU_NativeToLE64(SECY_CIPHER_GCM_AES_XPN_256);
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    *aOutLen = sizeof(SECY_GetCipherMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_GET_CIPHER_CAP, &secY);
    }

    return retVal;
}

static int32_t SECY_AddCpRule0PrepCtxInt(char          *aStr,
                                         uint32_t      aStrLen,
                                         SECY_HostContextType *aCtx,
                                         uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.ruleOpt0.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt0.rule.macDAStart[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt0.rule.macDAStart[0]); /* macStart */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt0.rule.macDAEnd[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt0.rule.macDAEnd[0]); /* macEnd */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.ruleOpt0.rule.ethType =  CPU_NativeToLE16((uint16_t)MODULE_MsgParseInt(currStr, &parseStatus)); /* ethType */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.ruleOpt0.rule.ruleMask =  CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* ruleMask */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        if (NULL == remStr) {
            secY.ruleOpt0.rule.dir = SECY_RULE_DIR_INGRESS;
        } else {
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            secY.ruleOpt0.rule.dir =  CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* dir */
            if (BCM_ERR_OK != parseStatus) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    *aOutLen = sizeof(SECY_RuleOpt0MsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_ADD_CP_RULE_OPT0, &secY);
    }

    return retVal;
}

static int32_t SECY_AddCpRule1PrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;
    uint64_t frameData;
    uint64_t frameDataMask;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.ruleOpt1.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt1.rule.macDA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt1.rule.macDA[0]);/* macDA */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt1.rule.macSA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt1.rule.macSA[0]);/* macSA */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        frameData = SECY_HexStrToInt64(currStr);                                    /* frameData */
        secY.ruleOpt1.rule.frameData[0UL] = (frameData >> 32) & 0xFFFFFFFF;
        secY.ruleOpt1.rule.frameData[1UL] = (frameData & 0xFFFFFFFF);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.ruleOpt1.rule.macSecTagged = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* sectag */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)
                                        || (1UL < CPU_LEToNative32(secY.ruleOpt1.rule.macSecTagged))) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.ruleOpt1.rule.vlanTagged = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* vlantag */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)
                                        || (1UL < CPU_LEToNative32(secY.ruleOpt1.rule.vlanTagged))) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt1.rule.matchMacDAMask[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt1.rule.matchMacDAMask[0]); /* macDAMask */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.ruleOpt1.rule.matchMacSAMask[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.ruleOpt1.rule.matchMacSAMask[0]); /* macSAMask */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        frameDataMask = SECY_HexStrToInt64(currStr);                                         /* frameDataMask */
        secY.ruleOpt1.rule.matchFrameDataMask[0UL] = (frameDataMask >> 32) & 0xFFFFFFFF;
        secY.ruleOpt1.rule.matchFrameDataMask[1UL] = (frameDataMask & 0xFFFFFFFF);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.ruleOpt1.rule.dir = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* dir */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    *aOutLen = sizeof(SECY_RuleOpt1MsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_ADD_CP_RULE_OPT1, &secY);
    }

    return retVal;
}

static int32_t SECY_RemoveCpRulePrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 SECY_HostContextType *aCtx,
                                                 uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hdl.hdl  = SECY_HexStrToInt64(aStr);                          /* rule_hdl */
        if((remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_REM_CP_RULE, &secY);
    }

    return retVal;
}

static int32_t SECY_CreateSecYPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.secYCreate.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.secYCreate.cfg.xpnEnable = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* xpn */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)
                                        || (1UL < CPU_LEToNative32(secY.secYCreate.cfg.xpnEnable))) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.secYCreate.cfg.includeSCI = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* sci */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_OK;
        }
    }

    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    secY.secYCreate.cfg.preSecTagAuthStart = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* tag start */

    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    secY.secYCreate.cfg.preSecTagAuthLen = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus));   /* tag len */

    currStr = remStr;
    currStrLen = remStrLen;
    MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
    secY.secYCreate.cfg.secTagOffset = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus));       /* tag offset */

    *aOutLen = sizeof(SECY_CreateMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_CREATE, &secY);
    }

    return retVal;
}

static int32_t SECY_SetCapPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           SECY_HostContextType *aCtx,
                                           uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = BCM_ERR_OK;
    int32_t retVal = BCM_ERR_OK;
    char aes[20];
    uint32_t xpn;
    SECY_MsgUnionType secY;


    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.setCipher.secYHdl = SECY_HexStrToInt64(aStr);  /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        strcpy(aes, currStr);
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        xpn = MODULE_MsgParseInt(currStr, &parseStatus); /* xpn */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            if (!strncmp(aes, "aes128", 6)) {
                if(0UL == xpn) {
                    secY.setCipher.cipher = CPU_NativeToLE64((SECY_CIPHER_GCM_AES_128));
                } else if (1UL == xpn) {
                    secY.setCipher.cipher = CPU_NativeToLE64((SECY_CIPHER_GCM_AES_XPN_128));
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            } else if (!strncmp(aes, "aes256", 6)) {
                if(0UL == xpn) {
                    secY.setCipher.cipher = CPU_NativeToLE64((SECY_CIPHER_GCM_AES_256));
                } else if (1UL == xpn) {
                    secY.setCipher.cipher = CPU_NativeToLE64((SECY_CIPHER_GCM_AES_XPN_256));
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            } else {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.setCipher.offset = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* confOffset */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    *aOutLen = sizeof(SECY_SetCipherMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SET_CIPHER_SUITE, &secY);
    }

    return retVal;
}

static int32_t SECY_SetFrameProtectPrepCtxInt(char          *aStr,
                                                    uint32_t      aStrLen,
                                                    SECY_HostContextType *aCtx,
                                                    uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = BCM_ERR_OK;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    memset(&(secY.debug), 0x00, sizeof(SECY_DebugMsgType));

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.debug.secYHdl = SECY_HexStrToInt64(aStr);  /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if((remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            secY.debug.protectEnable = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* enable */
            if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    *aOutLen = sizeof(SECY_DebugMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SET_PROTECT, &secY);
    }

    return retVal;
}

static int32_t SECY_SetFrameValidatePrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = BCM_ERR_OK;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    memset(&(secY.debug), 0x00, sizeof(SECY_DebugMsgType));

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.debug.secYHdl = SECY_HexStrToInt64(aStr);  /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if((remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            secY.debug.validate = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* enable */
            if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

   *aOutLen = sizeof(SECY_DebugMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SET_VALIDATE_FRAME, &secY);
    }

    return retVal;
}

static int32_t SECY_SetReplayProtectPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = BCM_ERR_OK;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    memset(&(secY.debug), 0x00, sizeof(SECY_DebugMsgType));

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.debug.secYHdl = SECY_HexStrToInt64(aStr);  /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if ((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        } else {
            secY.debug.replayProtectEnable = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* enable */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.debug.replayProtectWindow = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* window */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_DebugMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SET_REPLAY_PROTECT, &secY);
    }

    return retVal;
}

static int32_t SECY_AddLookupRulePrepCtxInt(char          *aStr,
                                                  uint32_t      aStrLen,
                                                  SECY_HostContextType *aCtx,
                                                  uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = BCM_ERR_OK;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;
    uint64_t frameData;
    uint64_t frameDataMask;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.scLookup.secYHdl = SECY_HexStrToInt64(aStr);                     /* secy_id */
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.macDA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.scLookup.rule.macDA[0]);/* macDA */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.macSA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.scLookup.rule.macSA[0]);/* macSA */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        frameData = SECY_HexStrToInt64(currStr);  /* frameData */
        secY.scLookup.rule.frameData[0UL] = (frameData >> 32) & 0xFFFFFFFF;
        secY.scLookup.rule.frameData[1UL] = (frameData & 0xFFFFFFFF);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.scLookup.rule.macSecTagged = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* sectag */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)
                                        || (1UL < CPU_LEToNative32(secY.scLookup.rule.macSecTagged))) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.scLookup.rule.vlanTagged = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* vlantag */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)
                                        || (1UL < CPU_LEToNative32(secY.scLookup.rule.vlanTagged))) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.matchMacDAMask[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.scLookup.rule.matchMacDAMask[0]); /* macDAMask */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.matchMacSAMask[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.scLookup.rule.matchMacSAMask[0]); /* macSAMask */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        frameDataMask = SECY_HexStrToInt64(currStr);                                         /* frameDataMask */
        secY.scLookup.rule.matchFrameDataMask[0UL] = (frameDataMask >> 32) & 0xFFFFFFFF;
        secY.scLookup.rule.matchFrameDataMask[1UL] = (frameDataMask & 0xFFFFFFFF);
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.scLookup.rule.dir = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* dir */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_LookupRuleMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_ADD_LOOKUP_RULE, &secY);
    }

    return retVal;
}

static int32_t SECY_RemoveLookupRulePrepCtxInt(char          *aStr,
                                                     uint32_t      aStrLen,
                                                     SECY_HostContextType *aCtx,
                                                     uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.hdl = SECY_HexStrToInt64(aStr); /* rule_id */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_REM_LOOKUP_RULE, &secY);
    }

    return retVal;
}

static int32_t SECY_AddTxscPrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            SECY_HostContextType *aCtx,
                                            uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.sc.secYHdl = SECY_HexStrToInt64(aStr);       /* secyHdl */
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, currStr, sizeof(macStr));
        macStr[17]='\0';
        parseStatus = MODULE_ConvertStrToMac(macStr, &secY.sc.sci.macAddr[0]);/* macaddr */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sc.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_SCMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_TXSC_CREATE, &secY);
    }

    return retVal;
}

static int32_t SECY_AddRxscPrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            SECY_HostContextType *aCtx,
                                            uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.sc.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.matchMacSAMask[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.sc.sci.macAddr[0]); /* macaddr */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sc.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_SCMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_RXSC_CREATE, &secY);
    }

    return retVal;
}

static int32_t SECY_CreateTxsaPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;
    uint32_t strIdx;
    uint32_t bufIdx;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.sa.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.pn = SECY_HexStrToInt64(currStr);   /* pn */
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.association = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* an */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.ssci = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* ssci */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.confidentiality = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* conf */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.sa.sci.macAddr[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.sa.sci.macAddr[0]);    /* mac */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.sak[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.salt[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.keyId[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }
    }

   *aOutLen = sizeof(SECY_SAMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_TXSA_CREATE, &secY);
    }

    return retVal;
}

static int32_t SECY_CreateRxsaPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;
    uint32_t strIdx;
    uint32_t bufIdx;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.sa.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.pn = SECY_HexStrToInt64(currStr);   /* pn */
        if((remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.association = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* an */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.ssci = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* ssci */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.sa.sci.macAddr[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.sa.sci.macAddr[0]);/* mac */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.sa.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.sak[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.salt[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        bufIdx = 0;
        for(strIdx = 2; strIdx < strlen(currStr); strIdx += 2) {
            secY.sa.sak.keyId[bufIdx++] = SECY_HexStrToInt8(&(currStr[strIdx]));
        }
    }

   *aOutLen = sizeof(SECY_SAMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_RXSA_CREATE, &secY);
    }

    return retVal;
}

static int32_t SECY_SetPntherPrepCtxInt(char          *aStr,
                                              uint32_t      aStrLen,
                                              SECY_HostContextType *aCtx,
                                              uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.pn.saHdl = SECY_HexStrToInt64(aStr); /* saHdl */

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.pn.pn = SECY_HexStrToInt64(currStr);   /* pn */
        if((remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_PNMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_SET_PN_THRLD, &secY);
    }

    return retVal;
}

static int32_t SECY_SetPnPrepCtxInt(char          *aStr,
                                          uint32_t      aStrLen,
                                          SECY_HostContextType *aCtx,
                                          uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.pn.saHdl = SECY_HexStrToInt64(aStr); /* saHdl */

        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.pn.pn = SECY_HexStrToInt64(currStr);   /* pn */
        if((remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_PNMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_SET_NEXT_PN , &secY);
    }

    return retVal;
}

static int32_t SECY_GetPnPrepCtxInt(char          *aStr,
                                          uint32_t      aStrLen,
                                          SECY_HostContextType *aCtx,
                                          uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.pn.saHdl = SECY_HexStrToInt64(aStr); /* saHdl */
    }

   *aOutLen = sizeof(SECY_PNMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_GET_NEXT_PN , &secY);
    }

    return retVal;
}

static int32_t SECY_GetStatusPrepCtxInt(char          *aStr,
                                              uint32_t      aStrLen,
                                              SECY_HostContextType *aCtx,
                                              uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.saStatus.saHdl = SECY_HexStrToInt64(aStr); /* saHdl */
    }

   *aOutLen = sizeof(SECY_SAStatusMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_GET_STATUS, &secY);
    }

    return retVal;
}

static int32_t SECY_EnablePrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           SECY_HostContextType *aCtx,
                                           uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;


    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hdl.hdl = SECY_HexStrToInt64(currStr);                             /* saHdl */
    }

    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

   *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_ENABLE, &secY);
    }

    return retVal;
}

static int32_t SECY_DisablePrepCtxInt(char          *aStr,
                                            uint32_t      aStrLen,
                                            SECY_HostContextType *aCtx,
                                            uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hdl.hdl = SECY_HexStrToInt64(currStr);                             /* saHdl */
    }

   *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_DISABLE, &secY);
    }

    return retVal;
}

static int32_t SECY_GetTxsaStatsPrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 SECY_HostContextType *aCtx,
                                                 uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.saStats.saHdl = SECY_HexStrToInt64(aStr); /* saHdl */
    }

   *aOutLen = sizeof(SECY_TxSAStatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_GET_TX_STATS, &secY);
    }

    return retVal;
}

static int32_t SECY_DeleteSaPrepCtxInt(char          *aStr,
                                       uint32_t      aStrLen,
                                       SECY_HostContextType *aCtx,
                                       uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hdl.hdl = SECY_HexStrToInt64(currStr);                             /* saHdl */
    }

   *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_SA_DELETE, &secY);
    }

    return retVal;
}

static int32_t SECY_GetTxscStatsPrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 SECY_HostContextType *aCtx,
                                                 uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.txScStats.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, currStr, sizeof(macStr));
        macStr[17]='\0';
        parseStatus = MODULE_ConvertStrToMac(macStr, &secY.txScStats.sci.macAddr[0]);/* mac */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.txScStats.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_TxSCStatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_TXSC_GET_STATS, &secY);
    }

    return retVal;
}

static int32_t SECY_GetRxscStatsPrepCtxInt(char          *aStr,
                                                 uint32_t      aStrLen,
                                                 SECY_HostContextType *aCtx,
                                                 uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.rxScStats.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        memset(macStr, 0x00, sizeof(macStr));
        memcpy(macStr, currStr, sizeof(macStr));
        macStr[17]='\0';
        parseStatus = MODULE_ConvertStrToMac(macStr, &secY.rxScStats.sci.macAddr[0]);/* mac */
        if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.rxScStats.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_RxSCStatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_RXSC_GET_STATS, &secY);
    }

    return retVal;
}

static int32_t SECY_RemoveTxscPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.rxScStats.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.macDA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.rxScStats.sci.macAddr[0]); /* mac */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.rxScStats.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_RxSCStatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_TXSC_DEL, &secY);
    }

    return retVal;
}

static int32_t SECY_RemoveRxscPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    char macStr[18];
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.rxScStats.secYHdl = SECY_HexStrToInt64(aStr); /* secyHdl */
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (!strcmp(currStr, "0")) {
            memset(&(secY.scLookup.rule.macDA[0]), 0x00, 6);
        } else {
            memset(macStr, 0x00, sizeof(macStr));
            memcpy(macStr, currStr, sizeof(macStr));
            macStr[17]='\0';
            parseStatus = MODULE_ConvertStrToMac(macStr, &secY.rxScStats.sci.macAddr[0]);/* mac */
            if((BCM_ERR_OK != parseStatus) || (remStr == NULL) || (remStrLen == 0)) {
                retVal = BCM_ERR_INVAL_PARAMS;
            }
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.rxScStats.sci.portNum = CPU_NativeToLE32(MODULE_MsgParseInt(currStr, &parseStatus)); /* port */
        if((BCM_ERR_OK != parseStatus) || (remStr != NULL) || (remStrLen != 0)) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_RxSCStatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_RXSC_DEL, &secY);
    }

    return retVal;
}

static int32_t SECY_GetStatsPrepCtxInt(char          *aStr,
                                             uint32_t      aStrLen,
                                             SECY_HostContextType *aCtx,
                                             uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.stats.secYHdl = SECY_HexStrToInt64(aStr); /* saHdl */
    }

   *aOutLen = sizeof(SECY_StatsMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_GET_STATS, &secY);
    }

    return retVal;
}

static int32_t SECY_DeleteSecyPrepCtxInt(char          *aStr,
                                               uint32_t      aStrLen,
                                               SECY_HostContextType *aCtx,
                                               uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr == NULL) || (remStrLen == 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hdl.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    if(BCM_ERR_OK == retVal) {
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        secY.hdl.hdl = SECY_HexStrToInt64(currStr);                             /* saHdl */
    }

   *aOutLen = sizeof(SECY_HdlMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_DELETE, &secY);
    }

    return retVal;
}

static int32_t SECY_DeinitPrepCtxInt(char          *aStr,
                                           uint32_t      aStrLen,
                                           SECY_HostContextType *aCtx,
                                           uint32_t      *aOutLen)
{
    char *remStr;
    uint32_t remStrLen;
    int32_t  parseStatus = 0;
    int32_t retVal = BCM_ERR_OK;
    SECY_MsgUnionType secY;

    MODULE_MsgSplitString(aStr, aStrLen, &remStr, &remStrLen);
    if ((remStr != NULL) || (remStrLen != 0)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }

    if(BCM_ERR_OK == retVal) {
        secY.hwDeinit.port = CPU_NativeToLE32(MODULE_MsgParseInt(aStr, &parseStatus)); /* port */
        if(BCM_ERR_OK != parseStatus) {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

   *aOutLen = sizeof(SECY_HwDeinitMsgType);

    if(BCM_ERR_OK == retVal) {
        retVal = SECY_HostContextSetup(aCtx, SECY_HW_DEINIT, &secY);
    }

    return retVal;
}

int32_t SECY_HelperPrepCtx(char          *aStr,
                                 uint32_t      *aStrLen,
                                 SECY_HostContextType *aCtx,
                                 uint32_t      *aOutLen)
{
    char *currStr;
    uint32_t currStrLen;
    char *remStr;
    uint32_t remStrLen;
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(NULL != aStr) {
        currStr = aStr;
        currStrLen = *aStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen); /* secy */
        if ((remStr != NULL) && (remStrLen > 1UL)) {
            currStr = remStr;
            currStrLen = remStrLen;
            MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
            if ((remStr != NULL) && (remStrLen > 1UL)) {
                if (!strncmp(currStr, "init", 4)) {
                    retVal = SECY_InitPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "get_cipher_cap", 14)) {
                    retVal = SECY_GetcapPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "set_cipher_suite", 16)) {
                    retVal = SECY_SetCapPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "add_lookuprule", 14)) {
                    retVal = SECY_AddLookupRulePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "add_cprule0", 11)) {
                    retVal = SECY_AddCpRule0PrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "add_cprule1", 11)) {
                    retVal = SECY_AddCpRule1PrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "txsc_create", 11)) {
                    retVal = SECY_AddTxscPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "rxsc_create", 11)) {
                    retVal = SECY_AddRxscPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "remove_cprule", 13)) {
                    retVal = SECY_RemoveCpRulePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "remove_lookuprule", 17)) {
                    retVal = SECY_RemoveLookupRulePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "txsc_del", 8)) {
                    retVal = SECY_RemoveTxscPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "rxsc_del", 8)) {
                    retVal = SECY_RemoveRxscPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "secy_create", 11)) {
                    retVal = SECY_CreateSecYPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "txsa_create", 11)) {
                    retVal = SECY_CreateTxsaPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "rxsa_create", 11)) {
                    retVal = SECY_CreateRxsaPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "set_frame_protect", 17)) {
                    retVal = SECY_SetFrameProtectPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "set_replay_protect", 18)) {
                    retVal = SECY_SetReplayProtectPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "set_validate_frame", 18)) {
                    retVal = SECY_SetFrameValidatePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_set_next_pn", 14)) {
                    retVal = SECY_SetPnPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_set_pn_thrld", 15)) {
                    retVal = SECY_SetPntherPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_get_next_pn", 14)) {
                    retVal = SECY_GetPnPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_get_status", 13)) {
                    retVal = SECY_GetStatusPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_get_tx_stats", 15)) {
                    retVal = SECY_GetTxsaStatsPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "txsc_get_stats", 14)) {
                    retVal = SECY_GetTxscStatsPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "rxsc_get_stats", 14)) {
                    retVal = SECY_GetRxscStatsPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "get_stats", 9)) {
                    retVal = SECY_GetStatsPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_enable", 9)) {
                    retVal = SECY_EnablePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_disable", 10)) {
                    retVal = SECY_DisablePrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "secy_delete", 11)) {
                    retVal = SECY_DeleteSecyPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "sa_delete", 9)) {
                    retVal = SECY_DeleteSaPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else if (!strncmp(currStr, "deinit", 6)) {
                    retVal = SECY_DeinitPrepCtxInt(remStr, remStrLen, aCtx, aOutLen);
                } else {
                    retVal = BCM_ERR_INVAL_PARAMS;
                }
            }
        }
    }

    return retVal;
}

static void SECY_GetStatusRespHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                int32_t        aResponse,
                                SECY_MsgUnionType *aCtx)
{
    uint32_t i;

    (void)MODULE_HostHelperLog("SA status:\n");
    (void)MODULE_HostHelperLog("inUse      : ");
    if(TRUE == CPU_LEToNative32(aCtx->saStatus.status.inUse)) {
        (void)MODULE_HostHelperLog("True\n");
    } else if (FALSE == CPU_LEToNative32(aCtx->saStatus.status.inUse)) {
        (void)MODULE_HostHelperLog("False\n");
    } else {
        (void)MODULE_HostHelperLog("Invalid\n");
    }
    (void)MODULE_HostHelperLog("ssci       : %d\n",CPU_LEToNative32(aCtx->saStatus.status.ssci));
    (void)MODULE_HostHelperLog("createdTime: %d\n",CPU_LEToNative32(aCtx->saStatus.status.createdTime));
    (void)MODULE_HostHelperLog("startedTime: %d\n",CPU_LEToNative32(aCtx->saStatus.status.startedTime));
    (void)MODULE_HostHelperLog("stoppedTime: %d\n",CPU_LEToNative32(aCtx->saStatus.status.stoppedTime));
    for(i=0; i<16UL; i++) {
        (void)MODULE_HostHelperLog("keyID[%d]: %d\n",CPU_LEToNative32(aCtx->saStatus.status.keyID[i]));
    }
}

static void SECY_GetTxscStatsRespHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                int32_t        aResponse,
                                SECY_MsgUnionType *aCtx)
{
    (void)MODULE_HostHelperLog("TxSC Stats:\n");
    (void)MODULE_HostHelperLog("outPktsProtected     : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->txScStats.stats.outPktsProtected));
    (void)MODULE_HostHelperLog("outPktsEncrypted     : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->txScStats.stats.outPktsEncrypted));
    (void)MODULE_HostHelperLog("outOctectsProtected  : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->txScStats.stats.outOctectsProtected));
    (void)MODULE_HostHelperLog("outOctectsEncrypted  : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->txScStats.stats.outOctectsEncrypted));
}

static void SECY_GetRxscStatsRespHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                int32_t        aResponse,
                                SECY_MsgUnionType *aCtx)
{
    (void)MODULE_HostHelperLog("RxSC Stats:\n");
    (void)MODULE_HostHelperLog("inPktsLate      : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->rxScStats.stats.inPktsLate));
    (void)MODULE_HostHelperLog("inPktsNotValid  : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->rxScStats.stats.inPktsNotValid));
    (void)MODULE_HostHelperLog("inPktsInvalid   : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->rxScStats.stats.inPktsInvalid));
    (void)MODULE_HostHelperLog("inPktsDelayed   : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->rxScStats.stats.inPktsDelayed));
    (void)MODULE_HostHelperLog("inPktsUnchecked : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->rxScStats.stats.inPktsUnchecked));
}

static void SECY_GetStatsRespHdlr(BCM_CmdType    *aMsg,
                                uint8_t       *aBuff,
                                int32_t        aResponse,
                                SECY_MsgUnionType *aCtx)
{
    (void)MODULE_HostHelperLog("SecY Stats:\n");
    (void)MODULE_HostHelperLog("OutPktsUntagged     : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.OutPktsUntagged));
    (void)MODULE_HostHelperLog("OutPktsTooLong      : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.OutPktsTooLong));
    (void)MODULE_HostHelperLog("InPktsUntagged      : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsUntagged));
    (void)MODULE_HostHelperLog("InPktsNoTag         : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsNoTag));
    (void)MODULE_HostHelperLog("InPktsBadTag        : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsBadTag));
    (void)MODULE_HostHelperLog("InPktsOverrun       : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsOverrun));
    (void)MODULE_HostHelperLog("InPktsNoSA          : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsNoSA));
    (void)MODULE_HostHelperLog("InPktsNoSAError     : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InPktsNoSAError));
    (void)MODULE_HostHelperLog("OutOctetsProtected  : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.OutOctetsProtected));
    (void)MODULE_HostHelperLog("OutsOctetsEncrypted : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.OutsOctetsEncrypted));
    (void)MODULE_HostHelperLog("InOctetsValidated   : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InOctetsValidated));
    (void)MODULE_HostHelperLog("InOctetsEncrypted   : 0x%016" PRIX64 "\n", CPU_LEToNative64(aCtx->stats.stats.InOctetsEncrypted));
}

static int32_t SECY_HelperProcess(BCM_CmdType    *aMsg,
                                          char          *aStr,
                                          uint32_t      *aStrLen,
                                          uint8_t       *aInOut,
                                          uint32_t       aInputLen,
                                          uint32_t      *aOutLen,
                                          uint32_t       aMaxLength,
                                          int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == SECY_HostCtx.modCtx.substate) {
        retVal = SECY_HelperPrepCtx(aStr, aStrLen,
                                          &SECY_HostCtx.ctx, aOutLen);
        if(BCM_ERR_OK ==retVal) {
            SECY_HostCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        } else {
            (void)MODULE_HostHelperLog("Line: %d  retVal: %d \n",__LINE__,retVal);
        }
    }

    retVal = SECY_HostContextProcess(&SECY_HostCtx.ctx, aResponse, *aMsg, aInOut, aMsg, aInOut);
    if (BCM_ERR_OK == retVal) {
        if (BCM_ERR_OK == aResponse) {
            switch(SECY_HostCtx.ctx.id) {
                case SECY_HW_INIT:
                    (void)MODULE_HostHelperLog("Initialized Successfully\n");
                    break;
                case SECY_GET_CIPHER_CAP:
                    if(SECY_CIPHER_CAP_INTEGRITY == CPU_LEToNative32(SECY_HostCtx.ctx.msg.getCipher.cap)) {
                        (void)MODULE_HostHelperLog("Integrity without confidentiality\n");
                    } else if (SECY_CIPHER_CAP_CONFIDENTIALITY == CPU_LEToNative32(SECY_HostCtx.ctx.msg.getCipher.cap)) {
                        (void)MODULE_HostHelperLog("Integrity with confidentiality\n");
                    } else if (SECY_CIPHER_CAP_CONF_OFFSET == CPU_LEToNative32(SECY_HostCtx.ctx.msg.getCipher.cap)) {
                        (void)MODULE_HostHelperLog("Integrity with confidentiality offset\n");
                    } else {
                        (void)MODULE_HostHelperLog("Invalid Cipher\n");
                    }
                    break;
                case SECY_ADD_CP_RULE_OPT0:
                    (void)MODULE_HostHelperLog("Rule0 Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.ruleOpt0.ruleHdl));
                    break;
                case SECY_ADD_CP_RULE_OPT1:
                    (void)MODULE_HostHelperLog("Rule1 Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.ruleOpt1.ruleHdl));
                    break;
                case SECY_REM_CP_RULE:
                    (void)MODULE_HostHelperLog("CpRule is Removed\n");
                    break;
                case SECY_CREATE:
                    (void)MODULE_HostHelperLog("SecY Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.secYCreate.secYHdl));
                    break;
                case SECY_SET_CIPHER_SUITE:
                    (void)MODULE_HostHelperLog("Set Cipher Message Successfully\n");
                    break;
                case SECY_SET_PROTECT:
                    (void)MODULE_HostHelperLog("Set Frame Protect Successfully\n");
                    break;
                case SECY_SET_VALIDATE_FRAME:
                    (void)MODULE_HostHelperLog("Set Frame Validate Successfully\n");
                    break;
                case SECY_SET_REPLAY_PROTECT:
                    (void)MODULE_HostHelperLog("Set Relay Protect Successfully\n");
                    break;
                case SECY_ADD_LOOKUP_RULE:
                    (void)MODULE_HostHelperLog("SecY Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.scLookup.secYHdl));
                    (void)MODULE_HostHelperLog("Rule Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.scLookup.ruleHdl));
                    break;
                case SECY_REM_LOOKUP_RULE:
                    (void)MODULE_HostHelperLog("Lookup Rule is Removed Successfully\n");
                    break;
                case SECY_TXSC_CREATE:
                    (void)MODULE_HostHelperLog("Txsc Message is Created Successfully\n");
                    break;
                case SECY_RXSC_CREATE:
                    (void)MODULE_HostHelperLog("Rxsc Message is Created Successfully\n");
                    break;
                case SECY_TXSA_CREATE:
                    (void)MODULE_HostHelperLog("TxSA Handle = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.sa.saHdl));
                    break;
                case SECY_RXSA_CREATE:
                    (void)MODULE_HostHelperLog("RxSA = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.sa.saHdl));
                    break;
                case SECY_SA_SET_PN_THRLD:
                    (void)MODULE_HostHelperLog("Set PN Threshold Successfully\n");
                    break;
                case SECY_SA_SET_NEXT_PN :
                    (void)MODULE_HostHelperLog("Set PN Successfully\n");
                    break;
                case SECY_SA_GET_NEXT_PN :
                    (void)MODULE_HostHelperLog("Next PN = 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.pn.pn));
                    break;
                case SECY_SA_GET_STATUS:
                    SECY_GetStatusRespHdlr(aMsg, aInOut, aResponse,
                                                     &SECY_HostCtx.ctx.msg);
                    break;
                case SECY_SA_ENABLE:
                    (void)MODULE_HostHelperLog("SecY Enabled Successfully\n");
                    break;
                case SECY_SA_DISABLE:
                    (void)MODULE_HostHelperLog("SecY Disabled Successfully\n");
                    break;
                case SECY_SA_GET_TX_STATS:
                    (void)MODULE_HostHelperLog("TxSA Stats:\n");
                    (void)MODULE_HostHelperLog("No of Protected Packets : 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.saStats.stats.outPktsProtected));
                    (void)MODULE_HostHelperLog("No of Encrypted Packets : 0x%016" PRIX64 "\n", CPU_LEToNative64(SECY_HostCtx.ctx.msg.saStats.stats.outPktsEncrypted));
                    break;
                case SECY_SA_DELETE:
                        (void)MODULE_HostHelperLog("SecY SA Deleted Successfully\n");
                    break;
                case SECY_TXSC_GET_STATS:
                    SECY_GetTxscStatsRespHdlr(aMsg, aInOut, aResponse,
                                                     &SECY_HostCtx.ctx.msg);
                    break;
                case SECY_RXSC_GET_STATS:
                    SECY_GetRxscStatsRespHdlr(aMsg, aInOut, aResponse,
                                                     &SECY_HostCtx.ctx.msg);
                    break;
                case SECY_TXSC_DEL:
                       (void)MODULE_HostHelperLog("Txsc is Deleted Successfully\n");
                    break;
                case SECY_RXSC_DEL:
                        (void)MODULE_HostHelperLog("Rxsc is Deleted Successfully\n");
                    break;
                case SECY_GET_STATS:
                    SECY_GetStatsRespHdlr(aMsg, aInOut, aResponse,
                                                     &SECY_HostCtx.ctx.msg);
                    break;
                case SECY_DELETE:
                    (void)MODULE_HostHelperLog("SecY is Deleted Successfully\n");
                    break;
                case SECY_HW_DEINIT:
                    (void)MODULE_HostHelperLog("SecY is De-Initialized Successfully\n");
                    break;
                default:
                    if(BCM_ERR_OK == retVal) {
                        retVal = BCM_ERR_UNKNOWN;
                    }
                    break;
            }
            SECY_HostCtx.modCtx.substate = BCM_STATE_SUB_STATE_DONE;
        } else {
            (void)MODULE_HostHelperLog("Error, Response = %d\n", aResponse);
            retVal = BCM_ERR_UNKNOWN;
        }
    } else if(BCM_ERR_BUSY == retVal) {
        retVal = BCM_ERR_OK;
    } else {
        /* return retVal */
    }

    return retVal;
}

/**
    @brief SecY Host helper

    @trace #BRCM_SWREQ_SECY
*/
const MODULE_MsgConverterType SECY_HostHelper = {
    .helpstr = SECY_HelpCmds,                  /**< @brief Prefix String        */
    .groupId = BCM_GROUPID_CRYPTO,             /**< @brief Group ID             */
    .compId  = BCM_CSY_ID,                     /**< @brief Component ID         */
    .context = &SECY_HostCtx.modCtx,           /**< @brief Context memory       */
    .process = SECY_HelperProcess,             /**< @brief Process msg/response */
};
/** @} */
