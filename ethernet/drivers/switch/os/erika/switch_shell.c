
/*****************************************************************************
 Copyright 2016-2021 Broadcom Limited.  All rights reserved.
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
/** @defgroup grp_ethswt_shell_il
    @ingroup grp_ethswt
    @addtogroup grp_ethswt_shell_il
    @{
    @section sec_ethswt_shell_il Ethernet Switch Driver shell
    @file switch_shell.c
    @brief Ethernet Switch Driver Shell
    @version 0.1 Initial version
*/
#include "ee.h"
#include <string.h>
#include <ulog.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <eth_switch.h>
#include <console.h>
#include <osil/eth_switch_osil.h>
#include <board.h>
#include <switch_cfg.h>

/**
    @name LDC component Design IDs
    @{
    @brief Design IDs for LDC Component
*/
#define BRCM_SWDSGN_ETHSWT_CFG_USR_DATA_GLOBAL               (0xE101U)    /**< @brief #ETHSWT_CfgUsrData            */
#define BRCM_SWDSGN_ETHSWT_PORT_MIRROR_CFG_INGRESS_GLOBAL    (0xE102U)    /**< @brief #ETHSWT_PortMirrorCfgIngress  */
#define BRCM_SWDSGN_ETHSWT_PORT_MIRROR_CFG_EGRESS_GLOBAL     (0xE103U)    /**< @brief #ETHSWT_PortMirrorCfgEgress   */
#define BRCM_SWDSGN_ETHSWT_MIRROR_CAPTURE_PORT_GLOBAL        (0xE104U)    /**< @brief #ETHSWT_MirrorCapturePort     */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_CFG_LIST_IDX_PROC        (0xE105U)    /**< @brief #ETHSWT_GetPortCfgListIdx     */
#define BRCM_SWDSGN_ETHSWT_GET_PORT_CFG_PROC                 (0xE106U)    /**< @brief #ETHSWT_GetPortCfg            */
#define BRCM_SWDSGN_ETHSWT_GET_VLAN_PROC                     (0xE107U)    /**< @brief #ETHSWT_GetVLAN               */
#define BRCM_SWDSGN_ETHSWT_GET_VLAN_PORT_PROC                (0xE108U)    /**< @brief #ETHSWT_GetVLANPort           */
#define BRCM_SWDSGN_ETHSWT_JUMBO_FRM_GET_PROC                (0xE109U)    /**< @brief #ETHSWT_JumboFrmGet           */
#define BRCM_SWDSGN_ETHSWT_PRINT_RX_STATS_PROC               (0xE10AU)    /**< @brief #ETHSWT_PrintRxStats          */
#define BRCM_SWDSGN_ETHSWT_PRINT_TX_STATS_PROC               (0xE10BU)    /**< @brief #ETHSWT_PrintTxStats          */
#define BRCM_SWDSGN_ETHSWT_PRINT_SWITCH_CONFIG_PROC          (0xE10CU)    /**< @brief #ETHSWT_PrintSwitchConfig     */
#define BRCM_SWDSGN_ETHSWT_PRINT_MIRROR_CONFIG_PROC          (0xE10DU)    /**< @brief #ETHSWT_PrintMirrorConfig     */
#define BRCM_SWDSGN_ETHSWT_READ_ARL_TBL_PROC                 (0xE10EU)    /**< @brief #ETHSWT_ReadARLTbl            */
#define BRCM_SWDSGN_ETHSWT_SHELL_CONFIG_CMD_HANDLER_PROC     (0xE10FU)    /**< @brief #ETHSWT_ShellConfigCmdHandler */
#define BRCM_SWDSGN_ETHSWT_SHELL_MIRROR_CMD_HANDLER_PROC     (0xE110U)    /**< @brief #ETHSWT_ShellMirrorCmdHandler */
#define BRCM_SWDSGN_ETHSWT_SHELL_ARL_CMD_HANDLER_PROC        (0xE111U)    /**< @brief #ETHSWT_ShellARLCmdHandler    */
#define BRCM_SWDSGN_ETHSWT_SHELL_MISC_CMD_HANDLER_PROC       (0xE112U)    /**< @brief #ETHSWT_ShellMiscCmdHandler   */
#define BRCM_SWDSGN_ETHSWT_SHELL_PRINT_HELP_PROC             (0xE113U)    /**< @brief #ETHSWT_ShellPrintHelp        */
#define BRCM_SWDSGN_ETHSWT_SHELL_SWITCH_PROC                 (0xE114U)    /**< @brief #ETHSWT_Shell                 */
/** @} */

#define GetModuleLogLevel()     (ULOG_LVL_INFO)

/**
    @brief Switch config user data
    @trace #
*/
ETHSWT_CfgType ETHSWT_CfgUsrData;
/**
    @brief Port mirror config Ingress
    @trace #
*/
static ETHSWT_PortMirrorCfgType ETHSWT_PortMirrorCfgIngress;
/**
    @brief Port mirror config Egress
    @trace #
*/
static ETHSWT_PortMirrorCfgType ETHSWT_PortMirrorCfgEgress;
/**
    @brief Mirror capture port
    @trace #
*/
static uint32_t ETHSWT_MirrorCapturePort = ETHSWT_PORT_ID_MAX;
/**
    @brief Set port role
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aPortID     Port ID
    @param[inout]   aIdx        Pointer to index
    @retval         #BCM_ERR_OK             On Success
    @retval         #BCM_ERR_INVAL_PARAMS   aIdx is invalid
    @retval         #BCM_ERR_NOT_FOUND      If port ID is not found
    @post None
    @trace #
 */
static int32_t ETHSWT_GetPortCfgListIdx(uint32_t aPortID, uint32_t *const aIdx)
{
    int32_t retVal;
    uint32_t i;
    retVal = BCM_ERR_NOT_FOUND;
    if (NULL == aIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    for(i = 0UL; i< ETHSWT_CfgUsrData.portCfgListSz; ++i) {
        if (aPortID == ETHSWT_CfgUsrData.portCfgList[i].portID) {
            aIdx[0] = i;
            retVal = BCM_ERR_OK;
            break;
        }
    }
err:
    return retVal;
}
/**
    @brief Get port configuration
    @trace #BRCM_SWARCH_ETHSWT_GET_PORT_CFG_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetPortCfg(uint32_t aPortID,
                             ETHSWT_PortCfgType * const aPortCfg)
{
    int32_t retVal;
    uint32_t listIdx;
    if (NULL == aPortCfg) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    retVal = ETHSWT_GetPortCfgListIdx(aPortID, &listIdx);
    if (BCM_ERR_OK == retVal) {
        BCM_MemCpy((void *)aPortCfg,
                   (void *)&ETHSWT_CfgUsrData.portCfgList[listIdx],
                   sizeof(ETHSWT_PortCfgType));
    }
err:
    return retVal;
}
/**
    @brief Get VLAN
    @trace #BRCM_SWARCH_ETHSWT_GET_VLAN_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetVLAN(ETHER_VLANIDType aVLANID,
                          uint32_t * const aPortBitMap,
                          uint32_t * const aTagBitMap)
{
    int32_t retVal;
    uint32_t portCfgListIdx;
    uint32_t vlanMemListIdx;
    ETHSWT_PortCfgType * portCfg;
    portCfg = NULL;
    if ((NULL == aPortBitMap) || (NULL == aTagBitMap)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    aPortBitMap[0] = 0UL;
    aTagBitMap[0] = 0UL;
    for (portCfgListIdx = 0UL; portCfgListIdx < ETHSWT_CfgUsrData.portCfgListSz;
         ++portCfgListIdx) {
       portCfg = &ETHSWT_CfgUsrData.portCfgList[portCfgListIdx];
       for (vlanMemListIdx = 0UL; vlanMemListIdx < portCfg->vlanMemListSz;
            ++vlanMemListIdx) {
           if (aVLANID == portCfg->vlanMemList[vlanMemListIdx].vlanID) {
               aPortBitMap[0] |= (1UL << portCfg->portID);
               if (ETHSWT_VLAN_FRWRD_TAGGED == portCfg->vlanMemList[vlanMemListIdx].forward) {
                   aTagBitMap[0] |= (1UL <<  portCfg->portID);
               }
           }
       }
    }
    retVal = BCM_ERR_OK;
err:
    return retVal;
}
/**
    @brief Get VLAN port
    @trace #BRCM_SWARCH_ETHSWT_GET_VLAN_PORT_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_GetVLANPort(uint32_t aPortID, uint32_t * const aIngressFilter,
                              ETHER_VLANIDType * const aDefaultVLAN,
                              ETHSWT_PCPType * const aDefaultPrio)
{
    int32_t retVal;
    uint32_t portCfgListIdx;
    ETHSWT_PortCfgType * portCfg;
    portCfg = NULL;
    if ((NULL == aIngressFilter) || (NULL == aDefaultVLAN) || (NULL == aDefaultPrio)) {
        retVal = BCM_ERR_INVAL_PARAMS;
        goto err;
    }
    retVal = ETHSWT_GetPortCfgListIdx(aPortID, &portCfgListIdx);
    if (BCM_ERR_OK == retVal) {
        portCfg = &ETHSWT_CfgUsrData.portCfgList[portCfgListIdx];
        aDefaultVLAN[0] = portCfg->ingressCfg.defaultVLAN;
        aDefaultPrio[0] = portCfg->ingressCfg.defaultPrio;
        aIngressFilter[0] = 1UL;
    }
err:
    return retVal;
}
/**
    @brief Get jumbo frame
    @trace #BRCM_SWARCH_ETHSWT_JUMBO_FRM_GET_PROC
    @trace #BRCM_SWREQ_ETHSWT_QUERY
*/
int32_t ETHSWT_JumboFrmGet(uint32_t aPortID, uint32_t *const aJumboFrm)
{
    int32_t retVal;
    uint32_t idx;
    retVal = BCM_ERR_INVAL_PARAMS;
    if ((ETHSWT_PORT_ID_MAX <= aPortID)
        || (NULL == aJumboFrm)) {
        goto err;
    }
    retVal = ETHSWT_GetPortCfgListIdx(aPortID, &idx);
    if (BCM_ERR_OK == retVal) {
        aJumboFrm[0] = ETHSWT_CfgUsrData.portCfgList[idx].enableJumboFrm;
    }
err:
    return retVal;
}
/**
    @brief Print Rx statistics
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aRxStats    Pointer to Rx statistics
    @return None
    @post None
    @trace #
 */
static void ETHSWT_PrintRxStats(ETHER_RxStatsType *aRxStats)
{
    ULOG_ERR("*** RX PKT STATS ***\n");
    ULOG_ERR("\t brdCast: %d\n", aRxStats->brdCast);
    ULOG_ERR("\t multicast: %d\n", aRxStats->mutCast);
    ULOG_ERR("\t unicast: %d\n", aRxStats->uniCast);
    ULOG_ERR("\t pkts64: %d\n", aRxStats->pkts64);
    ULOG_ERR("\t pkts65_127: %d\n", aRxStats->pkts65_127);
    ULOG_ERR("\t pkts128_255: %d\n", aRxStats->pkts128_255);
    ULOG_ERR("\t pkts256_511: %d\n", aRxStats->pkts256_511);
    ULOG_ERR("\t pkts512_1023: %d\n", aRxStats->pkts512_1023);
    ULOG_ERR("\t pkts1024_1522: %d\n", aRxStats->pkts1024_1522);
    ULOG_ERR("\t pkts1523_2047: %d\n", aRxStats->pkts1523_2047);
    ULOG_ERR("\t pkts2048_4095: %d\n", aRxStats->pkts2048_4095);
    ULOG_ERR("\t pkts4096_8191: %d\n", aRxStats->pkts4096_8191);
    ULOG_ERR("\t pkts8192_MAX: %d\n", aRxStats->pkts8192_MAX);
    ULOG_ERR("\t pktsOvrSz: %d\n", aRxStats->pktsOvrSz);
    ULOG_ERR("\t pktsRxDrop: %d\n", aRxStats->pktsRxDrop);
    ULOG_ERR("\t pktsCrcErr: %d\n", aRxStats->pktsCrcErr);
    ULOG_ERR("\t pktsCrcAlignErr: %d\n", aRxStats->pktsCrcAlignErr);
    ULOG_ERR("\t pktsJabber: %d\n", aRxStats->pktsJabber);
    ULOG_ERR("\t pktsFrag: %d\n", aRxStats->pktsFrag);
    ULOG_ERR("\t pktsUndSz: %d\n", aRxStats->pktsUndSz);
    ULOG_ERR("\t pktsRxDiscard: %d\n", aRxStats->pktsRxDiscard);
}
/**
    @brief Print Tx statistics
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aRxStats    Pointer to Tx statistics
    @return None
    @post None
    @trace #
 */
static void ETHSWT_PrintTxStats(ETHER_TxStatsType *aTxStats)
{
    ULOG_ERR("*** TX PKT STATS ***\n");
    ULOG_ERR("\t octets: %d\n", aTxStats->octets);
    ULOG_ERR("\t brdCast: %d\n", aTxStats->brdCast);
    ULOG_ERR("\t multicast: %d\n", aTxStats->mutCast);
    ULOG_ERR("\t unicast: %d\n", aTxStats->uniCast);
    ULOG_ERR("\t txDropped: %d\n", aTxStats->txDropped);
    ULOG_ERR("\t txCollision: %d\n", aTxStats->txCollision);
    ULOG_ERR("\t txFrameInDiscard: %d\n", aTxStats->txFrameInDiscard);
}
/**
    @brief Print Switch configuration
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aPortID    Port ID
    @return None
    @post None
    @trace #
 */
static void ETHSWT_PrintSwitchConfig(uint32_t aPortID)
{
    uint32_t j;
    uint32_t portCfgListIdx;
    int32_t retVal;
    ETHSWT_PortCfgType *port;
    retVal = ETHSWT_GetPortCfgListIdx(aPortID, &portCfgListIdx);
    if (BCM_ERR_OK == retVal) {
        port = &ETHSWT_CfgUsrData.portCfgList[portCfgListIdx];
        ULOG_ERR("*** Switch Configuration ***\n");
        ULOG_ERR("*** PORT: %d***\n", port->portID);
        ULOG_ERR("role: %d\n", port->role);
        ULOG_ERR("xcvrID: %d\n", port->xcvrID);
        ULOG_ERR("enableTimeStamp: %d\n", port->enableTimeStamp);
        ULOG_ERR("enableJumboFrm: %d\n\n", port->enableJumboFrm);
        ULOG_ERR("**** Fixed MAC Addresses ****\n");
        for (j = 0; j < port->macAddrListSz; j++) {
            uint8_t *mac = &port->fixedMacAddrList[j][0];
            ULOG_ERR("\t%02x.%02x.%02x.%02x.%02x.%02x\n",
                    mac[0],
                    mac[1],
                    mac[2],
                    mac[3],
                    mac[4],
                    mac[5]);
        }
        ULOG_ERR("\n**** VLANs ****\n");
        ULOG_ERR("\tID \t forwardType\n");
        for (j = 0UL; j < port->vlanMemListSz; j++) {
            ULOG_ERR("\t%04x \t %02d\n", port->vlanMemList[j].vlanID,
                    port->vlanMemList[j].forward);
        }
        ULOG_ERR("\n**** Ingress configuration ****\n");
        ULOG_ERR("\tDefault VLAN: %04x\n", port->ingressCfg.defaultVLAN);
        ULOG_ERR("\tDefault priority: %d\n", port->ingressCfg.defaultPrio);
        ULOG_ERR("\tdrop untagged:%d\n", port->ingressCfg.dropUntagged);
        ULOG_ERR("\tfixed TC: %d\n", port->ingressCfg.tc);
        ULOG_ERR("\t**** PCP2TC MAP ****\n");
        ULOG_ERR("\tPCP\t\tTC\n");
        for (j = 0; j < 8UL; j++) {
            ULOG_ERR("\t%02d\t\t%02d\n", j, port->ingressCfg.pcp2tcMap[j]);
        }
        ULOG_ERR("\n**** Egress configuration ****\n");
        ULOG_ERR("\t**** TC2PCP MAP ****\n");
        ULOG_ERR("\tTC\t\tPCP\n");
        for (j = 0; j < 8UL; j++) {
            ULOG_ERR("\t%02d\t\t%02d\n", j, port->egressCfg.tc2pcpMap[j]);
        }
        ULOG_ERR("\t**** FIFO configuration ****\n");
        ULOG_ERR("\tID \t minLen \t tc \t rateBPS \t AVBShapingMode\n");
        for (j = 0; j < port->egressCfg.fifoListSz; j++) {
            ULOG_ERR("\t%02d \t %04d \t %02d %04d \t %02d\n", port->egressCfg.fifoList[j].id,
                    port->egressCfg.fifoList[j].minLen,
                    port->egressCfg.fifoList[j].tc,
                    port->egressCfg.fifoList[j].shaper.rateBps,
                    port->egressCfg.fifoList[j].shaper.avbShapingModeEn);
        }
    } else {
        ULOG_ERR("Error: Port %lu not found (%ld)\n", aPortID, retVal);
    }
}
/**
    @brief Print Mirror configuration
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConfig    Pointer to mirror configuration
    @return None
    @post None
    @trace #
 */
static void ETHSWT_PrintMirrorConfig(ETHSWT_PortMirrorCfgType *aConfig)
{
    ULOG_ERR("\tPortMask: 0x%x\n", aConfig->portMask);
    ULOG_ERR("\tpacketDivider: %d\n", aConfig->packetDivider);
    ULOG_ERR("\tsrcMacAddrFilter:");
    ULOG_ERR("%02x.%02x.%02x.%02x.%02x.%02x\n",
           aConfig->srcMacAddrFilter[0],
           aConfig->srcMacAddrFilter[1],
           aConfig->srcMacAddrFilter[2],
           aConfig->srcMacAddrFilter[3],
           aConfig->srcMacAddrFilter[4],
           aConfig->srcMacAddrFilter[5]);
    ULOG_ERR("\tdestMacAddrFilter:");
    ULOG_ERR("%02x.%02x.%02x.%02x.%02x.%02x\n",
            aConfig->destMacAddrFilter[0],
            aConfig->destMacAddrFilter[1],
            aConfig->destMacAddrFilter[2],
            aConfig->destMacAddrFilter[3],
            aConfig->destMacAddrFilter[4],
            aConfig->destMacAddrFilter[5]);
}
/**
    @brief Read ARL table
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      None
    @retval     #BCM_ERR_OK     On Success
    @retval     others          As returned by #ETHSWT_GetARLTable
    @post None
    @trace #
 */
static int32_t ETHSWT_ReadARLTbl(void)
{
    uint32_t i;
    int32_t ret;
    ETHSWT_ARLEntryType arlTbl[50];
    uint16_t arlTblSz = sizeof(arlTbl)/sizeof(ETHSWT_ARLEntryType);
    BCM_MemSet(arlTbl, 0x0, sizeof(arlTbl));
    ret = ETHSWT_GetARLTable(ETHSWT_HW_ID_0, arlTbl, &arlTblSz);
    if (ret != BCM_ERR_OK) {
        ULOG_ERR("ETHSWT_GetARLTable() returned error: %d\n", ret);
        goto err_exit;
    }
    ULOG_ERR("#### ARL Table #### \n");
    ULOG_ERR("MACADDR\t\t\t VLANID\t PortID\t Reserved\t\n");
    for (i = 0; i < arlTblSz; i++) {
        ULOG_ERR("%02x.%02x.%02x.%02x.%02x.%02x\t %04x\t %x\t %01x\t\n",
                arlTbl[i].macAddr[0],
                arlTbl[i].macAddr[1],
                arlTbl[i].macAddr[2],
                arlTbl[i].macAddr[3],
                arlTbl[i].macAddr[4],
                arlTbl[i].macAddr[5],
                arlTbl[i].vlanID,
                arlTbl[i].portMask,
                arlTbl[i].reserved);
    }
err_exit:
    return ret;
}
/**
    @brief Shell configuration command handler
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConsoleID          Console ID
    @param[in]      aArgString          Pointer to argument string
    @param[in]      aArgStringLen       String length
    @return         None
    @post None
    @trace #
 */
static void ETHSWT_ShellConfigCmdHandler(uint32_t aConsoleID, char* aArgString,
        uint32_t aArgStringLen)
{
    char *remain = NULL;
    uint32_t remLen = 0UL;
    char *endptr = NULL;
    uint32_t portID;
    CONSOLE_SplitLine(aArgString, aArgStringLen, &remain, &remLen);
    if (remLen == 0UL) {
        CONSOLE_Write(aConsoleID, "config show <portnum> ==> show switch configuration\n");
        goto err_exit;
    }
    if (0L == strncmp(remain, "show", 4UL)) {
        CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
        portID = strtoul(remain, &endptr, 0);
        ETHSWT_PrintSwitchConfig(portID);
    }
err_exit:
    return;
}
/**
    @brief Shell mirror command handler
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConsoleID          Console ID
    @param[in]      aArgString          Pointer to argument string
    @param[in]      aArgStringLen       String length
    @return         None
    @post None
    @trace #
 */
static void ETHSWT_ShellMirrorCmdHandler(uint32_t aConsoleID, char* aArgString,
        uint32_t aArgStringLen)
{
    char *remain = NULL;
    uint32_t remLen = 0UL;
    char *endptr = NULL;
    uint64_t srcMac;
    uint64_t destMac;
    uint32_t portMask;
    uint32_t divider;
    uint32_t capturePort;
    int32_t ret = BCM_ERR_OK;
    CONSOLE_SplitLine(aArgString, aArgStringLen, &remain, &remLen);
    if (remLen == 0UL) {
        CONSOLE_Write(aConsoleID, "mirror port <ingress/egress> <captureport> <portmask>     ==> Configure Capture traffic for ports\n");
        CONSOLE_Write(aConsoleID, "mirror filter mac <ingress/egress> <srcmac> <destmac>     ==> configure mirror filter for ingress/egress based on macaddr\n");
        CONSOLE_Write(aConsoleID, "mirror filter packetrate <ingress/egress> <divider>       ==> configure mirror filter for ingress/egress packet divider\n");
        CONSOLE_Write(aConsoleID, "mirror config show                                        ==> show mirror configuration\n");
        CONSOLE_Write(aConsoleID, "mirror <enable/disable>                                   ==> Enable/Disable port mirroring with configured values\n");
        goto err_exit;
    }
    if (0L == strncmp(remain, "port", 4UL)) {
        CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
        if (0L == strncmp(remain, "ingress", 7UL)) {
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            capturePort = strtoul(remain, &endptr, 0);
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            portMask = strtoul(remain, &endptr, 0);
            if (capturePort < ETHSWT_PORT_ID_MAX) {
                ETHSWT_PortMirrorCfgIngress.portMask = (uint16_t)portMask;
                ETHSWT_MirrorCapturePort = capturePort;
            }
        } else if (0L == strncmp(remain, "egress", 6UL)) {
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            capturePort = strtoul(remain, &endptr, 0);
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            portMask = strtoul(remain, &endptr, 0);
            if (capturePort < ETHSWT_PORT_ID_MAX) {
                ETHSWT_PortMirrorCfgEgress.portMask = (uint16_t)portMask;
                ETHSWT_MirrorCapturePort = capturePort;
            }
        } else {
            CONSOLE_Write(aConsoleID, "invalid option\n");
            goto err_exit;
        }
    } else if (0L == strncmp(remain, "filter", 6UL)) {
        CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
        if (0L == strncmp(remain, "mac", 3UL)) {
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            if (0L == strncmp(remain, "ingress", 7UL)) {
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                srcMac = strtoull(remain, &endptr, 0);
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                destMac = strtoull(remain, &endptr, 0);
                if ((srcMac != 0UL) && (destMac != 0UL)) {
                    CONSOLE_Write(aConsoleID, "cannot apply src/dest mac filter at same time\n");
                    goto err_exit;
                }
                if (srcMac != 0UL) {
                    ETHSWT_HWMAC2NMAC(srcMac, ETHSWT_PortMirrorCfgIngress.srcMacAddrFilter);
                } else if (destMac != 0UL) {
                    ETHSWT_HWMAC2NMAC(destMac, ETHSWT_PortMirrorCfgIngress.destMacAddrFilter);
                } else {
                    /* Handling default else case */
                }
            } else if (0L == strncmp(remain, "egress", 6UL)) {
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                srcMac = strtoull(remain, &endptr, 0);
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                destMac = strtoull(remain, &endptr, 0);
                if ((srcMac != 0UL) && (destMac != 0UL)) {
                    CONSOLE_Write(aConsoleID, "cannot apply src/dest mac filter at same time\n");
                    goto err_exit;
                }
                if (srcMac != 0UL) {
                    ETHSWT_HWMAC2NMAC(srcMac, ETHSWT_PortMirrorCfgEgress.srcMacAddrFilter);
                } else if (destMac != 0UL) {
                    ETHSWT_HWMAC2NMAC(destMac, ETHSWT_PortMirrorCfgEgress.destMacAddrFilter);
                } else {
                    /* Handling default else case */
                }
            } else {
                /* Handling default else case */
            }
        } else if (0L == strncmp(remain, "packetrate", 3UL)) {
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            if (0L == strncmp(remain, "ingress", 7UL)) {
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                divider = strtoul(remain, &endptr, 0);
                ETHSWT_PortMirrorCfgIngress.packetDivider = (uint16_t)divider;
            } else if (0L == strncmp(remain, "egress", 6UL)) {
                CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
                divider = strtoul(remain, &endptr, 0);
                ETHSWT_PortMirrorCfgEgress.packetDivider = (uint16_t)divider;
            } else {
                /* Handling default else case */
            }
        } else {
            /* Handling default else case */
        }
    } else if (0L == strncmp(remain, "enable", 9UL)) {
        if (ETHSWT_MirrorCapturePort < ETHSWT_PORT_ID_MAX) {
            if (ETHSWT_PortMirrorCfgIngress.portMask != 0UL) {
                ret = ETHSWT_SetPortMirrorConfig(0UL, ETHSWT_MirrorCapturePort,
                        ETHSWT_TRAFFICDIR_INGRESS,
                        &ETHSWT_PortMirrorCfgIngress);
            }
            if (ETHSWT_PortMirrorCfgEgress.portMask != 0UL) {
                ret = ETHSWT_SetPortMirrorConfig(0UL, ETHSWT_MirrorCapturePort,
                        ETHSWT_TRAFFICDIR_EGRESS,
                        &ETHSWT_PortMirrorCfgEgress);
            }
            if (ret == BCM_ERR_OK) {
                ret = ETHSWT_SetPortMirrorState(0UL, ETHSWT_MirrorCapturePort,
                        ETHSWT_PORTMIRRORSTATE_ENABLED);
                if (ret != BCM_ERR_OK) {
                    CONSOLE_Write(aConsoleID, "ETHSWT_SetPortMirrorState() failed\n");
                }
            } else {
                CONSOLE_Write(aConsoleID, "ETHSWT_SetPortMirrorConfig() failed\n");
            }
        }
    } else if (0L == strncmp(remain, "disable", 7UL)) {
        if (ETHSWT_MirrorCapturePort < ETHSWT_PORT_ID_MAX) {
            ret = ETHSWT_SetPortMirrorState(0UL, ETHSWT_MirrorCapturePort,
                    ETHSWT_PORTMIRRORSTATE_DISABLED);
            if (ret != BCM_ERR_OK) {
                CONSOLE_Write(aConsoleID, "ETHSWT_SetPortMirrorState() failed\n");
            }
        }
    } else  if (0L == strncmp(remain, "config", 6UL)) {
        CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
        if (0L == strncmp(remain, "show", 4UL)) {
            ULOG_ERR("Capture port: %d\n", ETHSWT_MirrorCapturePort);
            ULOG_ERR("**** Ingress Configuration ****\n");
            ETHSWT_PrintMirrorConfig(&ETHSWT_PortMirrorCfgIngress);
            ULOG_ERR("**** Egress Configuration ****\n");
            ETHSWT_PrintMirrorConfig(&ETHSWT_PortMirrorCfgEgress);
        }
    } else {
        /* Handling default else case */
    }
err_exit:
    return;
}
/**
    @brief Shell ARL command handler
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConsoleID          Console ID
    @param[in]      aArgString          Pointer to argument string
    @param[in]      aArgStringLen       String length
    @return         None
    @post None
    @trace #
 */
static void ETHSWT_ShellARLCmdHandler(uint32_t aConsoleID, char* aArgString,
        uint32_t aArgStringLen)
{
    char *remain = NULL;
    uint32_t remLen = 0UL;
    CONSOLE_SplitLine(aArgString, aArgStringLen, &remain, &remLen);
    if (remLen == 0UL) {
        CONSOLE_Write(aConsoleID, "arl dump                   ==> Dump ARL table\n");
        goto err_exit;
    }
    if (0L == strncmp(remain, "dump", 4UL)) {
        (void)ETHSWT_ReadARLTbl();
    }
err_exit:
    return;
}
/**
    @brief Shell Misc command handler
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConsoleID          Console ID
    @param[in]      aArgString          Pointer to argument string
    @param[in]      aArgStringLen       String length
    @return         None
    @post None
    @trace #
 */
static void ETHSWT_ShellMiscCmdHandler(uint32_t aConsoleID, char* aArgString,
        uint32_t aArgStringLen)
{
    char *remain = NULL;
    uint32_t remLen = 0UL;
    char *endptr = NULL;
    uint32_t portMask;
    uint32_t i;
    ETHER_RxStatsType rxstat;
    ETHER_TxStatsType txstat;
    int32_t ret;
    if (0L == strncmp(aArgString, "mibs", 4UL)) {
        CONSOLE_SplitLine(aArgString, aArgStringLen, &remain, &remLen);
        if (0L == strncmp(remain, "dump", 4UL)) {
            CONSOLE_SplitLine(remain, remLen, &remain, &remLen);
            portMask = strtoul(remain, &endptr, 0);
            for (i = 0UL; i < ETHSWT_PORT_ID_MAX; i++) {
                if ((portMask & (0x1UL << i)) != 0UL) {
                    ret = ETHSWT_GetRxStat(0UL, i, &rxstat);
                    if (ret == BCM_ERR_OK) {
                        ETHSWT_PrintRxStats(&rxstat);
                    }
                    ret = ETHSWT_GetTxStat(0UL, i, &txstat);
                    if (ret == BCM_ERR_OK) {
                        ETHSWT_PrintTxStats(&txstat);
                    }
                }
            }
        }
    }
}
/**
    @brief Shell print help
    @behavior Sync, Re-entrant
    @pre None
    @param[in]      aConsoleID          Console ID
    @return         None
    @post None
    @trace #
 */
static void ETHSWT_ShellPrintHelp(uint32_t aConsoleID)
{
    CONSOLE_Write(aConsoleID, "Switch Commands:\n");
    CONSOLE_Write(aConsoleID, "arl                               ==> manage ARL entries\n");
    CONSOLE_Write(aConsoleID, "mirror                            ==> manage mirror configuration\n");
    CONSOLE_Write(aConsoleID, "config                            ==> show/save/reset switch configuration\n");
    CONSOLE_Write(aConsoleID, "mibs dump <portmask>              ==> Dump mibs counter for ports\n");
}
void ETHSWT_Shell(uint32_t aConsoleID, char* aArgString, uint32_t aArgStringLen)
{
    if (NULL != aArgString) {
        if (0L == strncmp(aArgString, "arl", 3UL)) {
            ETHSWT_ShellARLCmdHandler(aConsoleID, aArgString, aArgStringLen);
        } else if (0L == strncmp(aArgString, "mirror", 6UL)) {
            ETHSWT_ShellMirrorCmdHandler(aConsoleID, aArgString, aArgStringLen);
        } else if (0L == strncmp(aArgString, "config", 6UL)) {
            ETHSWT_ShellConfigCmdHandler(aConsoleID, aArgString, aArgStringLen);
        } else if (0L == strncmp(aArgString, "qos", 3UL)) {
        } else {
            ETHSWT_ShellMiscCmdHandler(aConsoleID, aArgString, aArgStringLen);
        }
    } else {
        ETHSWT_ShellPrintHelp(aConsoleID);
    }
}
/** @} */
