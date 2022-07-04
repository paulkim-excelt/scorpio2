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

#ifndef SERVER_IFC_H
#define SERVER_IFC_H

#include <host_etherswt.h>
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
#include <host_ets.h>
#endif
#include <system_dmon.h>

/*typedef struct Req
{
    int command;
    ETHSWT_ExtPortInfoType portInfo;
} Req;
*/
#define HOST_RSVD                               (0xFF000000UL)
#define HOST_SWT_PORT_INFO                      (0xFF000001UL)
#define HOST_SWT_PORT_MIBS_CLR                  (0xFF000002UL)
#define HOST_SWT_PORT_MIBS                      (0xFF000003UL)
#define HOST_SWT_REG_READ                       (0xFF000004UL)
#define HOST_SWT_REG_WRITE                      (0xFF000005UL)
#define HOST_SWT_MDIO_READ                      (0xFF000006UL)
#define HOST_SWT_MDIO_WRITE                     (0xFF000007UL)
#define HOST_SWT_AGE_TIME_GET                   (0xFF000008UL)
#define HOST_SWT_AGE_TIME_SET                   (0xFF000009UL)
#define HOST_SWT_DMBFWD_GET                     (0xFF00000AUL)
#define HOST_SWT_DMBFWD_SET                     (0xFF00000BUL)
#define HOST_SWT_MIRROR_EN                      (0xFF00000CUL)
#define HOST_SWT_MIRROR_DIS                     (0xFF00000DUL)
#define HOST_SWT_MIRROR_STATUS                  (0xFF00000EUL)
#define HOST_SWT_ADMIN_GET                      (0xFF00000FUL)
#define HOST_SWT_ADMIN_SET                      (0xFF000010UL)
#define HOST_SWT_SPEED_GET                      (0xFF000011UL)
#define HOST_SWT_MASTERSLAVE_GET                (0xFF000012UL)
#define HOST_SWT_MASTERSLAVE_SET                (0xFF000013UL)
#define HOST_SWT_PHYLB_GET                      (0xFF000014UL)
#define HOST_SWT_PHYLB_SET                      (0xFF000015UL)
#define HOST_SWT_JUMBOFRAME_GET                 (0xFF000016UL)
#define HOST_SWT_JUMBOFRAME_SET                 (0xFF000017UL)
#define HOST_SWT_LINK_SQI_GET                   (0xFF000018UL)
#define HOST_SWT_CONV_MAC                       (0xFF000019UL)
#define HOST_SWT_ARL_GET                        (0xFF00001AUL)
#define HOST_SWT_ARL_ADD                        (0xFF00001BUL)
#define HOST_SWT_ARL_DEL                        (0xFF00001CUL)
#define HOST_SWT_STREAM_POLICER_ADD             (0xFF00001DUL)
#define HOST_SWT_STREAM_POLICER_DEL             (0xFF00001EUL)
#define HOST_SWT_BLOCK_STREAM                   (0xFF00001FUL)
#define HOST_SWT_RESUME_STREAM                  (0xFF000020UL)
#define HOST_SWT_STREAM_POLICER_SNAPSHOT        (0xFF000021UL)
#define HOST_SWT_STREAM_POLICER_GET_STATUS      (0xFF000022UL)
#define HOST_SWT_STREAM_POLICER_FIND_IDX        (0xFF000023UL)
#define HOST_SWT_VLAN_PORT_GET                  (0xFF000024UL)
#define HOST_SWT_VLAN_PORT_ADD                  (0xFF000025UL)
#define HOST_SWT_VLAN_PORT_DEL                  (0xFF000026UL)
#define HOST_SWT_PVID_SET                       (0xFF000027UL)
#define HOST_SWT_IFILTER_GET                    (0xFF000028UL)
#define HOST_SWT_IFILTER_SET                    (0xFF000029UL)
#define HOST_SWT_MGMTMODE_GET                   (0xFF00002AUL)
#define HOST_SWT_MGMTMODE_SET                   (0xFF00002BUL)
#define HOST_SWT_BRCMHDR_GET                    (0xFF00002CUL)
#define HOST_SWT_BRCMHDR_SET                    (0xFF00002DUL)

#define HOST_INSTALL_MODE_ALL                   (0XFF000030UL)
#define HOST_INSTALL_MODE_BL                    (0XFF000031UL)
#define HOST_INSTALL_MODE_CUSTOM                (0XFF000032UL)
#define HOST_ERASE_IMAGE                        (0XFF000033UL)
#define HOST_SWT_REBOOT                         (0XFF000034UL)
#define HOST_FW_EXECUTE                         (0XFF000035UL)
#define HOST_BL_EXECUTE                         (0XFF000036UL)
#define HOST_SWT_VERSION                        (0XFF000037UL)
#define HOST_NVM_WRITE                          (0xFF000038UL)
#define HOST_NVM_READ                           (0xFF000039UL)
#define HOST_NVM_ERASE                          (0xFF00003AUL)
#define HOST_SWT_TRAFFIC_STATE                  (0xFF00003BUL)

#define HOST_ETS_GETGLOBALSTATUS                (0xFF000040UL)
#define HOST_ETS_GETPORTSTATUS                  (0xFF000041UL)
#define HOST_ETS_SETGLOBALENABLE                (0xFF000042UL)
#define HOST_ETS_CLEARSTATS                     (0xFF000043UL)
#define HOST_ETS_SETPORTENABLE                  (0xFF000044UL)
#define HOST_ETS_SETTIME                        (0xFF000045UL)
#define HOST_ETS_GETVALIDATIONRECORD            (0xFF000046UL)
#define HOST_ETS_STARTSTOP_VALIDATION           (0xFF000047UL)
#define HOST_ETS_GETDOMAINSTATUS                (0xFF000048UL)
#define HOST_ETS_GETDOMAINPORTSTATUS            (0xFF000049UL)
#define HOST_ETS_SETDOMAINENABLE                (0xFF00004AUL)

#define HOST_CFP_ADD_RULE                       (0xFF000060UL)
#define HOST_CFP_DELETE_RULE                    (0xFF000061UL)
#define HOST_CFP_UPDATE_RULE                    (0xFF000062UL)
#define HOST_CFP_GETSNAPSHOT                    (0xFF000063UL)
#define HOST_CFP_GETROWCFG                      (0xFF000064UL)
#define HOST_CFP_GETSTATS                       (0xFF000065UL)
#define HOST_CFP_SET_PORTMODE                   (0xFF000066UL)

#define HOST_MEM_READ                           (0xFF000070UL)
#define HOST_MEM_WRITE                          (0xFF000071UL)
#define HOST_GET_ACTIVE_SLAVES                  (0xFF000072UL)
#define HOST_GET_SLAVE                          (0xFF000073UL)
#define HOST_SET_SLAVE                          (0xFF000074UL)
#define HOST_GET_CONN_MODE                      (0xFF000075UL)
#define HOST_SET_CONN_MODE                      (0xFF000076UL)
#define HOST_KEEP_ALIVE                         (0xFF000077UL)
#define HOST_REG_READ                           (0xFF000078UL)
#define HOST_REG_WRITE                          (0xFF000079UL)

#define HOST_SYS_FLASH_ERASE                    (0XFF000080UL)
#define HOST_SYS_OTP_READ                       (0xFF000081UL)
#define HOST_SYS_OTP_WRITE                      (0xFF000082UL)
#define HOST_SYS_OTP_ENABLE_SEC                 (0xFF000083UL)
#define HOST_SYS_OTP_KEY_WRITE                  (0xFF000084UL)
#define HOST_SYS_OTP_MAC_ADDR_WRITE             (0xFF000085UL)
#define HOST_SYS_OTP_MAC_ADDR_READ              (0xFF000086UL)

#define HOST_SWT_VLAN_HOPPING_DETECTION_SET     (0xFF000090UL)
#define HOST_SWT_VLAN_HOPPING_DETECTION_GET     (0xFF000091UL)
#define HOST_SWT_STATION_MOVE_DETECT_SET        (0xFF000092UL)
#define HOST_SWT_STATION_MOVE_DETECT_GET        (0xFF000093UL)
#define HOST_SWT_ADDRESS_LIMITING_SET           (0xFF000094UL)
#define HOST_SWT_ADDRESS_LIMITING_GET           (0xFF000095UL)
#define HOST_SWT_TOTAL_ADDRESS_LIMIT_SET        (0xFF000096UL)
#define HOST_SWT_TOTAL_ADDRESS_LIMIT_GET        (0xFF000097UL)
#define HOST_SWT_STICKY_MAC_ADDRESS_SET         (0xFF000098UL)
#define HOST_SWT_STICKY_MAC_ADDRESS_GET         (0xFF000099UL)

#define HOST_TC10_GET_WAKEUPMODE                (0xFF0000A0UL)
#define HOST_TC10_GET_WAKEUP_REASON             (0xFF0000A1UL)

#define HOST_SWT_FA_ADD_FLOW                    (0xFF0000B0UL)
#define HOST_SWT_FA_DEL_FLOW                    (0xFF0000B1UL)
#define HOST_SWT_FA_GET_FLOW                    (0xFF0000B2UL)
#define HOST_SWT_FA_ADD_MAC                     (0xFF0000B3UL)
#define HOST_SWT_FA_DEL_MAC                     (0xFF0000B4UL)
#define HOST_SWT_FA_DEL_MAC_FORCE               (0xFF0000B5UL)
#define HOST_SWT_FA_GET_MAC                     (0xFF0000B6UL)
#define HOST_SWT_FA_GET_GLOBAL_STATS            (0xFF0000B7UL)
#define HOST_SWT_FA_GET_FLOW_STATUS             (0xFF0000B8UL)
#define HOST_SWT_FA_RESET                       (0xFF0000B9UL)
#define HOST_SWT_FA_INTERRUPT                   (0xFF0000BAUL)


/*The Max Size of Message Queue in 512
Each ARLEntrie is 16 bytes
to avoid overflow each burst restricted to 31 Entries (31 * 16 = 496)*/

#define HOST_SWT_ARL_VOL_MSGQ           (31)

//ARL Data Macro
#define HOST_SEND_MSGQ_NAME          "/bcmSendMsgQ"
#define HOST_RECV_MSGQ_NAME          "/bcmReceiveMsgQ"
#define HOST_ASYNC_MSGQ_NAME         "/bcmAsyncMsgQ"

#define MGMT_CMD_STR_MAX_LEN    (512)
#define ASYNCQ_MAX_LEN          (1024)

#define MGMT_CMD_INT_PARSE_STATUS(status)  if(status != BCM_ERR_OK) {  \
    goto done;                                                         \
}                                                                      \

#define MGMT_AVB_TRACE_LINE(n)                         \
    do {                                               \
        uint32_t i;                                    \
        for (i=0; i < (n); i++) { HOST_Log("-"); }     \
        HOST_Log("\n");                                \
    } while(0)                                                  \

typedef union uHOST_ClientMemType {

    uint8_t u8data;
    uint16_t u16data;
    uint32_t u32data;

}HOST_ClientMemType;

typedef struct sHOST_CmdRspType {
    uint32_t cmd;
    uint32_t rsp;
}HOST_CmdRspType;

typedef struct sHOST_SWTPortInfoType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHSWT_ExtPortInfoType portInfo;
} HOST_SWTPortInfoType;

typedef struct sHOST_SWTPortMibsClrType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTPortMibsClrType;

typedef struct sHOST_SWTPortMibsType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHSWT_DebugMibType mibs;
} HOST_SWTPortMibsType;

typedef struct sHOST_SWTRegReadType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
    uint64_t u64Val;
} HOST_SWTRegReadType;

typedef struct sHOST_SWTRegWriteType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
    uint64_t u64Val;
} HOST_SWTRegWriteType;

typedef struct sHOST_SWTAgeTimeType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTAgeTimeType;

typedef struct sHOST_SWTMDIOType {
    HOST_CmdRspType cmdRsp;
    ETHER_MDIORegAccessType access;
    ETHER_MDIOSlaveAddrType phy;
    ETHER_MDIODeviceType dev;
    uint16_t u16Val;
    uint16_t u16Val2;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTMDIOType;

typedef struct sHOST_SWTDmbFwdType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTDmbFwdType;

typedef struct sHOST_SWTBrcmHdrType {
	HOST_CmdRspType cmdRsp;
	uint32_t value1;
} HOST_SWTBrcmHdrType;

typedef struct sHOST_SWTMgmtModeType {
	HOST_CmdRspType cmdRsp;
	uint32_t value1;
} HOST_SWTMgmtModeType;

typedef struct sHOST_SWTMirrorEnType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
    uint32_t value3;
    uint32_t value4;
} HOST_SWTMirrorEnType;

typedef struct sHOST_SWTMirrorDisType {
    HOST_CmdRspType cmdRsp;
} HOST_SWTMirrorDisType;

typedef struct sHOST_SWTMirrorStatusType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_PortMirrorStateType mirrorState;
    uint16_t u16Val;
    uint16_t u16Val2;
    uint32_t value1;
} HOST_SWTMirrorStatusType;

typedef struct sHOST_SWTAdmnGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHXCVR_ModeType mode;
} HOST_SWTAdmnGetType;

typedef struct sHOST_SWTAdminSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTAdminSetType;

typedef struct sHOST_SWTSpeedGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHXCVR_SpeedType speed;
} HOST_SWTSpeedGetType;

typedef struct sHOST_SWTMasterSlaveGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHXCVR_BooleanType mode;
} HOST_SWTMasterSlaveGetType;

typedef struct sHOST_SWTMasterSlaveSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTMasterSlaveSetType;

typedef struct sHOST_SWTPhyLBGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHXCVR_BooleanType mode;
} HOST_SWTPhyLBGetType;

typedef struct sHOST_SWTPhyLBSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTPhyLBSetType;

typedef struct sHOST_SWTJumboFrameGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETHXCVR_BooleanType jumbo;
} HOST_SWTJumboFrameGetType;

typedef struct sHOST_SWTJumboFrameSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTJumboFrameSetType;

typedef struct sHOST_SWTLinkSqiGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTLinkSqiGetType;

typedef struct sHOST_SWTConvMacType {
    HOST_CmdRspType cmdRsp;
    char str[18];
    int32_t result;
    uint8_t mac_addr[6];
} HOST_SWTConvMacType;

typedef struct sHOST_SWTARLGetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTARLGetType;

typedef struct sHOST_SWTARLAddType  {
    HOST_CmdRspType cmdRsp;
    uint8_t mac_addr[6];
    uint16_t u16Val;
    uint32_t value1;
} HOST_SWTARLAddType;

typedef struct sHOST_SWTARLDelType  {
    HOST_CmdRspType cmdRsp;
    uint8_t mac_addr[6];
    uint16_t u16Val;
} HOST_SWTARLDelType;

typedef struct sHOST_SWTStreamPolicerAddType {
    HOST_CmdRspType cmdRsp;
    uint16_t u16Val;
    uint8_t mac_addr[6];
    uint32_t rate;
    uint32_t burst;
    uint32_t src_mask;
    uint32_t threshold;
    uint32_t interval;
    uint32_t report;
    uint32_t block;
    uint32_t streamIdx;
}HOST_SWTStreamPolicerAddType;

typedef struct sHOST_SWTStreamPolicerDelType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
}HOST_SWTStreamPolicerDelType;

typedef struct sHOST_SWTBlockStreamType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
}HOST_SWTBlockStreamType;

typedef struct sHOST_SWTResumeStreamType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
}HOST_SWTResumeStreamType;

typedef struct sHOST_SWTStreamPolicerSnapshotType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPStreamPolicerSnapshotType snapshot;
}HOST_SWTStreamPolicerSnapshotType;

typedef struct sHOST_SWTStreamPolicerGetStatusType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPStreamPolicerStatusType status;
}HOST_SWTStreamPolicerGetStatusType;

typedef struct sHOST_SWTStreamPolicerFindIdxType {
    HOST_CmdRspType cmdRsp;
    uint8_t mac_addr[6];
    uint16_t u16Val;
    uint32_t value1;
    uint32_t value2;
}HOST_SWTStreamPolicerFindIdxType;

typedef struct sHOST_SWTVLANGetPortType {
    HOST_CmdRspType cmdRsp;
    uint16_t u16Val;
    uint32_t value1;
    uint32_t value2;
    uint32_t value3;
} HOST_SWTVLANGetPortType;

typedef struct sHOST_SWTVLANAddPortType {
    HOST_CmdRspType cmdRsp;
    uint16_t u16Val;
    uint32_t value1;
    uint32_t value2;
} HOST_SWTVLANAddPortType;

typedef struct sHOST_SWTVLANDelPortType {
    HOST_CmdRspType cmdRsp;
    uint16_t u16Val;
    uint32_t value1;
} HOST_SWTVLANDelPortType;

typedef struct sHOST_SWTGetWakeUpModeType {
        HOST_CmdRspType cmdRsp;
        uint8_t value1;
        uint32_t port;
} HOST_SWTGetWakeUpModeType;

typedef struct sHOST_SWTGetWakeUpReasonType {
	HOST_CmdRspType cmdRsp;
	uint8_t value1;
	uint32_t port;
} HOST_SWTGetWakeUpReasonType;

typedef struct sHOST_SWTPVidSetType {

    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
    uint32_t value3;
} HOST_SWTPVidSetType;

typedef struct sHOST_SWTTrafficStateType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTTrafficStateType;

typedef struct sHOST_SWTiFilterType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
} HOST_SWTiFilterType;

typedef struct sHOST_InstallType {
    HOST_CmdRspType cmdRsp;
    char fileName[250];
}HOST_InstallType;

typedef struct sHOST_NVMWriteType {
    HOST_CmdRspType cmdRsp;
    uint32_t devID;
    uint32_t offSet;
    char fileName[250];
}HOST_NVMWriteType;

typedef struct sHOST_NVMEraseType {
    HOST_CmdRspType cmdRsp;
    uint32_t devID;
    uint32_t offSet;
    uint32_t size;
    uint32_t noOfsec;
}HOST_NVMEraseType;

typedef struct sHOST_NVMReadTType {
    HOST_CmdRspType cmdRsp;
    uint32_t devID;
    uint32_t offSet;
    uint32_t size;
    char fileName[250];
}HOST_NVMReadType;

typedef struct sHOST_VersionType {
    HOST_CmdRspType cmdRsp;
    char version[DMON_SW_VERSION_STR_LEN + 1];
}HOST_VersionType;

#ifdef ENABLE_HOST_ETS_CMD_HANDLER
typedef struct sHOST_EtsPortStatusType {
    HOST_CmdRspType cmdRsp;
    ETS_PortNumAndStatusType portStatus;
}HOST_EtsPortStatusType;

typedef struct sHOST_EtsGlobalStatusType {
    HOST_CmdRspType cmdRsp;
    ETS_GlobalStatusType status;
}HOST_EtsGlobalStatusType;

typedef struct sHOST_EtsDomainStatusType {
    HOST_CmdRspType            cmdRsp;
    ETS_DomainNumAndStatusType domainStatus;
}HOST_EtsDomainStatusType;

typedef struct sHOST_EtsDomainPortStatusType {
    HOST_CmdRspType             cmdRsp;
    ETS_PerDomainPortStatusType domainPortStatus;
}HOST_EtsDomainPortStatusType;

typedef struct sHOST_EtsDomainEnableType {
    HOST_CmdRspType         cmdRsp;
    ETS_DomainEnableType    domainEnable;
}HOST_EtsDomainEnableType;

typedef struct sHOST_EtsGlobalEnableType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
}HOST_EtsGlobalEnableType;

typedef struct sHOST_EtsClearStatsType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    ETS_DomainType value2;
}HOST_EtsClearStatsType;

typedef struct sHOST_EtsPortEnableSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
    uint32_t value3;
}HOST_EtsPortEnableSetType;

typedef struct sHOST_EtsTimeSetType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
}HOST_EtsTimeSetType;

typedef struct sHOST_EtsValidationRecordGetType {
    HOST_CmdRspType cmdRsp;
    ETS_RecordType record[ETS_NUM_RECORDS_PER_INTF];
    uint32_t value1;
}HOST_EtsValidationRecordGetType;

typedef struct sHOST_EtsStartStopValidationType {
    HOST_CmdRspType cmdRsp;
    uint8_t isStart;
}HOST_EtsStartStopValidationType;
#endif

typedef struct sHOST_CFPAddRuleType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPRuleType ruleList;
    char fileName[250];
    uint32_t value1;
    uint32_t value2;
} HOST_CFPAddRuleType;

typedef struct sHOST_CFPDeleteRuleType {
    HOST_CmdRspType cmdRsp;
    char fileName[250];
    uint32_t value1;
} HOST_CFPDeleteRuleType;

typedef struct sHOST_CFPUpdateRuleType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    char fileName[250];
} HOST_CFPUpdateRuleType;

typedef struct sHOST_CFPGetSnapshotType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPTableSnapshotType snapShot;
} HOST_CFPGetSnapshotType;

typedef struct sHOST_CFPGetRowCfgType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPRuleType rowConfig;
    uint32_t value1;
} HOST_CFPGetRowCfgType;

typedef struct sHOST_CFPGetStatsType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_CFPStatsType stats;
    uint32_t value1;
} HOST_CFPGetStatsType;

typedef struct sHOST_CFPSetPortModeType {
    HOST_CmdRspType cmdRsp;
    uint32_t value1;
    uint32_t value2;
} HOST_CFPSetPortModeType;

typedef struct sHOST_MemType {
    HOST_CmdRspType cmdRsp;
    HOST_ClientMemType data;
    uint32_t destn;
    uint32_t addr;
    uint32_t width;
}HOST_MemType;

typedef struct sHOST_RegType {
    HOST_CmdRspType cmdRsp;
    uint64_t data;
    uint32_t addr;
    uint32_t width;
}HOST_RegType;

typedef struct sHOST_GetActiveSlavesType {
    HOST_CmdRspType cmdRsp;
    uint32_t activeSpiId[4UL];
    uint32_t count ;
}HOST_GetActiveSlavesType;

typedef struct sHOST_GetSlaveType {
    HOST_CmdRspType cmdRsp;
    unsigned int param;
}HOST_GetSlaveType;

typedef struct sHOST_SetSlaveType {
    HOST_CmdRspType cmdRsp;
    unsigned int param;
}HOST_SetSlaveType;

typedef struct sHOST_GetConnType {
    HOST_CmdRspType cmdRsp;
}HOST_GetConnType;

typedef struct sHOST_SetConnType {
    HOST_CmdRspType cmdRsp;
    mgmt_connection_t mode;
}HOST_SetConnType;

typedef struct sHOST_KeepAliveType {
    HOST_CmdRspType cmdRsp;
    unsigned int param;
    DMON_HeartBeatMsgType keepAlive;
}HOST_KeepAliveType;

typedef struct sHOST_FlashWriteType {
    HOST_CmdRspType cmdRsp;
    uint32_t address;
}HOST_FlashWriteType;

typedef struct sHOST_SysOtpReadType {
    HOST_CmdRspType cmdRsp;
    uint32_t row_num;
    uint32_t value;
}HOST_SysOtpReadType;

typedef struct sHOST_SysOtpWriteType {
    HOST_CmdRspType cmdRsp;
    uint32_t row_num;
    uint32_t data;
}HOST_SysOtpWriteType;

typedef struct sHOST_SysOtpEnableSecType {
    HOST_CmdRspType cmdRsp;
}HOST_SysOtpEnableSecType;

typedef struct sHOST_SysOtpKeyWriteType {
    HOST_CmdRspType cmdRsp;
    char fileName[250];
}HOST_SysOtpKeyWriteType;

typedef struct sHOST_SysOtpMacaddrWriteType {
    HOST_CmdRspType cmdRsp;
    uint8_t macaddr[6];
    uint32_t loc;
}HOST_SysOtpMacaddrWriteType;

typedef struct sHOST_SysOtpMacAddrReadType {
    HOST_CmdRspType cmdRsp;
    uint8_t macaddr1[6];
    uint8_t macaddr2[6];
    uint32_t value;
}HOST_SysOtpMacAddrReadType;

#ifdef ENABLE_ETHSWT_SECURITY
typedef struct sHOST_SWTVLAN_HoppingType {
    HOST_CmdRspType cmdRsp;
    ETHSWT_SecurityActionType  vlanHoppingAction;
} HOST_SWTVLAN_HoppingType;

typedef struct sHOST_SWTStationMovementType {
    HOST_CmdRspType cmdRsp;
    uint32_t                  port;
    ETHSWT_SecurityActionType stationMoveAction;
} HOST_SWTStationMovementType;

typedef struct sHOST_SWTStickyMACType {
    HOST_CmdRspType cmdRsp;
    uint32_t                   port;
    ETHSWT_SecurityActionType   stickyMACAction;
} HOST_SWTStickyMACType;

typedef struct sHOST_SWTAddressLimitType {
    HOST_CmdRspType cmdRsp;
    uint32_t                   port;
    ETHSWT_SecurityActionType  overLimitAction;
    uint16_t                   macLearningLimit;
    uint16_t                   portLearnedCounter;
    uint32_t                   portOverLimitCounter;
} HOST_SWTAddressLimitType;

typedef struct sHOST_SWTTotalMACLearningLimitType {
    HOST_CmdRspType cmdRsp;
    uint16_t       totalMACLearningLimit;
    uint16_t       totalLearnedCounter;
} HOST_SWTTotalMACLearningLimitType;
#endif /* ENABLE_ETHSWT_SECURITY */

#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
typedef struct sHOST_SWTFAFlowAdd {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAFlowIDType flowID;
    ETHSWT_FAFlowDataType flow;
} HOST_SWTFAFlowAddType;

typedef struct sHOST_SWTFAFlowDel {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAFlowIDType flowID;
} HOST_SWTFAFlowDelType;

typedef struct sHOST_SWTFAFlowGet {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAFlowIDType flowID;
    ETHSWT_FAFlowDataType flow;
    ETHSWT_FAFlowStatsType stats;
} HOST_SWTFAFlowGetType;

typedef struct sHOST_SWTFAStats {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAStatsType  stats;
} HOST_SWTFAStatsType;

typedef struct sHOST_SWTFAFlowStatus {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAFlowStatusDataType status;
} HOST_SWTFAFlowStatusType;

typedef struct sHOST_SWTFAMacOp {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAMacOperationType macOp;
} HOST_SWTFAMacOpType;

typedef struct sHOST_SWTFAMACSnapshot {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAMacSnapshotType snap;
} HOST_SWTFAMACSnapshotType;

typedef struct sHOST_SWTFAReset {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FACtfCfgType ctf;
} HOST_SWTFAResetType;

typedef struct sHOST_SWTFAIntEn {
    HOST_CmdRspType cmdRsp;
    ETHSWT_FAIntrFlagsType intFlag;
} HOST_SWTFAIntEnType;

#endif /* ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER  */

typedef struct sHOST_AsyncNotificationType {
    BCM_CompIDType comp;
    uint32_t replyId;
    uint32_t currentSlave;
    uint32_t size;
    uint8_t  msg[512];
    uint8_t notificationId;
}HOST_AsyncNotificationType;

typedef union uHOST_BufferType {
    char* ptr;
    HOST_CmdRspType* hdr;
    HOST_SWTPortInfoType* pInfo;
    HOST_SWTPortMibsClrType* mibsClr;
    HOST_SWTPortMibsType* mibs;
    HOST_SWTRegReadType* swtRegRead;
    HOST_SWTRegWriteType* swtRegWrite;
    HOST_SWTMDIOType* mdioRd;
    HOST_SWTMDIOType* mdioWr;
    HOST_SWTAgeTimeType* ageTime;
    HOST_SWTDmbFwdType* dmbFwd;
    HOST_SWTBrcmHdrType* brcmHdr;
    HOST_SWTMgmtModeType* mgmtMode;
    HOST_SWTMirrorEnType* mirrorEn;
    HOST_SWTMirrorDisType* mirrorDis;
    HOST_SWTMirrorStatusType* mirrorStatus;
    HOST_SWTAdmnGetType* adminGet;
    HOST_SWTAdminSetType* adminSet;
    HOST_SWTSpeedGetType* swtSpeedGet;
    HOST_SWTMasterSlaveGetType* masterSlaveGet;
    HOST_SWTMasterSlaveSetType* masterSlaveSet;
    HOST_SWTPhyLBGetType* phyLBGet;
    HOST_SWTPhyLBSetType* phyLBSet;
    HOST_SWTJumboFrameGetType* jumbpFrameGet;
    HOST_SWTJumboFrameSetType* jumboFrameSet;
    HOST_SWTLinkSqiGetType* linkSqiGet;
    HOST_SWTConvMacType* convMac;
    HOST_SWTARLGetType* arlGet;
    HOST_SWTARLAddType* arlAdd;
    HOST_SWTARLDelType* arlDel;
    HOST_SWTStreamPolicerAddType* policerAdd;
    HOST_SWTStreamPolicerDelType* policerDel;
    HOST_SWTBlockStreamType* blockStream;
    HOST_SWTResumeStreamType* resumeStream;
    HOST_SWTStreamPolicerSnapshotType* snapshot;
    HOST_SWTStreamPolicerGetStatusType* policerGetStatus;
    HOST_SWTStreamPolicerFindIdxType* policerFindIdx;
    HOST_SWTVLANGetPortType* vlanGetPort;
    HOST_SWTVLANAddPortType* vlanAddPort;
    HOST_SWTVLANDelPortType* vlanDelPort;
    HOST_SWTPVidSetType* pVidSet;
    HOST_SWTiFilterType* iFilter;
    HOST_InstallType* all;
    HOST_InstallType* custom;
    HOST_InstallType* erase;
    HOST_InstallType* reboot;
    HOST_InstallType* execute;
    HOST_NVMWriteType* nvmWrite;
    HOST_NVMEraseType* nvmErase;
    HOST_NVMReadType* nvmRead;
    HOST_VersionType* version;
    HOST_SWTTrafficStateType* traffic;
#ifdef ENABLE_HOST_ETS_CMD_HANDLER
    HOST_EtsPortStatusType* etsPStatus;
    HOST_EtsGlobalStatusType* etsGStatus;
    HOST_EtsGlobalEnableType* etsGEnable;
    HOST_EtsDomainStatusType * etsDStatus;
    HOST_EtsDomainEnableType * etsDEnable;
    HOST_EtsDomainPortStatusType * etsPDStatus;
    HOST_EtsClearStatsType* etsClr;
    HOST_EtsPortEnableSetType* etsPortEn;
    HOST_EtsTimeSetType* etsTimeSet;
    HOST_EtsValidationRecordGetType* etsValidRec;
    HOST_EtsStartStopValidationType* etsValid;
#endif
    HOST_SWTGetWakeUpModeType* getWakeUpMode;
    HOST_SWTGetWakeUpReasonType* getWakeRes;
    HOST_CFPAddRuleType* cfpAdd;
    HOST_CFPDeleteRuleType* cfpDel;
    HOST_CFPUpdateRuleType* cfpUpdate;
    HOST_CFPGetSnapshotType* cfpSnap;
    HOST_CFPGetRowCfgType* cfpRow;
    HOST_CFPGetStatsType* cfpStats;
    HOST_CFPSetPortModeType* cfpPort;
    HOST_MemType* memRead;
    HOST_MemType* memWrite;
    HOST_RegType* regAccess;
    HOST_GetActiveSlavesType* activeSlave;
    HOST_GetSlaveType* GetSlave;
    HOST_SetSlaveType* SetSlave;
    HOST_GetConnType* getConn;
    HOST_SetConnType* setConn;
    HOST_KeepAliveType* keepAlive;
    HOST_FlashWriteType* flsWrite;
    HOST_SysOtpReadType* sysOtpRd;
    HOST_SysOtpWriteType* sysOtpWr;
    HOST_SysOtpEnableSecType* sysOtpEn;
    HOST_SysOtpKeyWriteType* sysOtpKeyWr;
    HOST_SysOtpMacaddrWriteType* sysOtpMacWr;
    HOST_SysOtpMacAddrReadType* sysOtpMacRd;
    HOST_AsyncNotificationType* asyncMsgs;
#ifdef ENABLE_ETHSWT_SECURITY
    HOST_SWTVLAN_HoppingType*  vlanHoppingPtr;
    HOST_SWTStationMovementType* stationMovePtr;
    HOST_SWTStickyMACType* stickyMACPtr;
    HOST_SWTAddressLimitType* addrLimitPtr;
    HOST_SWTTotalMACLearningLimitType* totalAddressLimitptr;
#endif /* ENABLE_ETHSWT_SECURITY */
#ifdef ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER
    HOST_SWTFAFlowAddType*      faFlowAdd;
    HOST_SWTFAFlowDelType*      faFlowDel;
    HOST_SWTFAFlowGetType*      faFlowGet;
    HOST_SWTFAStatsType*        faStats;
    HOST_SWTFAFlowStatusType*   faFlowStatus;
    HOST_SWTFAMacOpType*        faMacAdd;
    HOST_SWTFAMacOpType*        faMacDel;
    HOST_SWTFAMACSnapshotType*  faMacSnap;
    HOST_SWTFAResetType*        faReset;
    HOST_SWTFAIntEnType*        faIntEn;
#endif /* ENABLE_HOST_ETHSWTM_FA_CMD_HANDLER  */
}HOST_BufferType;

#endif /*SERVER_IFC*/
