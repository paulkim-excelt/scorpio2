/*****************************************************************************
 Copyright 2017-2022 Broadcom Limited.  All rights reserved.

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

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "host_system.h"
#include <host_imgl.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/select.h>
#include <sys/time.h>
#include <bcm_err.h>
#include <mqueue.h>
#include <server_ifc.h>
#include <hipc.h>
#include <rpc_cmds.h>
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
#include <host_ets.h>
#endif
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
#include <host_ether.h>
#include <host_etherswt.h>
#endif
#include <host_system.h>
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
#include <host_cfp.h>
#endif
#include <bcm_utils.h>
#include <hlog.h>
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
#include <host_fa.h>
#endif

#include <rpc_mem.h>
#include <system_dmon.h>
#include <system_imgl.h>
#include <dbgmem.h>

static int32_t Host_CheckAsyncMsg();

#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
static ETHSWT_ARLEntryType ARLEntries[1000UL];
static ETHSWT_CFPEntrySnapshotType CFPRules[ETHSWT_CFP_MAX_RULES];
#endif

static MgmtInfoType info_g;
mqd_t asyncMqd = -1;
/*@api
 * buffer_from_file
 *
 * @brief
 * Create a buffer holding the contents of a file.
 *
 * @param=name - file to read
 * @param=len - pointer to length to return
 * @returns pointer to the data, or NULL
 *
 * @desc
 */
void * buffer_from_file(char *name, uint32_t *len)
{
    FILE *fp;
    uint32_t read_len;
    void *buffer;
    fp = fopen(name, "r");
    if (!fp) {
        HOST_Log("could not open %s\n", name);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_END) < 0) {
        HOST_Log("error seeking to end of %s\n", name);
        fclose(fp);
        return NULL;
    }

    *len = ftell(fp);
    if(*len < 0 ) {
        HOST_Log("error in getting the current position\n");
        fclose(fp);
        return NULL;
    }
    if (fseek(fp, 0, SEEK_SET) < 0) {
        HOST_Log("error seeking to beginning of %s\n", name);
        fclose(fp);
        return NULL;
    }

    buffer = malloc(*len);
    if (!buffer) {
        HOST_Log("could not allocate %d bytes\n", *len);
        fclose(fp);
        return NULL;
    }

    read_len = fread(buffer, 1, *len, fp);
    fclose(fp);
    if (read_len != *len) {
        HOST_Log("error reading %s\n", name);
        free(buffer);
        return NULL;
    }

    return buffer;
}

static void process_user_cmd(MgmtInfoType *info, mqd_t sendMqd, char* recvData)
{
    int retVal = -1;
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    uint8_t swtEntrySize;
    uint16_t swtEntryWrIdx;
    uint16_t swtEntryWrCnt;
    uint32_t i;
    uint32_t memData;
#endif
    uint32_t nvmRdIdx;
    uint32_t nvmRdWrLen;
    uint32_t nvmRdWrCnt;
    uint32_t buf_size;
    void* buffer;
    char* nvmRdData;
    char version[DMON_SW_VERSION_STR_LEN + 1];
    HOST_BufferType uBuff;
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
    ETHSWT_CFPConfigType cfpConfig;
#endif

#ifdef ENABLE_DBGMEM
    DBGMEM_HandleType memHdl;
#endif

    uBuff.ptr = recvData;
//    HOST_Log("Server -- Received command = %4X\n",uBuff.hdr->cmd);
    switch(uBuff.hdr->cmd){
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    case HOST_SWT_PORT_INFO:
        uBuff.pInfo->cmdRsp.rsp = HOST_EtherSwtPortInfoGet(info, uBuff.pInfo->value1, &uBuff.pInfo->portInfo);
        retVal = mq_send(sendMqd, (char*) uBuff.pInfo, sizeof(HOST_SWTPortInfoType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_PORT_MIBS_CLR:
        uBuff.mibsClr->cmdRsp.rsp = HOST_EtherSwtMibClear(info, uBuff.mibsClr->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mibsClr, sizeof(HOST_SWTPortMibsClrType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_PORT_MIBS:
        uBuff.mibs->cmdRsp.rsp = HOST_EtherSwtMib(info, uBuff.mibs->value1,&uBuff.mibs->mibs);
        retVal = mq_send(sendMqd, (char*) uBuff.mibs, sizeof(HOST_SWTPortMibsType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_REG_READ:
        uBuff.swtRegRead->cmdRsp.rsp = HOST_EtherSwtRegRead(info, uBuff.swtRegRead->value2,
                                                  uBuff.swtRegRead->value1, 1UL, &uBuff.swtRegRead->u64Val);
        retVal = mq_send(sendMqd, (char*) uBuff.swtRegRead, sizeof(HOST_SWTRegReadType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_REG_WRITE:
        uBuff.swtRegWrite->cmdRsp.rsp = HOST_EtherSwtRegWrite(info, uBuff.swtRegWrite->value2,
                                                  uBuff.swtRegWrite->value1, 1UL, &uBuff.swtRegWrite->u64Val);
        retVal = mq_send(sendMqd, (char*) uBuff.swtRegWrite, sizeof(HOST_SWTRegWriteType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MDIO_READ:
        uBuff.mdioRd->cmdRsp.rsp = HOST_MDIORead(info, uBuff.mdioRd->access, uBuff.mdioRd->value2,
                                                  uBuff.mdioRd->phy, uBuff.mdioRd->dev, uBuff.mdioRd->u16Val,
                                                  &uBuff.mdioRd->u16Val2, uBuff.mdioRd->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mdioRd, sizeof(HOST_SWTMDIOType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MDIO_WRITE:
        uBuff.mdioWr->cmdRsp.rsp = HOST_MDIOWrite(info, uBuff.mdioWr->access, uBuff.mdioWr->value2,
                                                  uBuff.mdioWr->phy, uBuff.mdioWr->dev, uBuff.mdioWr->u16Val,
                                                  uBuff.mdioWr->u16Val2, uBuff.mdioWr->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mdioWr, sizeof(HOST_SWTMDIOType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_AGE_TIME_GET:
        uBuff.ageTime->cmdRsp.rsp = HOST_EtherSwtAgeTimeGet(info, &uBuff.ageTime->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.ageTime, sizeof(HOST_SWTAgeTimeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_AGE_TIME_SET:
        uBuff.ageTime->cmdRsp.rsp = HOST_EtherSwtAgeTimeSet(info, uBuff.ageTime->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.ageTime, sizeof(HOST_SWTAgeTimeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_DMBFWD_GET:
        uBuff.dmbFwd->cmdRsp.rsp = HOST_EtherSwtDumbFwdModeGet(info, &uBuff.dmbFwd->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.dmbFwd, sizeof(HOST_SWTDmbFwdType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_DMBFWD_SET:
        uBuff.dmbFwd->cmdRsp.rsp = HOST_EtherSwtDumbFwdModeSet(info, uBuff.dmbFwd->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.dmbFwd, sizeof(HOST_SWTDmbFwdType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_BRCMHDR_GET:
        uBuff.brcmHdr->cmdRsp.rsp = HOST_EtherSwtBrcmHdrModeGet(info, &uBuff.brcmHdr->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.brcmHdr, sizeof(HOST_SWTBrcmHdrType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_BRCMHDR_SET:
        uBuff.brcmHdr->cmdRsp.rsp = HOST_EtherSwtBrcmHdrModeSet(info, uBuff.brcmHdr->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.brcmHdr, sizeof(HOST_SWTBrcmHdrType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MGMTMODE_GET:
        uBuff.mgmtMode->cmdRsp.rsp = HOST_EtherSwtMgmtModeGet(info, &uBuff.mgmtMode->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mgmtMode, sizeof(HOST_SWTMgmtModeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MGMTMODE_SET:
        uBuff.mgmtMode->cmdRsp.rsp = HOST_EtherSwtMgmtModeSet(info, uBuff.mgmtMode->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mgmtMode, sizeof(HOST_SWTMgmtModeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MIRROR_EN:
        uBuff.mirrorEn->cmdRsp.rsp = HOST_EtherSwtMirrorEnable(info, uBuff.mirrorEn->value1,
                                                   uBuff.mirrorEn->value2, uBuff.mirrorEn->value3,
                                                   uBuff.mirrorEn->value4);
        retVal = mq_send(sendMqd, (char*) uBuff.mirrorEn, sizeof(HOST_SWTMirrorEnType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MIRROR_DIS:
        uBuff.mirrorDis->cmdRsp.rsp = HOST_EtherSwtMirrorDisable(info);
        retVal = mq_send(sendMqd, (char*) uBuff.mirrorDis, sizeof(HOST_SWTMirrorDisType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MIRROR_STATUS:
        uBuff.mirrorStatus->cmdRsp.rsp = HOST_EtherSwtMirrorStatus(info, &uBuff.mirrorStatus->mirrorState,
                                                      &uBuff.mirrorStatus->u16Val, &uBuff.mirrorStatus->u16Val2,
                                                      &uBuff.mirrorStatus->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.mirrorStatus, sizeof(HOST_SWTMirrorStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ADMIN_GET:
        uBuff.adminGet->cmdRsp.rsp = HOST_EtherSwtXcvrAdminModeGet(info, uBuff.adminGet->value1, &uBuff.adminGet->mode);
        retVal = mq_send(sendMqd, (char*) uBuff.adminGet, sizeof(HOST_SWTAdmnGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ADMIN_SET:
        uBuff.adminSet->cmdRsp.rsp = HOST_EtherSwtXcvrAdminModeSet(info, uBuff.adminSet->value1, uBuff.adminSet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.adminSet, sizeof(HOST_SWTAdminSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_SPEED_GET:
        uBuff.swtSpeedGet->cmdRsp.rsp = HOST_EtherSwtXcvrSpeedGet(info, uBuff.swtSpeedGet->value1, &uBuff.swtSpeedGet->speed);
        retVal = mq_send(sendMqd, (char*) uBuff.swtSpeedGet, sizeof(HOST_SWTSpeedGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MASTERSLAVE_GET:
        uBuff.masterSlaveGet->cmdRsp.rsp = HOST_EtherSwtXcvrMasterSlaveGet(info, uBuff.masterSlaveGet->value1,
                                                                       &uBuff.masterSlaveGet->mode);
        retVal = mq_send(sendMqd, (char*) uBuff.masterSlaveGet, sizeof(HOST_SWTMasterSlaveGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_MASTERSLAVE_SET:
        uBuff.masterSlaveSet->cmdRsp.rsp = HOST_EtherSwtXcvrMasterSlaveSet(info, uBuff.masterSlaveSet->value1,
                                                                       uBuff.masterSlaveSet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.masterSlaveSet, sizeof(HOST_SWTMasterSlaveSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_PHYLB_GET:
        uBuff.phyLBGet->cmdRsp.rsp = HOST_EtherSwtXcvrPhyLbGet(info, uBuff.phyLBGet->value1,
                                                               &uBuff.phyLBGet->mode);
        retVal = mq_send(sendMqd, (char*) uBuff.phyLBGet, sizeof(HOST_SWTPhyLBGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_PHYLB_SET:
        uBuff.phyLBSet->cmdRsp.rsp = HOST_EtherSwtXcvrPhyLbSet(info, uBuff.phyLBSet->value1,
                                                               uBuff.phyLBSet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.phyLBSet, sizeof(HOST_SWTPhyLBSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_JUMBOFRAME_GET:
        uBuff.jumbpFrameGet->cmdRsp.rsp = HOST_EtherSwtXcvrJumboFrameModeGet(info, uBuff.jumbpFrameGet->value1,
                                                                          &uBuff.jumbpFrameGet->jumbo);
        retVal = mq_send(sendMqd, (char*) uBuff.jumbpFrameGet, sizeof(HOST_SWTJumboFrameGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_JUMBOFRAME_SET:
        uBuff.jumboFrameSet->cmdRsp.rsp = HOST_EtherSwtXcvrJumboFrameModeSet(info, uBuff.jumboFrameSet->value1,
                                                                        uBuff.jumboFrameSet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.jumboFrameSet, sizeof(HOST_SWTJumboFrameSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_LINK_SQI_GET:
        uBuff.linkSqiGet->cmdRsp.rsp = HOST_EtherSwtXcvrLinkSQIGet(info, uBuff.linkSqiGet->value1,
                                                                  &uBuff.linkSqiGet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.linkSqiGet, sizeof(HOST_SWTLinkSqiGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_CONV_MAC:
        HOST_EtherSwtConvertMac(uBuff.convMac->str, &uBuff.convMac->mac_addr[0], &uBuff.convMac->result);
        retVal = mq_send(sendMqd, (char*) uBuff.convMac, sizeof(HOST_SWTConvMacType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ARL_GET:
        uBuff.arlGet->cmdRsp.rsp = HOST_EtherSwtARLGet(info, &ARLEntries[0], &uBuff.arlGet->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.arlGet, sizeof(HOST_SWTARLGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        swtEntryWrIdx  = 0;
        swtEntrySize = sizeof(ETHSWT_ARLEntryType);
        if(uBuff.arlGet->value1 <= HOST_SWT_ARL_VOL_MSGQ) {
            swtEntryWrCnt = swtEntrySize * uBuff.arlGet->value1;
        } else {
            swtEntryWrCnt = swtEntrySize * HOST_SWT_ARL_VOL_MSGQ;
        }
        while(swtEntryWrIdx < uBuff.arlGet->value1 ) {
            retVal = mq_send(sendMqd, (char*) &ARLEntries[swtEntryWrIdx], swtEntryWrCnt, 1);
            if (-1 == retVal) {
                usleep(3000);
                continue;
            }
            swtEntryWrIdx += (swtEntryWrCnt / swtEntrySize);
            if(HOST_SWT_ARL_VOL_MSGQ > (uBuff.arlGet->value1 - swtEntryWrIdx)) {
                swtEntryWrCnt = swtEntrySize * (uBuff.arlGet->value1 - swtEntryWrIdx) ;
            }
        }
        break;
    case HOST_SWT_ARL_ADD:
        uBuff.arlAdd->cmdRsp.rsp = HOST_EtherSwtARLAdd(info, &uBuff.arlAdd->mac_addr[0],
                                                     uBuff.arlAdd->u16Val, uBuff.arlAdd->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.arlAdd, sizeof(HOST_SWTARLAddType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ARL_DEL:
        uBuff.arlDel->cmdRsp.rsp = HOST_EtherSwtARLDelete(info, &uBuff.arlDel->mac_addr[0], uBuff.arlDel->u16Val);
        retVal = mq_send(sendMqd, (char*) uBuff.arlDel, sizeof(HOST_SWTARLDelType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STREAM_POLICER_ADD:
        uBuff.policerAdd->cmdRsp.rsp = HOST_CFPStreamPolicerAdd(info, &uBuff.policerAdd->mac_addr[0],
                                           uBuff.policerAdd->u16Val,uBuff.policerAdd->rate, uBuff.policerAdd->burst,
                                           uBuff.policerAdd->src_mask, uBuff.policerAdd->threshold,
                                           uBuff.policerAdd->interval, uBuff.policerAdd->report,
                                           uBuff.policerAdd->block, &uBuff.policerAdd->streamIdx);
        retVal = mq_send(sendMqd, (char*) uBuff.policerAdd, sizeof(HOST_SWTStreamPolicerAddType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STREAM_POLICER_DEL:
        uBuff.policerDel->cmdRsp.rsp = HOST_CFPStreamPolicerDel(info, uBuff.policerDel->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.policerDel, sizeof(HOST_SWTStreamPolicerDelType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_BLOCK_STREAM:
        uBuff.blockStream->cmdRsp.rsp = HOST_CFPStreamBlock(info, uBuff.blockStream->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.blockStream, sizeof(HOST_SWTBlockStreamType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_RESUME_STREAM:
        uBuff.resumeStream->cmdRsp.rsp = HOST_CFPStreamResume(info, uBuff.resumeStream->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.resumeStream, sizeof(HOST_SWTResumeStreamType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STREAM_POLICER_SNAPSHOT:
        uBuff.snapshot->cmdRsp.rsp = HOST_CFPStreamPolicerSnapshot(info, &uBuff.snapshot->snapshot);
        retVal = mq_send(sendMqd, (char*) uBuff.snapshot, sizeof(HOST_SWTStreamPolicerSnapshotType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STREAM_POLICER_GET_STATUS:
        uBuff.policerGetStatus->cmdRsp.rsp = HOST_CFPStreamPolicerGetStatus(info, &uBuff.policerGetStatus->status);
        retVal = mq_send(sendMqd, (char*) uBuff.policerGetStatus, sizeof(HOST_SWTStreamPolicerGetStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STREAM_POLICER_FIND_IDX:
        uBuff.policerFindIdx->cmdRsp.rsp = HOST_CFPStreamPolicerFindIdx(info, uBuff.policerFindIdx->mac_addr,
                                                           uBuff.policerFindIdx->u16Val, uBuff.policerFindIdx->value1,
                                                           &uBuff.policerFindIdx->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.policerFindIdx, sizeof(HOST_SWTStreamPolicerFindIdxType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_VLAN_PORT_GET:
        uBuff.vlanGetPort->cmdRsp.rsp = HOST_EtherSwtVlanGet(info, uBuff.vlanGetPort->u16Val,
                                           &uBuff.vlanGetPort->value1, &uBuff.vlanGetPort->value2,
                                           &uBuff.vlanGetPort->value3);
        retVal = mq_send(sendMqd, (char*) uBuff.vlanGetPort, sizeof(HOST_SWTVLANGetPortType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_VLAN_PORT_ADD:
        uBuff.vlanAddPort->cmdRsp.rsp = HOST_EtherSwtVlanPortAdd(info, uBuff.vlanAddPort->u16Val,
                                           uBuff.vlanAddPort->value1, uBuff.vlanAddPort->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.vlanAddPort, sizeof(HOST_SWTVLANAddPortType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_VLAN_PORT_DEL:
        uBuff.vlanDelPort->cmdRsp.rsp = HOST_EtherSwtVlanPortDel(info, uBuff.vlanDelPort->u16Val,
                                                                 uBuff.vlanDelPort->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.vlanDelPort, sizeof(HOST_SWTVLANDelPortType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_PVID_SET:
        uBuff.pVidSet->cmdRsp.rsp = HOST_EtherSwtVlanPvidSet(info, uBuff.pVidSet->value1,
                                             uBuff.pVidSet->value2, uBuff.pVidSet->value3);
        retVal = mq_send(sendMqd, (char*) uBuff.pVidSet, sizeof(HOST_SWTPVidSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_IFILTER_GET:
        uBuff.iFilter->cmdRsp.rsp = HOST_EtherSwtVlanIfilterGet(info, &uBuff.iFilter->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.iFilter, sizeof(HOST_SWTiFilterType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_IFILTER_SET:
        uBuff.iFilter->cmdRsp.rsp = HOST_EtherSwtVlanIfilterSet(info, uBuff.iFilter->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.iFilter, sizeof(HOST_SWTiFilterType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_TC10_GET_WAKEUPMODE:
        uBuff.getWakeUpMode->cmdRsp.rsp = HOST_EtherSwtGetWakeupMode(info, uBuff.getWakeUpMode->port,
                                                                     &uBuff.getWakeUpMode->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.getWakeUpMode, sizeof(HOST_SWTGetWakeUpModeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_TC10_GET_WAKEUP_REASON:
        uBuff.getWakeRes->cmdRsp.rsp = HOST_EtherSwtGetWakeupReason(info, uBuff.getWakeRes->port,
                                                                     &uBuff.getWakeRes->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.getWakeRes, sizeof(HOST_SWTGetWakeUpReasonType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#ifdef ENABLE_ETHSWT_SECURITY
    case HOST_SWT_VLAN_HOPPING_DETECTION_SET:
        uBuff.vlanHoppingPtr->cmdRsp.rsp = HOST_EtherSwtSetVlanHoppingDetection(info, uBuff.vlanHoppingPtr->vlanHoppingAction);
        retVal = mq_send(sendMqd, (char*) uBuff.vlanHoppingPtr, sizeof(HOST_SWTVLAN_HoppingType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_VLAN_HOPPING_DETECTION_GET:
        uBuff.vlanHoppingPtr->cmdRsp.rsp = HOST_EtherSwtGetVlanHoppingDetection(info, &uBuff.vlanHoppingPtr->vlanHoppingAction);
        retVal = mq_send(sendMqd, (char*) uBuff.vlanHoppingPtr, sizeof(HOST_SWTVLAN_HoppingType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STATION_MOVE_DETECT_SET:
        uBuff.stationMovePtr->cmdRsp.rsp = HOST_EtherSwtSetStationMovementDetection(info,
                                             uBuff.stationMovePtr->port,
                                             uBuff.stationMovePtr->stationMoveAction);
        retVal = mq_send(sendMqd, (char*) uBuff.stationMovePtr, sizeof(HOST_SWTStationMovementType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STATION_MOVE_DETECT_GET:
        uBuff.stationMovePtr->cmdRsp.rsp = HOST_EtherSwtGetStationMovementDetection(info,
                                             uBuff.stationMovePtr->port,
                                             &uBuff.stationMovePtr->stationMoveAction);
        retVal = mq_send(sendMqd, (char*) uBuff.stationMovePtr, sizeof(HOST_SWTStationMovementType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STICKY_MAC_ADDRESS_SET:
        uBuff.stickyMACPtr->cmdRsp.rsp = HOST_EtherSwtSetMACAddressStickyToPort(info,
                                             uBuff.stickyMACPtr->port,
                                             uBuff.stickyMACPtr->stickyMACAction);
        retVal = mq_send(sendMqd, (char*) uBuff.stickyMACPtr, sizeof(HOST_SWTStickyMACType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_STICKY_MAC_ADDRESS_GET:
        uBuff.stickyMACPtr->cmdRsp.rsp = HOST_EtherSwtGetMACAddressStickyToPort(info,
                                             uBuff.stickyMACPtr->port,
                                             &uBuff.stickyMACPtr->stickyMACAction);
        retVal = mq_send(sendMqd, (char*) uBuff.stickyMACPtr, sizeof(HOST_SWTStickyMACType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ADDRESS_LIMITING_SET:
        uBuff.addrLimitPtr->cmdRsp.rsp = HOST_EtherSwtSetPortAddrLimiting(info,
                                             uBuff.addrLimitPtr->port,
                                             uBuff.addrLimitPtr->overLimitAction,
                                             uBuff.addrLimitPtr->macLearningLimit);
        retVal = mq_send(sendMqd, (char*) uBuff.addrLimitPtr, sizeof(HOST_SWTAddressLimitType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_ADDRESS_LIMITING_GET:
        uBuff.addrLimitPtr->cmdRsp.rsp = HOST_EtherSwtGetPortAddrLimitAndCounter(info,
                                             uBuff.addrLimitPtr->port,
                                             &uBuff.addrLimitPtr->overLimitAction,
                                             &uBuff.addrLimitPtr->macLearningLimit,
                                             &uBuff.addrLimitPtr->portLearnedCounter,
                                             &uBuff.addrLimitPtr->portOverLimitCounter);
        retVal = mq_send(sendMqd, (char*) uBuff.addrLimitPtr, sizeof(HOST_SWTAddressLimitType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_TOTAL_ADDRESS_LIMIT_SET:
        uBuff.totalAddressLimitptr->cmdRsp.rsp = HOST_EtherSwtSetTotalAddrLimit(info,
                                             uBuff.totalAddressLimitptr->totalMACLearningLimit);
        retVal = mq_send(sendMqd, (char*) uBuff.totalAddressLimitptr, sizeof(HOST_SWTTotalMACLearningLimitType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_TOTAL_ADDRESS_LIMIT_GET:
        uBuff.totalAddressLimitptr->cmdRsp.rsp = HOST_EtherSwtGetTotalAddrLimitAndCounter(info,
                                             &uBuff.totalAddressLimitptr->totalMACLearningLimit,
                                             &uBuff.totalAddressLimitptr->totalLearnedCounter);
        retVal = mq_send(sendMqd, (char*) uBuff.totalAddressLimitptr, sizeof(HOST_SWTTotalMACLearningLimitType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#endif /* ENABLE_ETHSWT_SECURITY */
#endif
    case HOST_INSTALL_MODE_ALL:
        buffer = buffer_from_file(uBuff.all->fileName, &buf_size);
        if (buffer != NULL) {
            uBuff.all->cmdRsp.rsp = HOST_SysFirmwareUpdate(info, INSTALL_MODE_ALL, buffer, buf_size);
            free(buffer);
        } else {
            uBuff.all->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.all, sizeof(HOST_InstallType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_INSTALL_MODE_CUSTOM:
        buffer = buffer_from_file(uBuff.custom->fileName, &buf_size);
        if (buffer != NULL) {
            uBuff.custom->cmdRsp.rsp = HOST_SysFirmwareUpdate(info, INSTALL_MODE_CUSTOM, buffer, buf_size);
            free(buffer);
        } else {
            uBuff.custom->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.custom, sizeof(HOST_InstallType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_FW_EXECUTE:
        buffer = buffer_from_file(uBuff.execute->fileName, &buf_size);
        if (buffer != NULL) {
            uBuff.execute->cmdRsp.rsp = HOST_SysFirmwareExecute(info, buffer, buf_size);
            free(buffer);
        } else {
            uBuff.execute->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.execute, sizeof(HOST_InstallType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ERASE_IMAGE:
        buffer = buffer_from_file(uBuff.erase->fileName, &buf_size);
        if (buffer != NULL) {
            uBuff.erase->cmdRsp.rsp = HOST_SysFlashErase(info, buffer, buf_size);
            free(buffer);
        } else {
            uBuff.erase->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.erase, sizeof(HOST_InstallType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_NVM_WRITE:
        buffer = buffer_from_file(uBuff.nvmWrite->fileName, &buf_size);
        if (buffer != NULL) {
            uBuff.nvmWrite->cmdRsp.rsp = HOST_NVMwrite(info, buffer, buf_size,
                                                             uBuff.nvmWrite->offSet,uBuff.nvmWrite->devID);
            free(buffer);
        } else {
            uBuff.nvmWrite->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.nvmWrite, sizeof(HOST_NVMWriteType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_NVM_ERASE:
        uBuff.nvmErase->cmdRsp.rsp = HOST_NVMErase(info, uBuff.nvmErase->offSet,
                                                             uBuff.nvmErase->size, uBuff.nvmErase->devID);
        retVal = mq_send(sendMqd, (char*) uBuff.nvmErase, sizeof(HOST_NVMEraseType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_NVM_READ:
        nvmRdData = malloc(uBuff.nvmRead->size);
        if (nvmRdData != NULL) {
            uBuff.nvmRead->cmdRsp.rsp = HOST_NVMRead(info, (uint8_t*)nvmRdData , uBuff.nvmRead->size,
                                                         uBuff.nvmRead->offSet,uBuff.nvmRead->devID);
            retVal = mq_send(sendMqd, (char*) uBuff.nvmRead, sizeof(HOST_NVMReadType), 1);
            if (-1 == retVal) {
                perror("mq_send");
            }
            if(BCM_ERR_OK == uBuff.nvmRead->cmdRsp.rsp) {
                nvmRdIdx = 0UL;
                nvmRdWrCnt = 0UL;
                nvmRdWrLen = 0UL;
                while(nvmRdIdx < uBuff.nvmRead->size) {
                    nvmRdWrCnt = uBuff.nvmRead->size - nvmRdIdx;
                    /* devide data into 460 Bytes per transfer */
                    if(0UL == (nvmRdWrCnt % 460UL)) {
                        nvmRdWrLen = 460UL;
                    } else {
                        nvmRdWrLen = nvmRdWrCnt % 460UL;
                    }
                    retVal = mq_send(sendMqd, &nvmRdData[nvmRdIdx], nvmRdWrLen, 1);
                    if (-1 == retVal) {
                        usleep(3000);
                        continue;
                    }
                    nvmRdIdx = nvmRdIdx + nvmRdWrLen;
                }
            } /* E_OK == uBuff.nvmRead->cmdRsp.rsp */
            free(nvmRdData);
        } else {
            uBuff.nvmRead->cmdRsp.rsp = BCM_ERR_INVAL_BUF_STATE;
            retVal = mq_send(sendMqd, (char*) uBuff.nvmRead, sizeof(HOST_NVMReadType), 1);
            if (-1 == retVal) {
                perror("mq_send");
            }
        }
        break;
    case HOST_SWT_REBOOT:
        HOST_SysReboot(info);
        uBuff.reboot->cmdRsp.rsp = BCM_ERR_OK;
        retVal = mq_send(sendMqd, (char*) uBuff.reboot, sizeof(HOST_InstallType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_VERSION:
        uBuff.version->cmdRsp.rsp = HOST_SysOSVersionGet(info, version);
        version[DMON_SW_VERSION_STR_LEN] = '\0';
        memcpy(uBuff.version->version,version,DMON_SW_VERSION_STR_LEN+1);
        retVal = mq_send(sendMqd, (char*) uBuff.version, sizeof(HOST_VersionType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    case HOST_ETS_GETGLOBALSTATUS:
        uBuff.etsGStatus->cmdRsp.rsp = HOST_ETSGetGlobalStatus(info, &uBuff.etsGStatus->status);
        retVal = mq_send(sendMqd, (char*) uBuff.etsGStatus, sizeof(HOST_EtsGlobalStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_GETDOMAINSTATUS:
        uBuff.etsDStatus->cmdRsp.rsp = HOST_ETSGetDomainStatus(info, uBuff.etsDStatus->domainStatus.num, &uBuff.etsDStatus->domainStatus.status);
        retVal = mq_send(sendMqd, (char*) uBuff.etsDStatus, sizeof(HOST_EtsDomainStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_GETPORTSTATUS:
        uBuff.etsPStatus->cmdRsp.rsp = HOST_ETSGetPortStatus(info, &uBuff.etsPStatus->portStatus);
        retVal = mq_send(sendMqd, (char*) uBuff.etsPStatus, sizeof(HOST_EtsPortStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_GETDOMAINPORTSTATUS:
        uBuff.etsPDStatus->cmdRsp.rsp = HOST_ETSGetPerDomainPortStatus(info, &uBuff.etsPDStatus->domainPortStatus);
        retVal = mq_send(sendMqd, (char*) uBuff.etsPDStatus, sizeof(HOST_EtsDomainPortStatusType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_SETGLOBALENABLE:
        uBuff.etsGEnable->cmdRsp.rsp = HOST_ETSSetGlobalEnable(info, uBuff.etsGEnable->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.etsGEnable, sizeof(HOST_EtsGlobalEnableType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_CLEARSTATS:
        uBuff.etsClr->cmdRsp.rsp = HOST_ETSClearPortStats(info, uBuff.etsClr->value1, uBuff.etsClr->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.etsClr, sizeof(HOST_EtsClearStatsType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_SETPORTENABLE:
        uBuff.etsPortEn->cmdRsp.rsp = HOST_ETSSetPortEnable(info, uBuff.etsPortEn->value1, uBuff.etsPortEn->value2, uBuff.etsPortEn->value3);
        retVal = mq_send(sendMqd, (char*) uBuff.etsPortEn, sizeof(HOST_EtsPortEnableSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_SETTIME:
        uBuff.etsTimeSet->cmdRsp.rsp = HOST_ETSSetTime(info, 0UL, uBuff.etsTimeSet->value1, uBuff.etsTimeSet->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.etsTimeSet, sizeof(HOST_EtsTimeSetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_GETVALIDATIONRECORD:
        uBuff.etsValidRec->cmdRsp.rsp = HOST_ETSGetRecord(uBuff.etsValidRec->value1, uBuff.etsValidRec->record, ETS_NUM_RECORDS_PER_INTF);
        retVal = mq_send(sendMqd, (char*) uBuff.etsValidRec, sizeof(HOST_EtsValidationRecordGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_ETS_STARTSTOP_VALIDATION:
        uBuff.etsValid->cmdRsp.rsp = HOST_ETSStartStopSendingRecord(info, uBuff.etsValid->isStart);
        retVal = mq_send(sendMqd, (char*) uBuff.etsValid, sizeof(HOST_EtsStartStopValidationType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#endif
#ifdef ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER
    case HOST_CFP_ADD_RULE:
        buffer = buffer_from_file(uBuff.cfpAdd->fileName, &buf_size);
        if (buffer != NULL) {
            if (buf_size == sizeof(ETHSWT_CFPConfigType)) {
                memcpy(&cfpConfig, buffer, buf_size);
                if (cfpConfig.magicId == uswap32(ETHSWT_CFP_CONFIG_MAGIC_ID)) {
                    cfpConfig.ruleList[0U].rowAndSlice = ((uBuff.cfpAdd->value1 << ETHSWT_CFP_ROWANDSLICE_ROW_SHIFT) & ETHSWT_CFP_ROWANDSLICE_ROW_MASK) |
                                                      ((uBuff.cfpAdd->value2 << ETHSWT_CFP_ROWANDSLICE_SLICE_SHIFT) & ETHSWT_CFP_ROWANDSLICE_SLICE_MASK);

                    /* Since the library is going to perform swap but the generated image is already in the target's endianness */
                    cfpConfig.ruleList[0].key.flags              = uswap32(cfpConfig.ruleList[0].key.flags);
                    cfpConfig.ruleList[0].key.flagsMask          = uswap32(cfpConfig.ruleList[0].key.flagsMask);
                    cfpConfig.ruleList[0].key.ingressPortBitmap  = uswap16(cfpConfig.ruleList[0].key.ingressPortBitmap);
                    cfpConfig.ruleList[0].key.cTagFlags          = uswap32(cfpConfig.ruleList[0].key.cTagFlags);
                    cfpConfig.ruleList[0].key.cTagMask           = uswap16(cfpConfig.ruleList[0].key.cTagMask);
                    cfpConfig.ruleList[0].key.sTagFlags          = uswap32(cfpConfig.ruleList[0].key.sTagFlags);
                    cfpConfig.ruleList[0].key.sTagMask           = uswap16(cfpConfig.ruleList[0].key.sTagMask);
                    for (i = 0UL; i < cfpConfig.ruleList[0].key.numEnabledUDFs; ++i) {
                        cfpConfig.ruleList[0].key.udfList[i].value  = uswap16(cfpConfig.ruleList[0].key.udfList[i].value);
                        cfpConfig.ruleList[0].key.udfList[i].mask  = uswap16(cfpConfig.ruleList[0].key.udfList[i].mask);
                    }

                    cfpConfig.ruleList[0].action.dstMapIBFlags      = uswap32(cfpConfig.ruleList[0].action.dstMapIBFlags);
                    cfpConfig.ruleList[0].action.dstMapOBFlags      = uswap32(cfpConfig.ruleList[0].action.dstMapOBFlags);
                    cfpConfig.ruleList[0].action.meter.cirTkBkt     = uswap32(cfpConfig.ruleList[0].action.meter.cirTkBkt);
                    cfpConfig.ruleList[0].action.meter.cirRefCnt    = uswap32(cfpConfig.ruleList[0].action.meter.cirRefCnt);
                    cfpConfig.ruleList[0].action.meter.cirBktSize   = uswap32(cfpConfig.ruleList[0].action.meter.cirBktSize);
                    cfpConfig.ruleList[0].action.meter.eirTkBkt     = uswap32(cfpConfig.ruleList[0].action.meter.eirTkBkt);
                    cfpConfig.ruleList[0].action.meter.eirRefCnt    = uswap32(cfpConfig.ruleList[0].action.meter.eirRefCnt);
                    cfpConfig.ruleList[0].action.meter.eirBktSize   = uswap32(cfpConfig.ruleList[0].action.meter.eirBktSize);

                    uBuff.cfpAdd->cmdRsp.rsp = HOST_CFPAddRule(info, &cfpConfig.ruleList[0U]);
                    if(BCM_ERR_OK == uBuff.cfpAdd->cmdRsp.rsp) {
                        memcpy(&uBuff.cfpAdd->ruleList, &cfpConfig.ruleList[0U], sizeof(cfpConfig.ruleList[0U]));
                    }
                }
            }
            free(buffer);
            buffer = NULL;
         }
        retVal = mq_send(sendMqd, (char*) uBuff.cfpAdd, sizeof(HOST_CFPAddRuleType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_CFP_DELETE_RULE:
        uBuff.cfpDel->cmdRsp.rsp = HOST_CFPDeleteRule(info, uBuff.cfpDel->value1);
        retVal = mq_send(sendMqd, (char*) uBuff.cfpDel, sizeof(HOST_CFPDeleteRuleType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_CFP_UPDATE_RULE:
        buffer = buffer_from_file(uBuff.cfpUpdate->fileName, &buf_size);
        if (buffer != NULL) {
            if (buf_size == sizeof(ETHSWT_CFPConfigType)) {
                memcpy(&cfpConfig, buffer, buf_size);
                if (cfpConfig.magicId == uswap32(ETHSWT_CFP_CONFIG_MAGIC_ID)) {
                    cfpConfig.ruleList[0].action.dstMapIBFlags      = uswap32(cfpConfig.ruleList[0].action.dstMapIBFlags);
                    cfpConfig.ruleList[0].action.dstMapOBFlags      = uswap32(cfpConfig.ruleList[0].action.dstMapOBFlags);
                    cfpConfig.ruleList[0].action.meter.cirTkBkt     = uswap32(cfpConfig.ruleList[0].action.meter.cirTkBkt);
                    cfpConfig.ruleList[0].action.meter.cirRefCnt    = uswap32(cfpConfig.ruleList[0].action.meter.cirRefCnt);
                    cfpConfig.ruleList[0].action.meter.cirBktSize   = uswap32(cfpConfig.ruleList[0].action.meter.cirBktSize);
                    cfpConfig.ruleList[0].action.meter.eirTkBkt     = uswap32(cfpConfig.ruleList[0].action.meter.eirTkBkt);
                    cfpConfig.ruleList[0].action.meter.eirRefCnt    = uswap32(cfpConfig.ruleList[0].action.meter.eirRefCnt);
                    cfpConfig.ruleList[0].action.meter.eirBktSize   = uswap32(cfpConfig.ruleList[0].action.meter.eirBktSize);
                    uBuff.cfpUpdate->cmdRsp.rsp = HOST_CFPUpdateRule(info, uBuff.cfpUpdate->value1, &cfpConfig.ruleList[0U].action);
                }
            }
            free(buffer);
            buffer = NULL;
        }
        retVal = mq_send(sendMqd, (char*) uBuff.cfpUpdate, sizeof(HOST_CFPUpdateRuleType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_CFP_GETSNAPSHOT:
        uBuff.cfpSnap->cmdRsp.rsp = HOST_CFPGetSnapshot(info, &uBuff.cfpSnap->snapShot, CFPRules);
        retVal = mq_send(sendMqd, (char*) uBuff.cfpSnap, sizeof(HOST_CFPGetSnapshotType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }

        swtEntryWrIdx  = 0;
        swtEntrySize = sizeof(ETHSWT_CFPEntrySnapshotType);
        swtEntryWrCnt = ( ETHSWT_CFP_MAX_RULES > ETHSWT_CFPRULELIST_MAX_RULES) ? ETHSWT_CFPRULELIST_MAX_RULES : ETHSWT_CFP_MAX_RULES;

        while(swtEntryWrIdx < ETHSWT_CFP_MAX_RULES) {
            retVal = mq_send(sendMqd, (char*) &CFPRules[swtEntryWrIdx], swtEntryWrCnt, 1);
            if (-1 == retVal) {
                usleep(3000);
                continue;
            }
            swtEntryWrIdx += (swtEntryWrCnt / swtEntrySize);
            if(ETHSWT_CFPRULELIST_MAX_RULES > (ETHSWT_CFP_MAX_RULES - swtEntryWrIdx)) {
                swtEntryWrCnt = swtEntrySize * (ETHSWT_CFP_MAX_RULES - swtEntryWrIdx) ;
            }
        }
        break;
    case HOST_CFP_GETROWCFG:
        uBuff.cfpRow->cmdRsp.rsp = HOST_CFPGetRowConfig(info, uBuff.cfpRow->value1, &uBuff.cfpRow->rowConfig);
        retVal = mq_send(sendMqd, (char*) uBuff.cfpRow, sizeof(HOST_CFPGetRowCfgType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_CFP_GETSTATS:
        uBuff.cfpStats->cmdRsp.rsp = HOST_CFPGetStats(info, uBuff.cfpStats->value1, &uBuff.cfpStats->stats);
        retVal = mq_send(sendMqd, (char*) uBuff.cfpStats, sizeof(HOST_CFPGetStatsType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_CFP_SET_PORTMODE:
        uBuff.cfpPort->cmdRsp.rsp = HOST_CFPSetPortMode(info, uBuff.cfpPort->value1, uBuff.cfpPort->value2);
        retVal = mq_send(sendMqd, (char*) uBuff.cfpPort, sizeof(HOST_CFPSetPortModeType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#endif /* ENABLE_HOST_ETHSWTM_CFP_CMD_HANDLER */
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
    case HOST_SWT_FA_ADD_FLOW:
        uBuff.faFlowAdd->cmdRsp.rsp = HOST_FAFlowAdd(info, &uBuff.faFlowAdd->flow,&uBuff.faFlowAdd->flowID);
        retVal = mq_send(sendMqd, (char*) uBuff.faFlowAdd, sizeof(HOST_SWTFAFlowAddType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_DEL_FLOW:
        uBuff.faFlowDel->cmdRsp.rsp = HOST_FAFlowDelete(info, uBuff.faFlowDel->flowID);
        retVal = mq_send(sendMqd, (char*) uBuff.faFlowDel, sizeof(HOST_SWTFAFlowDelType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_GET_FLOW:
        uBuff.faFlowGet->cmdRsp.rsp = HOST_FAFlowGet(info, uBuff.faFlowGet->flowID,
                                                 &uBuff.faFlowGet->flow, &uBuff.faFlowGet->stats);
        retVal = mq_send(sendMqd, (char*) uBuff.faFlowGet, sizeof(HOST_SWTFAFlowGetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_ADD_MAC:
        uBuff.faMacAdd->cmdRsp.rsp = HOST_FAMacAdd(info, &uBuff.faMacAdd->macOp);
        retVal = mq_send(sendMqd, (char*) uBuff.faMacAdd, sizeof(HOST_SWTFAMacOpType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_DEL_MAC:
    case HOST_SWT_FA_DEL_MAC_FORCE:
        /* Delete MAC OR Force Delete MAC */
        if(HOST_SWT_FA_DEL_MAC == uBuff.hdr->cmd) {
            uBuff.faMacDel->cmdRsp.rsp = HOST_FAMacDelete(info, &uBuff.faMacDel->macOp);
        } else {
            uBuff.faMacDel->cmdRsp.rsp = HOST_FAMacForceDelete(info, &uBuff.faMacDel->macOp);
        }
        retVal = mq_send(sendMqd, (char*) uBuff.faMacDel, sizeof(HOST_SWTFAMacOpType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_GET_MAC:
        uBuff.faMacSnap->cmdRsp.rsp = HOST_FAMacSnapshotGet(info, &uBuff.faMacSnap->snap);
        retVal = mq_send(sendMqd, (char*) uBuff.faMacSnap, sizeof(HOST_SWTFAMACSnapshotType ), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_GET_GLOBAL_STATS:
        uBuff.faStats->cmdRsp.rsp = HOST_FAStats(info, &uBuff.faStats->stats);
        retVal = mq_send(sendMqd, (char*) uBuff.faStats, sizeof(HOST_SWTFAStatsType ), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_GET_FLOW_STATUS:
        uBuff.faFlowStatus->cmdRsp.rsp = HOST_FAFlowStatus(info, &uBuff.faFlowStatus->status);
        retVal = mq_send(sendMqd, (char*) uBuff.faFlowStatus, sizeof(HOST_SWTFAFlowStatusType ), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_RESET:
        uBuff.faReset->cmdRsp.rsp = HOST_FAReset(info, &uBuff.faReset->ctf);
        retVal = mq_send(sendMqd, (char*) uBuff.faReset, sizeof(HOST_SWTFAResetType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SWT_FA_INTERRUPT:
        uBuff.faIntEn->cmdRsp.rsp = HOST_FAEnableInterrupt(info, uBuff.faIntEn->intFlag);
        retVal = mq_send(sendMqd, (char*) uBuff.faIntEn, sizeof(HOST_SWTFAIntEnType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#endif /* ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER `*/
#ifdef ENABLE_DBGMEM
    case HOST_MEM_READ:
        memHdl.u32Ptr = &memData;
        uBuff.memRead->cmdRsp.rsp = HOST_MemoryRead(info, uBuff.memRead->destn, uBuff.memRead->addr, uBuff.memRead->width, 1UL, memHdl.u8Ptr);
        if (uBuff.memRead->width == 8) {
            uBuff.memRead->data.u8data = (*memHdl.u8Ptr);
        } else if (uBuff.memRead->width == 16) {
            uBuff.memRead->data.u16data = (*memHdl.u16Ptr);
        } else if (uBuff.memRead->width == 32){
            uBuff.memRead->data.u32data = (*memHdl.u32Ptr);
        }
        retVal = mq_send(sendMqd, (char*) uBuff.memRead, sizeof(HOST_MemType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_MEM_WRITE:
        //convert to an array of "width" size starting at &data
        memHdl.u32Ptr = &memData;
        if (uBuff.memWrite->width == 8) {
            *memHdl.u8Ptr = uBuff.memWrite->data.u8data;
        } else if (uBuff.memWrite->width == 16) {
            *memHdl.u16Ptr = uBuff.memWrite->data.u16data;
        } else if (uBuff.memWrite->width == 32){
            *memHdl.u32Ptr = uBuff.memWrite->data.u32data;
        }
        uBuff.memWrite->cmdRsp.rsp = HOST_MemoryWrite(info, uBuff.memWrite->destn, uBuff.memWrite->addr, uBuff.memWrite->width, 1UL, memHdl.u8Ptr);
        retVal = mq_send(sendMqd, (char*) uBuff.memWrite, sizeof(HOST_MemType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
#endif /* ENABLE_DBGMEM */
    case HOST_REG_READ:
        uBuff.regAccess->cmdRsp.rsp = HOST_RegRead(info, uBuff.regAccess->addr, uBuff.regAccess->width, &uBuff.regAccess->data);
        retVal = mq_send(sendMqd, (char*) uBuff.regAccess, sizeof(HOST_RegType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_REG_WRITE:
        uBuff.regAccess->cmdRsp.rsp = HOST_RegWrite(info, uBuff.regAccess->addr, uBuff.regAccess->width, uBuff.regAccess->data);
        retVal = mq_send(sendMqd, (char*) uBuff.regAccess, sizeof(HOST_RegType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_GET_ACTIVE_SLAVES:
        HIPC_ProbeSlaves();
        uBuff.activeSlave->cmdRsp.rsp = HIPC_GetActiveSlaves(&uBuff.activeSlave->activeSpiId[0],&uBuff.activeSlave->count);
        retVal = mq_send(sendMqd, (char*) uBuff.activeSlave, sizeof(HOST_GetActiveSlavesType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_GET_SLAVE:
        uBuff.GetSlave->cmdRsp.rsp = HIPC_GetSlave(&uBuff.GetSlave->param);
        retVal = mq_send(sendMqd, (char*) uBuff.GetSlave, sizeof(HOST_GetSlaveType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SET_SLAVE:
        HIPC_ProbeSlaves();
        uBuff.SetSlave->cmdRsp.rsp = HIPC_SetSlave(uBuff.SetSlave->param);
        retVal = mq_send(sendMqd, (char*) uBuff.SetSlave, sizeof(HOST_SetSlaveType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_GET_CONN_MODE:
        uBuff.getConn->cmdRsp.rsp = HIPC_GetConnMode();
        retVal = mq_send(sendMqd, (char*) uBuff.getConn, sizeof(HOST_GetConnType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_SET_CONN_MODE:
        uBuff.setConn->cmdRsp.rsp = HIPC_SetConnMode(uBuff.setConn->mode);
        retVal = mq_send(sendMqd, (char*) uBuff.setConn, sizeof(HOST_SetConnType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    case HOST_KEEP_ALIVE:
        uBuff.keepAlive->cmdRsp.rsp = HOST_SysKeepAliveGet(info, uBuff.keepAlive->param, &uBuff.keepAlive->keepAlive);
        retVal = mq_send(sendMqd, (char*) uBuff.keepAlive, sizeof(HOST_KeepAliveType), 1);
        if (-1 == retVal) {
            perror("mq_send");
        }
        break;
    default:
        break;
    }
}

void print_usage(void)
{
    HOST_Log("------------------------------------------------------------------\n");
    HOST_Log("Required Arguments: \n");
    HOST_Log("            -c <chip>\n");
    HOST_Log("Optional Arguments: \n");
    HOST_Log("            -i [interface] \n");
    HOST_Log("            -s [serial/ip:port] \n\n");
    HOST_Log("<chip>      : bcm89571 bcm89572 bcm89561 bcm89564\n");
    HOST_Log("[interface] : spi pcie jlink \n");
    HOST_Log("[serial]    : Segger Serial Number for jlink or IP addr with Port e.g. 192.168.10.2:19210\n");
#ifdef HOST_PROCESSOR_X86
    HOST_Log("\nNote: Default interface is jlink\n");
#else
    HOST_Log("\nNote: Default interface is spi\n");
#endif
    HOST_Log("------------------------------------------------------------------\n");
}

int32_t confgiure_hipc(int argc, char *argv[])
{
    int retVal = BCM_ERR_OK;
    HIPC_IfcConfigType hipcIfcCfg;
    uint32_t i;
    uint8_t ipAddr[4];
    char * tempIp;

#ifdef HOST_PROCESSOR_X86
    hipcIfcCfg.mode = HIPC_INTERFACE_MODE_JLINK;
#else
    hipcIfcCfg.mode = HIPC_INTERFACE_MODE_SPI;
#endif
    hipcIfcCfg.serial = 0UL;
    hipcIfcCfg.devId = 0xFFFFFFFF;
    hipcIfcCfg.chip = 0xFFFFFFFF;

    if (argc >= 2) {
        for(i = 1; i < argc; i++) {
            if (0 == strcmp("-i", argv[i])) {
                i++;
                if (0 == strcmp("spi", argv[i])) {
                    hipcIfcCfg.mode = HIPC_INTERFACE_MODE_SPI;
                } else if (0 == strcmp("pcie", argv[i])) {
                    hipcIfcCfg.mode = HIPC_INTERFACE_MODE_PCIE;
                } else if (0 == strcmp("jlink", argv[i])) {
                    hipcIfcCfg.mode = HIPC_INTERFACE_MODE_JLINK;
                } else {
                    HOST_Log("Invalid Interface Name");
                    print_usage();
                    retVal = BCM_ERR_INVAL_PARAMS;
                    goto done;
                }
            } else if (0 == strcmp("-s", argv[i])) {
                i++;
                if (NULL == strchr(argv[i], ':')) {
                    /* Its segger serial number */
                    hipcIfcCfg.serial = atoi(argv[i]);
                    // HOST_Log("Segger Serial:%d\n", hipcIfcCfg.serial);
                } else {
                    /* Its segger ip address */
                    tempIp = strtok(argv[i], ":");
                    hipcIfcCfg.devId = atoi(strtok(NULL, ":"));
                    ipAddr[3] = atoi(strtok(tempIp, "."));
                    ipAddr[2] = atoi(strtok(NULL, "."));
                    ipAddr[1] = atoi(strtok(NULL, "."));
                    ipAddr[0] = atoi(strtok(NULL, "."));
                    hipcIfcCfg.serial = (ipAddr[3] << 24) | (ipAddr[2] << 16) | (ipAddr[1] << 8) | ipAddr[0];
                    // HOST_Log("Segger IP:%d.%d.%d.%d Port:%d\n", ipAddr[3], ipAddr[2], ipAddr[1], ipAddr[0], hipcIfcCfg.devId);
                }
            } else if (0 == strcmp("-c", argv[i])) {
                i++;
                if (0 == strcmp("bcm89571", argv[i])) {
                    hipcIfcCfg.chip = HIPC_CHIP_IDX_BCM89571;
                } else if (0 == strcmp("bcm89572", argv[i])) {
                    hipcIfcCfg.chip = HIPC_CHIP_IDX_BCM89572;
                } else if (0 == strcmp("bcm89561", argv[i])) {
                    hipcIfcCfg.chip = HIPC_CHIP_IDX_BCM89561;
                } else if (0 == strcmp("bcm89564", argv[i])) {
                    hipcIfcCfg.chip = HIPC_CHIP_IDX_BCM89564;
                } else {
                    HOST_Log("Invalid Chip Name");
                    print_usage();
                    retVal = BCM_ERR_INVAL_PARAMS;
                    goto done;
                }
            } else {
                print_usage();
                retVal = BCM_ERR_INVAL_PARAMS;
                goto done;
            }
        }
    }

    if (0xFFFFFFFF == hipcIfcCfg.chip) {
        print_usage();
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }

    HOST_Log("Hipc Interface Config bus:%d serial:%d \n", hipcIfcCfg.mode,
                                                         hipcIfcCfg.serial);

    retVal = HIPC_SetConfig(hipcIfcCfg);

done:
    return retVal;
}

/*@api
 * main
 *
 * @brief
 * Main function for handling CLI commands.
 *
 * @param=none
 * @returns 0
 *
 * @desc
 */
char input_bfr[MGMT_CMD_STR_MAX_LEN];
int32_t main(int argc, char *argv[])
{
    MgmtInfoType *info = &info_g;
    unsigned int param;
    int32_t retVal;
    mqd_t recvMqd = -1;
    mqd_t sendMqd = -1;
    static uint32_t firstRun = 1;
    fd_set rfds;
    struct timeval tv;
    struct mq_attr attr;
    struct mq_attr asyncAttr;
    uint32_t activeSpiId[4UL];
    uint32_t count = 4UL;
    char env[200] = "";
    char mqName[200];

    HOST_Log("\nVersion %s\n", SPIUTIL_IMAGE_VERSION);

    if (BCM_ERR_OK != confgiure_hipc(argc, argv)) {
        HOST_Log("Error: Could not confgiure hipc interface\n");
        goto done;
    }

    /* Initialize Managament API */
    retVal = HOST_SysInit(info);
    if (retVal != 0) {
        HOST_Log("Could not Initilaize management interface\n");
        goto done;
    }

    /* initialize the queue attributes */
    attr.mq_flags = 0;
    attr.mq_maxmsg = 10;
    attr.mq_msgsize = MGMT_CMD_STR_MAX_LEN-2;
    attr.mq_curmsgs = 0;

    asyncAttr.mq_flags = 0;
    asyncAttr.mq_maxmsg = 10;
    asyncAttr.mq_msgsize = ASYNCQ_MAX_LEN-2;
    asyncAttr.mq_curmsgs = 0;

    if (NULL != getenv("BCMUTIL_INSTANCE")) {
        sprintf(env, "_%s", getenv("BCMUTIL_INSTANCE"));
    }

    strcpy(mqName, HOST_RECV_MSGQ_NAME);
    strcat(mqName, env);
    sendMqd = mq_open(mqName, O_WRONLY | O_CREAT | O_NONBLOCK, 0666, &attr );
    if (sendMqd == -1) {
        perror("mq_open");
        goto done;
    }

    strcpy(mqName, HOST_SEND_MSGQ_NAME);
    strcat(mqName, env);
    recvMqd = mq_open(mqName, O_RDONLY | O_CREAT | O_NONBLOCK, 0666, &attr);
    if (recvMqd == -1) {
        perror("mq_open");
        goto done;
    }

    strcpy(mqName, HOST_ASYNC_MSGQ_NAME);
    strcat(mqName, env);
    asyncMqd = mq_open(mqName, O_WRONLY | O_CREAT | O_NONBLOCK, 0666, &asyncAttr);
    if (asyncMqd == -1) {
        perror("mq_open");
        goto done;
    }
    while (1) {
        FD_ZERO(&rfds);
        FD_SET(recvMqd, &rfds);

#ifdef ENABLE_RECORD_NOTIFICATION
        /* poll every 100ms */
        tv.tv_sec = 0;
        tv.tv_usec = 1000;
#else
        /* poll every sec */
        tv.tv_sec = 0;
        tv.tv_usec = 1000;
#endif

        if (firstRun) {
            /* Find active slaves */
            HIPC_ProbeSlaves();

            retVal = HIPC_GetActiveSlaves(&activeSpiId[0], &count);
            if (BCM_ERR_OK != retVal) {
                goto done;
            }

            if (count > 0) {
                retVal = HIPC_SetSlave(activeSpiId[0]);
                if (BCM_ERR_OK != retVal) {
                    HOST_Log("Probe: Failed to set slave ID:%u err:%d\n", __func__,
                        activeSpiId[0], retVal);
                } else {
                    HOST_Log("Probe: ID-%u is set\n", activeSpiId[0]);
                }
            } else {
                HOST_Log("Probe: No active slave ID found, set one explicitly\n");
            }

            /* Drain async messages here */
            Host_CheckAsyncMsg();
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
            retVal = HOST_EtherStackSync(info);
            if (BCM_ERR_OK != retVal) {
                /* HOST_Log("Error: Could not synchronise time\n"); */
                /* Continue processing, it is possible that the targets don't have a
                 * valid image in flash memory */
            } else {
                HOST_Log("Time synchronisation successful\n");
            }
#endif
            firstRun = 0;
        }
        /* Wait until we have an event */
        retVal = select(recvMqd + 1, &rfds, NULL, NULL, &tv);
        /* Drain async messages here */
        Host_CheckAsyncMsg();

        if (retVal == -1) {
            perror("select()");
        } else if (retVal) {
            if (FD_ISSET(recvMqd, &rfds)) {
                FD_CLR(recvMqd, &rfds);
                retVal = mq_receive(recvMqd, input_bfr, sizeof(input_bfr), &param);
                if (-1 == retVal) {
                    if (EAGAIN != errno) {
                        perror("mq_receive");
                        return retVal;
                    }
                }

                process_user_cmd(info, sendMqd, input_bfr);
            }
        }

    }

    HOST_SysDeinit(info);
done:
    if (-1 != recvMqd) {
        mq_close(recvMqd);
        if (-1 == errno) {
            perror("mq_close");
        }
    }
    if (-1 != sendMqd) {
        retVal = mq_close(sendMqd);
        if (-1 == retVal) {
            perror("mq_close");
        }
    }
    if (-1 != asyncMqd) {
        retVal = mq_close(asyncMqd);
        if (-1 == retVal) {
            perror("mq_close");
        }
    }

    /* unlink the message queue */
    if (-1 != sendMqd) {
        retVal = mq_unlink(HOST_RECV_MSGQ_NAME);
        if (-1 == retVal) {
            perror("mq_unlink");
        }
    }

    if (-1 != recvMqd) {
        retVal = mq_unlink(HOST_SEND_MSGQ_NAME);
        if (-1 == retVal) {
            perror("mq_unlink");
        }
    }

    if (-1 != asyncMqd) {
         retVal = mq_unlink(HOST_ASYNC_MSGQ_NAME);
        if (-1 == retVal) {
            perror("mq_unlink");
        }
    }

    return retVal;
}

int32_t IPC_QueueAsyncMsg(uint32_t currentSlave, uint32_t replyId, uint8_t *reply, uint32_t replyLen)
{
    int32_t retVal = BCM_ERR_OK;
    uint8_t notificationId;
    BCM_GroupIDType group;
    BCM_CompIDType comp;
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    HOST_AsyncNotificationType asyncMsgs;
#endif
    uint8_t *payLoad;
    uint32_t payLoadLen;

    if ((RPC_CMD_ASYNC_MASK != (replyId & RPC_CMD_ASYNC_MASK))
        || (reply == NULL)) {
        HOST_Log("%s Invalid parameters replyId:0x%x reply:%p len:%u\n",
            __func__, replyId, reply, replyLen);
        retVal = BCM_ERR_INVAL_PARAMS;
        goto done;
    }
    RPC_MemMsgType *asyncMemMsg = (RPC_MemMsgType*)reply;
    if(RPC_MEMMSG_MAGIC == uswap32(asyncMemMsg->magic)){
        payLoad  = asyncMemMsg->payload;
        /* replyLen is updated with actuval length from message */
        payLoadLen = uswap32(asyncMemMsg->len);
    } else {
        payLoad = reply;
        payLoadLen = replyLen;
    }
    group = (replyId & RPC_CMD_GROUP_MASK) >> RPC_CMD_GROUP_SHIFT;
    comp = (replyId & RPC_CMD_COMP_MASK) >> RPC_CMD_COMP_SHIFT;
    notificationId = (replyId & RPC_CMD_ID_MASK) >> RPC_CMD_ID_SHIFT;
    switch (group) {
    case BCM_GROUPID_SYS:
        retVal = HOST_SysNotificationHandler(currentSlave, comp, notificationId, payLoad, payLoadLen);
        break;
#ifdef ENABLE_HOST_ETHSWTM_CMD_HANDLER
    case BCM_GROUPID_ETHSRV:
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    if(BCM_ETS_ID == comp) {
        retVal = HOST_ETSNotificationHandler(currentSlave, notificationId, payLoad, payLoadLen);
     }
#endif
        asyncMsgs.currentSlave = currentSlave;
        asyncMsgs.comp = comp;
        asyncMsgs.replyId = replyId;
        asyncMsgs.notificationId = notificationId;
        asyncMsgs.size = payLoadLen;
        memcpy(asyncMsgs.msg,payLoad, payLoadLen);
        retVal = mq_send(asyncMqd, (char*) &asyncMsgs, sizeof(asyncMsgs), 1);
        if (-1 == retVal) {
            if(EAGAIN != errno) {
                perror("mq_send");
                return retVal;
            } else { /* Ignore if Queue is Full */
                retVal = BCM_ERR_OK;
            }
        }
        break;
#endif
    case BCM_GROUPID_IMGL:
        retVal = HOST_ImglNotificationHandler(currentSlave, comp, notificationId, payLoad, payLoadLen);
        break;
    default:
        HOST_Log("SPI-Id %u Invalid ID:0x%x\n", currentSlave, replyId);
        retVal = BCM_ERR_INVAL_PARAMS;
        break;
    }

done:
    return retVal;
}

static int32_t Host_CheckAsyncMsg()
{
    uint32_t i, j;
    int32_t retVal;
    uint32_t OriginalSpiId;
    uint32_t replyId = 0, len = 0;
    RPC_ResponseType resp;
    uint32_t activeSpiId[4UL];
    uint32_t count = 4UL;

    /* store current spi id */
    retVal = HIPC_GetSlave(&OriginalSpiId);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    retVal = HIPC_GetActiveSlaves(&activeSpiId[0], &count);
    if (BCM_ERR_OK != retVal) {
        goto done;
    }

    if (0UL == count) {
        HIPC_ProbeSlaves();

        count = 4UL;
        retVal = HIPC_GetActiveSlaves(&activeSpiId[0], &count);
        if (BCM_ERR_OK != retVal) {
            goto done;
        }
    }

    /* Get a maximum of one message from each active SPI Id. If there are
     * more, loop again */
    do {
        /* loop through valid Ids */
        for (i = 0; i < count; i++) {
            retVal = HIPC_SetSlave(activeSpiId[i]);
            if (BCM_ERR_OK != retVal) {
                continue;
            }

            /* check if there are any */
            retVal = HIPC_Recv(&replyId, (uint8_t *)&resp, sizeof(RPC_ResponseType), &len);
            if (retVal == BCM_ERR_OK) {
                if (RPC_CMD_ASYNC_MASK == (replyId & RPC_CMD_ASYNC_MASK)) {
                    /* process message */
                    retVal = IPC_QueueAsyncMsg(activeSpiId[i], replyId, (uint8_t *)&resp, len);
                    if (retVal != BCM_ERR_OK) {
                        HOST_Log("%s: Failed to Process Id:0x%x len:0x%x\n",
                                __func__, replyId, len);
                    }
                } else {
                    HOST_Log("%s Invalid reply ID: 0x%x\n", __func__, replyId);
                }
            } else {
                /* No messages with this ID, continue with the rest of Active Ids */
                count--;

                for (j = i; j < count; j++) {
                    activeSpiId[j] = activeSpiId[j + 1];
                }
                continue;
            }
        }
    } while (0UL != count);
    /* restore spi id */
    retVal = HIPC_SetSlave(OriginalSpiId);

done:
    return retVal;
}

void BCM_ReportError(uint16_t aCompID,
                     uint8_t aInstanceID,
                     uint16_t aApiID,
                     int32_t aErrorID,
                     uint32_t aNumInts,
                     const uint32_t *const aValues)
{
    printf("Error from comp %x\t apiID %x ret %x val = [%d %d %d %d] \n",aCompID,aApiID,aErrorID,*(aValues),*(aValues+1),*(aValues+2),*(aValues+3));
}
