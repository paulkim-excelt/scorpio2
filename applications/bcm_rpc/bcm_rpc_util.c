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
#include <stddef.h>
#include <stdio.h>
#include <compiler.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <byteswap.h>
#include <bcm_err.h>
#include <rpc_mem.h>
#include <system_imgl.h>
#include <system_dmon.h>
#include <module_msg.h>
#include <ethernet_swt_vlan.h>
#include <ethernet_swt_arl.h>
#include <ethernet_swt_cfp.h>
#include <nvm_flash.h>
#include <ethernet_ets.h>
#include <ethernet_nif.h>
#include <ethernet_swt_ext.h>
#include <ethernet_swt_debug.h>
#include <ethernet_swt_ext.h>
#include <ethsrv_host.h>
#include <rpc_hosthelper.h>
#include <cpu_utils.h>
#include <crypto_secy.h>

#include <unistd.h>

/* Increment this for every New Helper */
#define BCM_RPC_MAX_UTIL_MODULES     (22UL)

#define BCM_RPC_MAX_STR_SIZE         (1042 * 4)

const uint32_t MODULE_Event = 0UL;

typedef struct sBCM_HelperListType {
    const char *str;
    const MODULE_MsgConverterType *processStr;
} BCM_HelperListType;

static MODULE_MsgContextType BCM_HelpCtx;                        /**< @brief Help comamnd Context     */

static int32_t BCM_HelpProcess (BCM_CmdType    *aMsg,
                                 char          *aStr,
                                 uint32_t      *aStrLen,
                                 uint8_t       *aInOut,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse);

static int32_t SYSTEM_AsyncDumpHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse);


static const char SYSTEM_AsyncDumpHelpCmds[] =
"[ets <port>]\n"
;

typedef struct sSYSTEM_AsyncHelperCtxType {
    MODULE_MsgContextType modCtx;     /**< @brief Module's Context                   */
    BCM_CmdType cmd;                  /**< @brief command which is in process        */
    BCM_CompIDType asyncCompID;       /**< @brief component ID for  async message    */
    uint32_t    val;                  /**< @brief Value to filter a message
                                                  should be initialized to 0xFF
                                                  for ETS Records val is <portNo>    */
} SYSTEM_AsyncHelperCtxType;

SYSTEM_AsyncHelperCtxType SYSTEM_AsyncHelperCtx;

const MODULE_MsgConverterType SYSTEM_AsyncDumpHelper = {
    .helpstr = SYSTEM_AsyncDumpHelpCmds,
    .context = &SYSTEM_AsyncHelperCtx.modCtx,
    .process = SYSTEM_AsyncDumpHelperProcess,
};

const MODULE_MsgConverterType BCM_ListHelp = {
    .helpstr = "\n",
    .context = &BCM_HelpCtx,
    .process = BCM_HelpProcess,
};

static BCM_HelperListType clientList[BCM_RPC_MAX_UTIL_MODULES] = {
    {"execute fw"            , &IMGL_HostHelper,},
    {"install all"           , &FLASH_InstallHelper,},
    {"install custom"        , &IMGL_HostHelper,},
    {"nvm"                   , &FLASH_Helper,},
    {"mdio"                  , &ETHER_MDIOHelper,},
    {"switch vlan"           , &ETHSWT_VLANHelper,},
    {"switch arl"            , &ETHSWT_ARLHelper,},
    {"switch mirror"         , &ETHSWT_DebugMirrorHelper,},
    {"switch mibs"           , &ETHSWT_SWTDebugHelper,},
    {"switch"                , &ETHSWT_SWTHelper,},
    {"ets"                   , &ETS_Helper,},
    {"mem"                   , &DMON_HostDbgHelper,},
    {"cfp"                   , &ETHSWT_CFPHelper,},
    {"version"               , &DMON_HostHelper,},
    {"reboot"                , &DMON_HostHelper,},
    {"async dump"            , &SYSTEM_AsyncDumpHelper,},
    {"async count heartbeat" , &DMON_HostAsyncHelper,},
    {"eth"                   , &ETHSRV_Helper,},
    {"secy"                  , &SECY_HostHelper,},
    {"help"                  , &BCM_ListHelp,},
};


static void BCM_PrintHelpAll(uint32_t aModule)
{
    uint32_t j;
    uint32_t helpCmdsLen = 0UL;

    /* Total length of the help string of the module */
    helpCmdsLen = strlen(clientList[aModule].processStr->helpstr);
    j = 0UL;
    while(0UL != helpCmdsLen) {
        /* Group String */
        (void)MODULE_HostHelperLog("%s ",clientList[aModule].str);
        for(; clientList[aModule].processStr->helpstr[j] != '\n' ; j++) {
            /* Print oneline of groups help */
            (void)MODULE_HostHelperLog("%c",clientList[aModule].processStr->helpstr[j]);
             helpCmdsLen--;
        }
        /* Add NewLine after the one line */
        helpCmdsLen--;
       (void)MODULE_HostHelperLog("\n");
        j++;
    }
}

static int32_t BCM_HelpProcess (BCM_CmdType    *aMsg,
                                 char          *aStr,
                                 uint32_t      *aStrLen,
                                 uint8_t       *aInOut,
                                 uint32_t       aInputLen,
                                 uint32_t      *aOutLen,
                                 uint32_t       aMaxLength,
                                 int32_t        aResponse)
{
    uint32_t i;

    for(i=0; i<BCM_RPC_MAX_UTIL_MODULES;i++){
        if(NULL != clientList[i].str) {
            BCM_PrintHelpAll(i);
        }
    }
    BCM_HelpCtx.substate = BCM_STATE_SUB_STATE_DONE;

    return BCM_ERR_OK;
}

int32_t BCM_GetModuleIndex(const char *inputStr, uint32_t *aIdx)
{
    int32_t retVal = BCM_ERR_OK;
    uint32_t i;

    for (i=0UL; i < BCM_RPC_MAX_UTIL_MODULES; i++) {
        if(NULL != clientList[i].str) {
            if (0UL == strncmp(clientList[i].str, inputStr, strlen(clientList[i].str))) {
                *aIdx = i;
                break;
            }
        }
    }

    if(i == BCM_RPC_MAX_UTIL_MODULES) {
        retVal = BCM_ERR_NOT_FOUND;
    }

    return retVal;
}
int main(int argc, char *argv[])
{
    char cmdstring[BCM_RPC_MAX_STR_SIZE];
    int32_t retVal = -1;
    int32_t clientSock;
    uint32_t i;
    uint32_t len;
    uint32_t idx = 0;
    uint32_t strLen = 0;
    uint32_t inBufLen = 0;
    uint32_t outLen = 0;
    uint32_t maxPayloadLen = 0;
    int32_t response = BCM_ERR_OK;
    struct sockaddr_un remote;
    RPC_MemMsgType hostMsg;
    char env[100] = "";
    char sockName[100];

    if (argc < 2) {
        for(i=0; i<BCM_RPC_MAX_UTIL_MODULES;i++){
            if(NULL != clientList[i].str) {
                BCM_PrintHelpAll(i);
            }
        }
        goto done;
    }

    for (i=1; i<argc; i++) {
        strLen += strlen(argv[i]);
        strLen++; /* account for space and null termination */
    }


    if (strLen > MODULE_MSG_MAX_STR_LENGTH) {
        (void)MODULE_HostHelperLog("Command size:%d > maximum allowed:%d\n", strLen, MODULE_MSG_MAX_STR_LENGTH);
        goto done;
    }

    /* Create a client socket */
    if ((clientSock = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }

    if (NULL != getenv("RPCUTIL_INSTANCE")) {
        sprintf(env, "_%s", getenv("RPCUTIL_INSTANCE"));
    }
    strcpy(sockName, "bcm_rpc_socket");
    strcat(sockName, env);

    remote.sun_family = AF_UNIX;
    strcpy(remote.sun_path, sockName);
    len = strlen(remote.sun_path) + sizeof(remote.sun_family);
    if (connect(clientSock, (struct sockaddr *)&remote, len) == -1) {
        exit(1);
    }
    (void)MODULE_HostHelperLog("Connected to %s\n", sockName);

    memset(cmdstring, 0U, BCM_RPC_MAX_STR_SIZE);
    cmdstring[0] = '\0';
    for (i=1; i<argc; i++) {
        strcat(cmdstring, argv[i]);
        if (i < (argc - 1)) {
            strcat(cmdstring, " ");
        }
    }

    retVal = BCM_GetModuleIndex(cmdstring, &idx);
    if(BCM_ERR_OK != retVal) {
        (void)MODULE_HostHelperLog("Command Is Not Found\n");
        /* Print the help string with appropriate module's command group */
        for(i=0; i<BCM_RPC_MAX_UTIL_MODULES;i++) {
            if(NULL != clientList[i].str) {
                BCM_PrintHelpAll(i);
            }
        }
        retVal = -1;
    } else {
        if(NULL != clientList[idx].processStr->context) {
            clientList[idx].processStr->context->substate = BCM_STATE_SUB_STATE_RESET;
            maxPayloadLen = RPC_MEM_MSG_PAYLOAD_SZ;
            memset(&hostMsg, 0U, sizeof(RPC_MemMsgType));
            do {
                retVal = clientList[idx].processStr->process(&hostMsg.cmd,
                                                             cmdstring,
                                                             &strLen,
                                                             hostMsg.payload,
                                                             inBufLen,
                                                             &outLen,
                                                             maxPayloadLen,
                                                             response);
                if(BCM_ERR_INVAL_PARAMS == retVal) {
                    (void)MODULE_HostHelperLog("\nbcm_rpc_util: %s invalid arguments\n", cmdstring);
                    (void)MODULE_HostHelperLog("Usage:\n");
                    BCM_PrintHelpAll(idx);
                    retVal = -1;
                    break;
                } else if(BCM_ERR_OK != retVal) {
                    retVal = -1;
                    break;
                } else {
                    if(BCM_STATE_SUB_STATE_DONE != clientList[idx].processStr->context->substate) {
                        hostMsg.magic = RPC_MEMMSG_MAGIC;
                        hostMsg.len = outLen;
                        if (send(clientSock, (const char *)&hostMsg, sizeof(hostMsg), 0) == -1) {
                            perror("send");
                            exit(1);
                        }
                        memset(&hostMsg, 0U, sizeof(RPC_MemMsgType));
                        do {
                            /* Wait until bcm_rpc_proxy provides a response */
                            inBufLen = recv(clientSock, &hostMsg, sizeof(hostMsg), 0L);
                        } while (0L >= inBufLen);
                        /* Reset to fetch the next data */
                        strLen = 0;
                        inBufLen = hostMsg.len;
                        response = hostMsg.response;
                    } else {
                        memset(&hostMsg, 0U, sizeof(RPC_MemMsgType));
                    }
                }
            } while(BCM_STATE_SUB_STATE_DONE != clientList[idx].processStr->context->substate);
        } else {
            (void)MODULE_HostHelperLog("No Support. Try Other Command\n");
            /* Print the help string with appropriate module's command group */
            for(i=0; i<BCM_RPC_MAX_UTIL_MODULES;i++) {
                if(NULL != clientList[i].str) {
                    BCM_PrintHelpAll(i);
                }
            }
        }
        (void)MODULE_HostHelperLog("bcm_rpc_util: %s processed successfully\n", cmdstring);
        retVal = BCM_ERR_OK;
    }

done:
    return retVal;
}


int32_t SYSTEM_AsyncHDumpelperPrepCtx(char          *aStr,
                                  uint32_t      *aStrLen,
                                  SYSTEM_AsyncHelperCtxType *aCtx)
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
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);/* async */
        currStr = remStr;
        currStrLen = remStrLen;
        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
        if (0UL == strncmp(currStr, "dump", 4)) {
            aCtx->val = 0xFFUL;
            if ((remStr != NULL) && (remStrLen != 0UL)) {
                currStr = remStr;
                currStrLen = remStrLen;
                MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                if (0UL == strncmp(currStr, "ets", 3)) {
                    if ((remStr != NULL) && (remStrLen != 0UL))  {
                        currStr = remStr;
                        currStrLen = remStrLen;
                        MODULE_MsgSplitString(currStr, currStrLen, &remStr, &remStrLen);
                        aCtx->val = MODULE_MsgParseInt(currStr, &parseStatus); /* value */
                        if(BCM_ERR_OK != parseStatus) {
                            goto done;
                        }
                        if ((remStr != NULL) && (remStrLen != 0UL))  {
                            goto done;
                        }
                    } else {
                        goto done;
                    }
                } else {
                    /* no support */
                    goto done;
                }
            }
            aCtx->cmd = RPC_HOST_CMDID_GET_ASYNC_MSG;
            retVal = BCM_ERR_OK;
        }
    }

done:
    return retVal;
}

static int32_t BCM_PrintAsyncNotification (BCM_CmdType aCmd,
                                            uint8_t *aMsg, uint32_t aSize)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;
    BCM_GroupIDType group;
    BCM_CompIDType comp;
    uint32_t i;

    group = (aCmd & BCM_CMD_GROUP_MASK) >> BCM_CMD_GROUP_SHIFT;
    comp = (aCmd & BCM_CMD_COMP_MASK) >> BCM_CMD_COMP_SHIFT;

    for (i=0UL; i < BCM_RPC_MAX_UTIL_MODULES; i++) {
        if(NULL != clientList[i].processStr) {
            if((group == clientList[i].processStr->groupId) && (comp == clientList[i].processStr->compId) && (NULL != clientList[i].processStr->print)) {
                 retVal = clientList[i].processStr->print(aCmd, aMsg, aSize);
                 break;
            }
        }
    }

    return retVal;
}

int32_t SYSTEM_AsyncDumpHelperHdlr(BCM_CmdType    *aMsg,
                                    uint8_t       *aBuff,
                                    uint32_t       aInputLen,
                                    uint32_t      *aOutLen,
                                    uint32_t       aMaxLength,
                                    int32_t        aResponse,
                                    SYSTEM_AsyncHelperCtxType *aCtx)
{
    int32_t retVal = BCM_ERR_UNKNOWN;

    switch(aCtx->modCtx.substate) {
        case BCM_STATE_SUB_STATE_STAGE0:
            *aMsg = BCM_ASYNCID(BCM_GROUPID_SYS, BCM_RPC_ID, RPC_HOST_CMDID_GET_ASYNC_MSG);
            aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE1;
            retVal = BCM_ERR_OK;
            break;
        case BCM_STATE_SUB_STATE_STAGE1:
            if ((BCM_ERR_NOT_FOUND == aResponse) && (0UL == aInputLen)) {
                (void)MODULE_HostHelperLog("No Async Messages in Queue\n");
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            } else {
                /* if the notification is ETS record then update the requested port number */
                if(BCM_ASYNCID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_RECORD) == *aMsg) {
                    ETS_HelperCtx.ctx.msg.portNum = aCtx->val;
                    ETS_RecordsCacheHdlr(aMsg, aBuff, aInputLen, aOutLen, aMaxLength, aResponse, &ETS_HelperCtx);
                }
                retVal = BCM_PrintAsyncNotification(*aMsg, aBuff, aInputLen);
                *aMsg = BCM_ASYNCID(BCM_GROUPID_SYS, BCM_RPC_ID, RPC_HOST_CMDID_GET_ASYNC_MSG);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        case BCM_STATE_SUB_STATE_STAGE2:
            if ((BCM_ERR_NOT_FOUND == aResponse) && (0UL == aInputLen)) {
                ETS_HelperCtx.ctx.msg.portNum = aCtx->val;
                *aMsg = BCM_ASYNCID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_RECORD);
                retVal = BCM_PrintAsyncNotification(*aMsg, aBuff, 0UL);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_DONE;
                retVal = BCM_ERR_OK;
            } else if (BCM_ERR_OK != aResponse) {
                (void)MODULE_HostHelperLog("Failed to Display Async Message\n");
                retVal = BCM_ERR_UNKNOWN;
            } else {
                /* if the notification is ETS record then update the requested port number */
                if(BCM_ASYNCID(BCM_GROUPID_ETHSRV, BCM_ETS_ID, ETS_EVENT_IF_RECORD) == *aMsg) {
                    ETS_HelperCtx.ctx.msg.portNum = aCtx->val;
                    ETS_RecordsCacheHdlr(aMsg, aBuff, aInputLen, aOutLen, aMaxLength, aResponse, &ETS_HelperCtx);
                }
                retVal = BCM_PrintAsyncNotification(*aMsg, aBuff, aInputLen);
                *aMsg = BCM_ASYNCID(BCM_GROUPID_SYS, BCM_RPC_ID, RPC_HOST_CMDID_GET_ASYNC_MSG);
                aCtx->modCtx.substate = BCM_STATE_SUB_STATE_STAGE2;
                retVal = BCM_ERR_OK;
            }
            break;
        default:
            break;
    }
    return retVal;
}

static int32_t SYSTEM_AsyncDumpHelperProcess(BCM_CmdType    *aMsg,
                                        char          *aStr,
                                        uint32_t      *aStrLen,
                                        uint8_t       *aInOut,
                                        uint32_t       aInputLen,
                                        uint32_t      *aOutLen,
                                        uint32_t       aMaxLength,
                                        int32_t        aResponse)
{
    int32_t retVal = BCM_ERR_INVAL_PARAMS;

    if(BCM_STATE_SUB_STATE_RESET == SYSTEM_AsyncHelperCtx.modCtx.substate) {
        retVal = SYSTEM_AsyncHDumpelperPrepCtx(aStr, aStrLen,
                                          &SYSTEM_AsyncHelperCtx);
        if(BCM_ERR_OK ==retVal) {
            SYSTEM_AsyncHelperCtx.modCtx.substate = BCM_STATE_SUB_STATE_STAGE0;
        }
    }

    switch(SYSTEM_AsyncHelperCtx.cmd) {
        case RPC_HOST_CMDID_GET_ASYNC_MSG:
            retVal = SYSTEM_AsyncDumpHelperHdlr(aMsg, aInOut, aInputLen,
                                               aOutLen, aMaxLength, aResponse,
                                               &SYSTEM_AsyncHelperCtx);
            break;
        default:
            break;
    }

    return retVal;
}

void BCM_ReportError(uint16_t aCompID,
                     uint8_t aInstanceID,
                     uint16_t aApiID,
                     int32_t aErrorID,
                     uint32_t aNumInts,
                     const uint32_t *const aValues)
{
    (void)MODULE_HostHelperLog("Error from comp %x\t apiID %x ret %x val = [%d %d %d %d] \n",
                 aCompID,aApiID,aErrorID,
                 *(aValues),*(aValues+1),*(aValues+2),*(aValues+3));
}
