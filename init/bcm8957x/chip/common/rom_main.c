/*****************************************************************************
 Copyright 2020 Broadcom Limited.  All rights reserved.

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
    @defgroup grp_bcm8957x_rom_impl Implementation
    @ingroup grp_bcm8957x_rom

    @addtogroup grp_bcm8957x_rom_impl
    @{

    @file rom_main.c
    @brief ROM implementation

    @version 0.1 Initial version
*/

#include <stdint.h>
#include <mcu.h>
#include <mcu_clk.h>
#include <mcu_switch_ext.h>
#include <otp.h>
#include <bcm_comp.h>
#include <cache.h>
#include <cortex_mx.h>
#include <gpt.h>
#include <pinmux.h>
#include <cortex_mx.h>
#include <bcm_utils.h>
#include <ethernet.h>
#include <eth_switch.h>
#include <switch_cfg.h>
#include <nif.h>
#include <nif_bcm8957x_cfg_rom.h>
#include <inet.h>
#include <inet_osil.h>
#include <inet_cfg_rom.h>

#include <loader.h>
#include <flash_loader.h>
#include <ipc_loader.h>
#include <tftp_loader.h>
#include <rom_main.h>
#include <spum_lib.h>
#include <xcvr.h>
#include <tc10_fwd.h>
#include <otp_rdb.h>
#include <wdt.h>
#include <io_rdb.h>
#include <dbg_log.h>

#include <rpc.h>
#include <bcm_comp.h>
#include <bcm_time.h>
#include <eth_osil.h>
#include <io_rdb.h>
#include <cfg_rdb.h>

/**
    @name ROM Main Design IDs
    @{
    @brief Design IDs for ROM Main
*/
#define BRCM_SWDSGN_BCM8957X_DEV_MACRO                 (0xB201U)    /**< @brief #BCM8957X_DEV_GRP1_REGION_START */
#define BRCM_SWDSGN_BCM8957X_MEM_MACRO                 (0xB202U)    /**< @brief #BCM8957X_MEM_ITCM_REGION_START */
#define BRCM_SWDSGN_BCM8957X_MPU_TBL_ENTRY_TYPE        (0xB203U)    /**< @brief #BCM8957X_MpuTblEntryType       */
#define BRCM_SWDSGN_BCM8957X_DE_MEM_ATTRIB_MACRO       (0xB204U)    /**< @brief #BCM8957X_DEV_MEM_ATTRIB        */
#define BRCM_SWDSGN_BCM8957X_MPU_TBL_DEV_GLOBAL        (0xB205U)    /**< @brief #BCM8957X_MpuTblDevice          */
#define BRCM_SWDSGN_BCM8957X_MPU_TBL_MEM_GLOBAL        (0xB206U)    /**< @brief #BCM8957X_MpuTblMemory          */
#define BRCM_SWDSGN_BCM8957X_CLK_CFG_TBL_GLOBAL        (0xB207U)    /**< @brief #BCM8957X_ClkCfgTbl             */
#define BRCM_SWDSGN_BCM8957X_MCU_CONFIG_GLOBAL         (0xB208U)    /**< @brief #BCM8957X_McuConfig             */
#define BRCM_SWDSGN_BCM8957X_ETHER_CONFIG_GLOBAL       (0xB209U)    /**< @brief #BCM8957X_EtherConfig           */
#define BRCM_SWDSGN_BCM8957X_DEFAULT_MACADDR_GLOBAL    (0xB20AU)    /**< @brief #BCM8957X_DefaultMacAddr        */
#define BRCM_SWDSGN_BCM8957X_ROM_EARLY_INIT_PROC       (0xB20BU)    /**< @brief #BCM8957X_RomEarlyInit          */
#define BRCM_SWDSGN_BCM8957X_TIME_CFG_PROC             (0xB20CU)    /**< @brief #BCM8957X_TimeCfg               */
#define BRCM_SWDSGN_BCM8957X_ROM_MAIN_PROC             (0xB20DU)    /**< @brief #BCM8957X_RomMain               */
#define BRCM_SWDSGN_BCM8957X_ROM_ETHSWITCHINIT_PROC    (0xB20EU)    /**< @brief #BCM8957X_RomEthSwitchInit      */
#define BRCM_SWDSGN_BCM8957X_ROM_ETHSRVINIT_PROC       (0xB20FU)    /**< @brief #BCM8957X_RomEthSrvInit         */
#define BRCM_SWDSGN_BCM8957X_ROMREPORTERROR_PROC       (0xB210U)    /**< @brief #BCM8957X_RomReportError        */
#define BRCM_SWDSGN_BCM8957X_WDT_CONFIG_GLOBAL         (0xB211U)    /**< @brief #BCM8957X_WDTConfig             */
#define BRCM_SWDSGN_BCM8957X_XCVR_CONFIG_GLOBAL        (0xB212U)    /**< @brief #BCM8957X_XCVRConfig            */
#define BRCM_SWDSGN_BCM8957X_TC10_CONFIG_GLOBAL        (0xB213U)    /**< @brief #BCM8957X_TC10Config            */
#define BRCM_SWDSGN_BCM8957X_ROM_ETHSRVDEINIT_PROC     (0xB214U)    /**< @brief #BCM8957X_RomEthSrvDeInit       */
#define BRCM_SWDSGN_BCM8957X_HANDLE_TC10_PROC          (0xB215U)    /**< @brief #BCM8957X_HandleTC10            */
#define BRCM_SWDSGN_BCM8957X_RPC_BUFFER_GLOBAL         (0xB216U)    /**< @brief #BCM8957X_RpcBuffer             */
/** @} */

/**
    @name Device memory start addresses
    @{
    @brief Device memory start addresses

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BCM8957X_DEV_GRP1_REGION_START       (0x40100000UL)
#define BCM8957X_DEV_GRP2_REGION_START       (0x49000000UL)
#define BCM8957X_DEV_GRP3_REGION_START       (0x4A000000UL)
#define BCM8957X_DEV_GRP4_REGION_START       (0x4B000000UL)
#define BCM8957X_DEV_GRP5_REGION_START       (0x4B280000UL)
#define BCM8957X_DEV_GRP6_REGION_START       (0x4C000000UL)
/** @} */

/**
    @name Normal memory start addresses
    @{
    @brief Normal memory start addresses

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @note BCM8957X_MEM_DTCM_IPC_REGION_START is obtained from Makefile
*/
#define BCM8957X_MEM_ITCM_REGION_START           (0x00000000UL)
#define BCM8957X_MEM_DTCM_REGION_START           (0x20000000UL)
#define BCM8957X_MEM_SCRATCH0_REGION_START       (0x64000000UL)
#define BCM8957X_MEM_FLASH_REGION_START          (0x60000000UL)
/** @} */

/**
    MPU Table entry type

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
typedef struct sBCM8957X_MpuTblEntryType {
    uint32_t regionBaseAddr;
    uint32_t regionSz;
    uint32_t regionAttr;
} BCM8957X_MpuTblEntryType;

/**
@trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
@trace #BRCM_SWREQ_BCM8957X_ROM
*/
#define BCM8957X_DEV_MEM_ATTRIB   (CORTEX_MX_MPU_ATTRIB_TEX_0 | CORTEX_MX_MPU_ATTRIB_BUFFERABLE \
                            | CORTEX_MX_MPU_ATTRIB_PRIVILEGE | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC)

/**
    Device Memory Table for MPU configuration

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const BCM8957X_MpuTblEntryType BCM8957X_MpuTblDevice[] = {
    /**********************************************************************/
    /*  regionBaseAddr          SIZE            regionAttr
     *  **********************************************************************/
    {BCM8957X_DEV_GRP1_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K, BCM8957X_DEV_MEM_ATTRIB \
                                                              | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE \
                                                              | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE \
                                                              | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEV_GRP2_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_16M, BCM8957X_DEV_MEM_ATTRIB \
                                                              | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEV_GRP3_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_16M, BCM8957X_DEV_MEM_ATTRIB
                                                              | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE
                                                              | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE
                                                              | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_DEV_GRP4_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_128K, BCM8957X_DEV_MEM_ATTRIB},
    {BCM8957X_DEV_GRP5_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_32B,  BCM8957X_DEV_MEM_ATTRIB},
    {BCM8957X_DEV_GRP6_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_2M,   BCM8957X_DEV_MEM_ATTRIB \
                                                              | CORTEX_MX_MPU_ATTRIB_SR1_DISABLE \
                                                              | CORTEX_MX_MPU_ATTRIB_SR2_DISABLE \
                                                              | CORTEX_MX_MPU_ATTRIB_SR3_DISABLE},
};

/**
    Normal Memory Table for MPU configuration

    Any change made here must be reflected in the ld script as well

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const BCM8957X_MpuTblEntryType BCM8957X_MpuTblMemory[] =
{
    /**********************************************************************/
    /*  regionBaseAddr          SIZE            regionAttr
     *  **********************************************************************/
    {BCM8957X_MEM_ITCM_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_128K, CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                                           | CORTEX_MX_MPU_ATTRIB_READ_ONLY},
    {BCM8957X_MEM_ITCM_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K, CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                                          | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS \
                                                          | CORTEX_MX_MPU_ATTRIB_SR0_DISABLE \
                                                          | CORTEX_MX_MPU_ATTRIB_SR1_DISABLE},
    {BCM8957X_MEM_DTCM_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_512K, CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                                          | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS},
    {BCM8957X_MEM_DTCM_IPC_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_16K, CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                                          | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS \
                                                          | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC},
    {BCM8957X_MEM_SCRATCH0_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_64K, CORTEX_MX_MPU_ATTRIB_TEX_1
                                                          | CORTEX_MX_MPU_ATTRIB_FULL_ACCESS \
                                                          | CORTEX_MX_MPU_ATTRIB_NEVER_EXEC \
                                                          | CORTEX_MX_MPU_ATTRIB_SR5_DISABLE \
                                                          | CORTEX_MX_MPU_ATTRIB_SR6_DISABLE \
                                                          | CORTEX_MX_MPU_ATTRIB_SR7_DISABLE},
    {BCM8957X_MEM_FLASH_REGION_START, CORTEX_MX_MPU_ATTRIB_SIZE_2M, CORTEX_MX_MPU_ATTRIB_TEX_1 \
                                                          | CORTEX_MX_MPU_ATTRIB_READ_ONLY},
};

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
static const MCU_ClkCfgType BCM8957X_ClkCfgTbl[] = {
    {
        .cfgID = MCU_CLK_CFG_ID_QSPI0_SRC250_25MHZ,   /* QSPI @ 25MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_QSPI,
            .freq = BCM_FREQ_MHZ(25),
            .cntrl = {[0] = 0x2, [1] = 0x7},
        },
    },
    {
        .cfgID = MCU_CLK_CFG_ID_MDIO,   /* MDIO @ 100MHZ */
        .clkRef = {
            .clkID = MCU_CLK_ID_MDIO,
            .freq = BCM_FREQ_MHZ(100),
        },
    },
};

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const MCU_ConfigType BCM8957X_McuConfig = {
    .clkSrcFailNotification = MCU_CLK_SRC_NOTIFICATION_DIS,
    .clkCfgTbl = BCM8957X_ClkCfgTbl,
    .clkCfgTblSize = (sizeof(BCM8957X_ClkCfgTbl) / sizeof(MCU_ClkCfgType)),
    .ramCfgTbl = NULL,
    .ramCfgTblSize = 0UL,
};

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const TIM_ConfigType BCM8957X_TimeCfg = {
    .prescale = TIM_PRESCALE_DIV_1,
    .chanID = 0UL,
    .sysTimeEn = TRUE,
    .chanMode = TIM_CHAN_MODE_FREE_RUNNING,
    .width = TIM_WIDTH_32_BIT,
    .cb = NULL,
};

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
static uint8_t BCM8957X_DefaultMacAddr[6U];

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const WDT_CfgType BCM8957X_WDTConfig = {
        WDT_DISABLE_ALLOWED,
        WDT_MODE_OFF,
        10000UL,
};

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
static uint32_t BCM8957X_XCVRConfig[OTP_XCVR_CONFIG_SIZE / sizeof(uint32_t)];

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
static TC10_ConfigurationType BCM8957X_TC10Config;

/**
    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
const ETHER_CfgType BCM8957X_EtherConfig = {
    .hwID = ETHER_HW_ID_0,
    .speed = ETHER_SPEED_1000MBPS,
    .duplexMode = ETHER_DUPLEX_MODE_FULL,
    .maxRxFrmLen = (ETHER_MTU + 22UL),
    .macAddr = BCM8957X_DefaultMacAddr,
    .prioChanMap[0] = 0UL,
    .prioChanMap[1] = 0UL,
    .prioChanMap[2] = 0UL,
    .prioChanMap[3] = 0UL,
    .prioChanMap[4] = 0UL,
    .prioChanMap[5] = 0UL,
    .prioChanMap[6] = 0UL,
    .prioChanMap[7] = 0UL,
};

/** @brief Report an error

    This API is called by individual functions to report an error.

    @behavior Sync, Re-entrant

    @pre None

    @param[in]      aErr        Error to be reported
    @param[in]      aApiId      API identification
    @param[in]      aInfo0      Error information
    @param[in]      aInfo1      Error information
    @param[in]      aInfo2      Error information
    @param[in]      aLineNo     line number

    @return void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.c}
    values = {aInfo0, aInfo1, aInfo2, aLineNo}
    BCM_ReportError(BCM_ROM_ID, aInstanceID, API_ID, aErr, 4UL, values)
    @endcode
*/
static void BCM8957X_RomReportError(int32_t aErr, uint16_t aApiId,
                                    uint32_t aInfo0, uint32_t aInfo1,
                                    uint32_t aInfo2, uint32_t aLineNo)
{
    const uint32_t values[4] = {aInfo0, aInfo1, aInfo2, aLineNo};
    BCM_ReportError(BCM_ROM_ID, 0U, aApiId, aErr, 4UL, values);
}

/** @brief Switch Init Function

    Switch Init function for BCM8957x ROM.

    @behavior Sync, Non-reentrant

    @param[in]      aStackInfo       Pointer to switch config from OTP

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.c}
    ret = BCM_ERR_OK
    switchType = ETHSWT_SWITCH_STANDARD

    ETHSWT_Init(ETHSWT_HW_ID_0)

    if (aStackInfo->stackingEn == 1U) {
        if (MCU_DEVICE_MASTER == aStackInfo->mstSlvMode) {
            switchType = ETHSWT_SWITCH_LIGHTSTACK_MASTER
        } else {
            switchType = ETHSWT_SWITCH_LIGHTSTACK_SLAVE
        }

        if (aStackInfo->stackPort0 != 0U) {
            uplinkPortMap[uplinkPortCnt++] = aStackInfo->stackPort0
            ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType,
                               aStackInfo->stackPort0, ETHSWT_PORT_UP_LINK)
        }
        if (aStackInfo->stackPort1 != 0U) {
            uplinkPortMap[uplinkPortCnt++] = aStackInfo->stackPort1
            ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType,
                               aStackInfo->stackPort1, ETHSWT_PORT_UP_LINK)
        }
    }
    if (0U != aStackInfo->impPort) {
        ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType, aStackInfo->impPort,
                           ETHSWT_PORT_HOST)
    }

    ETHSWT_SetSwitchType(ETHSWT_HW_ID_0, switchType, uplinkPortCnt, uplinkPortMap)

    ret = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, 0x1FFU, 1U, 0x0U)
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret)
    }
    if (1U == aStackInfo->stackingEn) {
        uint32_t portMask = 0x80UL
        for (idx = 0UL idx < uplinkPortCnt idx++) {
            portMask |= (1U << uplinkPortMap[idx])
        }
        ret = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, portMask,
                                  aStackInfo->vlan, portMask)
        if (BCM_ERR_OK != ret) {
            BCM8957X_RomReportError(ret)
        }
    }

    ret = ETHSWT_MgmtInit(ETHSWT_HW_ID_0)
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret)
    }
    @endcode
*/
static void BCM8957X_RomEthSwitchInit(const OTP_SwtCfgType *const aStackInfo)
{
    int32_t ret = BCM_ERR_OK;
    ETHSWT_SwitchType switchType = ETHSWT_SWITCH_STANDARD;
    uint32_t uplinkPortCnt = 0UL;
    uint32_t uplinkPortMap[ETHSWT_PORT_ID_MAX] = {0UL};
    uint32_t idx;

    ETHSWT_Init(ETHSWT_HW_ID_0);

    if (aStackInfo->stackingEn == 1U) {
        if (MCU_DEVICE_MASTER == aStackInfo->mstSlvMode) {
            switchType = ETHSWT_SWITCH_LIGHTSTACK_MASTER;
        } else {
            switchType = ETHSWT_SWITCH_LIGHTSTACK_SLAVE;
        }

        if (aStackInfo->stackPort0 != 0U) {
            uplinkPortMap[uplinkPortCnt++] = aStackInfo->stackPort0;
            ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType, aStackInfo->stackPort0, ETHSWT_PORT_UP_LINK);
        }
        if (aStackInfo->stackPort1 != 0U) {
            uplinkPortMap[uplinkPortCnt++] = aStackInfo->stackPort1;
            ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType, aStackInfo->stackPort1, ETHSWT_PORT_UP_LINK);
        }
        DBG_LogStatus(DBG_LOG_SWT_SET_UPLINK_PORT);
    }

    /* IMP port */
    if (0U != aStackInfo->impPort) {
        ETHSWT_SetPortRole(ETHSWT_HW_ID_0, switchType, aStackInfo->impPort, ETHSWT_PORT_HOST);
    }

    ETHSWT_SetSwitchType(ETHSWT_HW_ID_0, switchType, uplinkPortCnt, uplinkPortMap);
    DBG_LogStatus(DBG_LOG_SWT_SET_TYPE);

    /* Add all ports (including port 7) to VLAN 1 to ensure untagged IP traffic is received. This is required for Ethernet boot  */
    ret = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, 0x1FFU, 1U, 0x0U);
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSWITCHINIT_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_SWT_ADD_VLAN_UNTAGGED);
    }

    if (1U == aStackInfo->stackingEn) {
        uint32_t portMask = 0x80UL;
        /* Create the test VLAN for inter-ARM communication. Only include port 7 and stacking link(s) */
        for (idx = 0UL; idx < uplinkPortCnt; idx++) {
            portMask |= (1U << uplinkPortMap[idx]);
        }
        ret = ETHSWT_AddVLANPorts(ETHSWT_HW_ID_0, portMask, aStackInfo->vlan, portMask);
        if (BCM_ERR_OK != ret) {
            BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSWITCHINIT_PROC,
                                     portMask, (uint32_t)aStackInfo->vlan, 0UL, __LINE__);
        } else {
            DBG_LogStatus(DBG_LOG_SWT_ADD_VLAN_PRIVATE);
        }
    }

    ret = ETHSWT_MgmtInit(ETHSWT_HW_ID_0);
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSWITCHINIT_PROC,
                                 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_SWT_MGMT_INIT);
    }

}

/** @brief Communication system Init Function

    Communication system initialization function for BCM8957x ROM.

    @behavior Sync, Non-reentrant

    @param[in]      aSwtCfg        Pointer to switch config
    @param[in]      aIPCfg         Pointer to IP config

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.c}
    INET_IPAddressAssignmentType    ipMode
    INET_IPAddressType              ipAddr
    INET_IPAddressType              netMask
    INET_IPAddressType              gwIP

    Update Default MAC address based on MCU config
    ETHER_Init(0, &BCM8957X_EtherConfig)
    ret = OTP_ReadMacAddr(0UL, macAddr)
    if (BCM_ERR_OK == ret) {
        ETHER_SetMacAddr(0, macAddr)
    }
    ETHER_SetMode(0, ACTIVE)

    Update the VLAN into NIF configuration
    if (0U != aSwtCfg->vlan) {
        NIF_CtrlVlanArray[0] = aSwtCfg->vlan
    } else {
        NIF_CtrlVlanArray[0] = BCM8957X_DEFAULT_VLAN
        aSwtCfg->vlan = BCM8957X_DEFAULT_VLAN
    }

    NIF_Init()
    INET_Init()

    if (stacking is not enabled OR if its a stacking Master)
        Initialize external interface
        Link TFTP end point to external interface
        Link DHCP end point to external interface
    if (stacking is enabled)
        Initialize internal interface
        if (stacking slave)
            Link TFTP end point to internal interface
        Link TC10 end point to internal interface

    BCM8957X_RomEthSwitchInit(&aCfg->swtInfo)
    @endcode
*/
static void BCM8957X_RomEthSrvInit(OTP_SwtCfgType* const aSwtCfg,
                                  OTP_IPCfgType* const aIPCfg)
{
    uint8_t                         macAddr[6UL] = {0};
    int32_t                         ret;
    INET_InterfaceVlanTagConfigType intfParams;
    INET_IPAddressAssignmentType    ipMode;
    INET_IPAddressType              ipAddr;
    INET_IPAddressType              netMask;
    INET_IPAddressType              gwIP;
    CFG_RDBType *cfg = (CFG_RDBType *)CFG_BASE;

    DBG_LogStatus(DBG_LOG_WAIT_FOR_SWITCH_INIT);
    while(0UL == (cfg->sw_if & CFG_SW_IF_SW_INIT_DONE_MASK));
    DBG_LogStatus(DBG_LOG_WAIT_FOR_SWITCH_INIT_DONE);

    /* Store the default MAC address */
    BCM8957X_DefaultMacAddr[0U] = 0x02U;
    BCM8957X_DefaultMacAddr[1U] = 0xAAU;
    BCM8957X_DefaultMacAddr[2U] = 0xBBU;
    BCM8957X_DefaultMacAddr[3U] = 0xCCU;
    BCM8957X_DefaultMacAddr[4U] = 0xDDU;
    BCM8957X_DefaultMacAddr[5U] = 0x00U;

    /* Update Default MAC address based on MCU config */
    if (1U == aSwtCfg->stackingEn) {
        if (1U == aSwtCfg->mstSlvMode) {
            BCM8957X_DefaultMacAddr[5U] = 0x01U;
        } else if (2U == aSwtCfg->mstSlvMode) {
            BCM8957X_DefaultMacAddr[5U] = 0x02U;
        }
    }

    ETHER_Init(ETHER_HW_ID_0, &BCM8957X_EtherConfig);
    DBG_LogStatus(DBG_LOG_ETHER_INIT);

    ret = OTP_ReadMacAddr(0UL, macAddr);
    if (BCM_ERR_OK == ret) {
        ETHER_SetMacAddr(ETHER_HW_ID_0, macAddr);
    }
    ETHER_SetMode(ETHER_HW_ID_0, ETHER_MODE_ACTIVE);

    /* Update the VLAN into NIF configuration & later call NIF_Init */
    if (0U != aSwtCfg->vlan) {
        NIF_CtrlVlanArray[0] = aSwtCfg->vlan;
    } else {
        /* Case when OTP is not filled */
        NIF_CtrlVlanArray[0] = BCM8957X_DEFAULT_VLAN;
        /* This VLAN needs to be added to switch during Switch Init */
        aSwtCfg->vlan = BCM8957X_DEFAULT_VLAN;
    }

    NIF_Init();
    DBG_LogStatus(DBG_LOG_NIF_INIT);

    INET_Init();
    DBG_LogStatus(DBG_LOG_INET_INIT);

    /* Case when stacking is not enabled OR if its a stacking Master */
    if ((0U == aSwtCfg->stackingEn) ||
        ((1U == aSwtCfg->stackingEn) &&
         (0U == aSwtCfg->mstSlvMode))) {
        intfParams.pcp = 0U;
        intfParams.vlan = 0U;

        /* Check OTP for external interface configuration */
        if (INET_IPADDRESS_INVALID == aIPCfg->ipAddr) {
            /* If OTP is not valid, use DHCP */
            ipMode = INET_IPADDRESSASSIGNMENT_DYNAMIC;
            ipAddr = INET_IPADDRESS_INVALID;
            netMask = INET_IPADDRESS_INVALID;
            gwIP = INET_IPADDRESS_INVALID;
        } else {
            /* Use OTP config */
            ipMode = INET_IPADDRESSASSIGNMENT_STATIC;
            ipAddr = aIPCfg->ipAddr;
            netMask = aIPCfg->netmask;
            gwIP = aIPCfg->gwIPAddr;
        }

        /* Initialize external interface */
        ret = INET_UpdateInterface(INET_ROM_IF_IDX_EXTERNAL, ipMode, ipAddr,
                                   netMask, gwIP, &intfParams);

        if (BCM_ERR_OK == ret) {
            /* Update the end points */
            ret = INET_SetEndPointInterface(BCM_NET_ID, INET_UDP_PAYLOAD_ID0, INET_ROM_IF_IDX_EXTERNAL);
            if (BCM_ERR_OK == ret) {
                ret = INET_SetEndPointInterface(BCM_TFT_ID, INET_UDP_PAYLOAD_ID0, INET_ROM_IF_IDX_EXTERNAL);
            }
        }

        if (BCM_ERR_OK != ret) {
            BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSRVINIT_PROC,
                                     0UL, 0UL, 0UL, __LINE__);
        }
    }

    if (1U == aSwtCfg->stackingEn) {
        /* Update internal interface for communication between master/slave */
        intfParams.pcp = 0U;
        intfParams.vlan = aSwtCfg->vlan;
        ret = INET_UpdateInterface(INET_ROM_IF_IDX_INTERNAL, INET_IPADDRESSASSIGNMENT_STATIC,
                                   BCM8957X_DEFAULT_IP_ADDR + aSwtCfg->mstSlvMode,
                                   BCM8957X_NETMASK_VALUE, BCM8957X_DEFAULT_IP_ADDR, &intfParams);
        /* Only for a stacking slave, update End point */
        if ((BCM_ERR_OK == ret) &&
            (1U == aSwtCfg->mstSlvMode)) {
            /* Update the end points */
            ret = INET_SetEndPointInterface(BCM_TFT_ID, INET_UDP_PAYLOAD_ID0, INET_ROM_IF_IDX_INTERNAL);
        }

        if (BCM_ERR_OK != ret) {
            BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSRVINIT_PROC,
                                     0UL, 0UL, 0UL, __LINE__);
        }
        ret = INET_SetEndPointInterface(BCM_RPC_ID, INET_UDP_PAYLOAD_ID0, INET_ROM_IF_IDX_INTERNAL);
        if (BCM_ERR_OK != ret) {
          BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSRVINIT_PROC,
                                   0UL, 0UL, 0UL, __LINE__);
        }
    }

    BCM8957X_RomEthSwitchInit(aSwtCfg);
    DBG_LogStatus(DBG_LOG_SWT_INIT);

    return;
}

/** @brief EthSrv deinit

    De-initialization of ethsrv systems.

    @behavior Sync, Non-reentrant

    @param  None

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.c}
    ret = ETHSWT_MgmtDeInit(ETHSWT_HW_ID_0)
    if ret is not BCM_ERR_OK
        report error

    ETHER_DeInit(ETHER_HW_ID_0)
    return
    @endcode
*/
static void BCM8957X_RomEthSrvDeInit(void)
{
    int32_t ret = ETHSWT_MgmtDeInit(ETHSWT_HW_ID_0);

    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_ROM_ETHSRVDEINIT_PROC,
                0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_SWT_DISABLE_CPU_PORT);
    }

    ETHER_DeInit(ETHER_HW_ID_0);
    DBG_LogStatus(DBG_LOG_ETHER_DEINIT);

    return;
}

/** @brief RPC Buffer for TC10 handling

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM
*/
uint8_t BCM8957X_RpcBuffer[RPC_MSG_PAYLOAD_DATA_SIZE + RPC_MAX_PAYLOAD_HDR_SIZE];

/** @brief TC10 handling Function

    TC10 handler function for BCM8957x ROM.

    @behavior Sync, Non-reentrant

    @param  None

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.c}
    RPC_ConfigType config
    TC10_IpcCmdType localInfo, remoteInfo;
    cmdRespCode = BCM_ERR_NOT_FOUND
    localInfo.forwardMap = 0
    remoteInfo.forwardMap = 0
    ret = TC10_CollectForwardMap(aTC10Cfg, &localInfo.forwardMap, aSwtCfg->mstSlvMode)
    if ret != ERR_OK
        DBG_LogStatus(TC10_COLLECT_ERROR)
        Report Error
    else
        DBG_LogStatus(TC10_COLLECT_SUCCESS)
    if aSwtCfg->stackingEn is TRUE
        config.ipcConfig.ipcChannelID = 0UL
        config.udpConfig.msgPayloadId = 0UL
        config.udpConfig.streamCount  = 0UL;
        config.udpConfig.portNum      = 8192U;
        if (MASTER == aSwtCfg->mstSlvMode)
            config.remoteIP = BCM8957X_DEFAULT_IP_ADDR + 1;
            config.mode = RPC_CHAN_MODE_MASTER;
        else
            config.remoteIP = BCM8957X_DEFAULT_IP_ADDR;
            config.mode = RPC_CHANMODE_SLAVE
        config.type = RPC_CHAN_UDP;
        config.maxRetryCnt = 6UL;
        config.retryInterval = 500UL;
        RPC_Init(RPC_CHANID_0, &config)
        if (MASTER == aSwtCfg->mstSlvMode)
            RPC_SendCmd(COLLECT, &localInfo)
        startTime = BCM_GetTimeNs()
        while ret is BCM_ERR_OK or EAGAIN or BUSY
            ETHER_IntIRQHandler(ETHER_HW_ID_0, &irqEventMap)
            ETHER_ProcessPkts(ETHER_HW_ID_0)
            INET_ProcessTimers()
            ret = RPC_Process(RPC_CHANID_0, &packet);
            if  ret is ERR_OK and packet == RPC_PACKET_MSG
                if (MASTER == aSwtCfg->mstSlvMode)
                    ret = RPC_RecvResp(&tmpCmd, BCM8957X_RpcBuffer)
                else
                    ret = RPC_RecvCmd(&tmpCmd, BCM8957X_RpcBuffer)
            if ret is ERR_OK and tmpcmd == COLLECT and (recived size is sizeof(remoteInfo))
                BCM_MemCpy((uint8_t*)&remoteInfo, BCM8957X_RpcBuffer, sizeof(remoteInfo));
                if (MASTER != aSwtCfg->mstSlvMode)
                    RPC_SendResp(COLLECT, &localInfo)
                else
                    break while loop
             if (BCM_GetTimeNs() - startTime) > (config.maxRetryCnt * config.retryInterval * 1000UL)
                 ret = ERR_TIME_OUT
        RPC_Deinit(RPC_CHANID_0)
        if tmpcmd == COLLECT
           localInfo.forwardMap |= remoteInfo.forwardMap
           DBG_LogStatus(TC10_SYNC_SUCCESS)
    ret = TC10_ApplyForwardMap(aTC10Cfg, localInfo.forwardMap, aSwtCfg->mstSlvMode)
    if ret != ERR_OK
        DBG_LogStatus(TC10_APPLY_ERROR)
        Report Error
    else
        DBG_LogStatus(TC10_APPLY_SUCCESS)
    @endcode
*/
static void BCM8957X_HandleTC10(const TC10_ConfigurationType* aTC10Cfg, const OTP_SwtCfgType *aSwtCfg)
{
    int32_t ret;
    RPC_ConfigType config;
    uint64_t startTime;
    uint64_t cmdHdl;
    TC10_IpcCmdType localInfo, remoteInfo;
    int32_t cmdRespCode = BCM_ERR_NOT_FOUND;
    localInfo.forwardMap = 0;
    remoteInfo.forwardMap = 0;
    ret = TC10_CollectForwardMap(aTC10Cfg, &localInfo.forwardMap, aSwtCfg->mstSlvMode);
    if (BCM_ERR_OK != ret) {
        DBG_LogStatus(DBG_LOG_COLLECT_TC10_FWD_FAILED);
        BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_HANDLE_TC10_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_COLLECT_TC10_FWD_SUCCESS);
    }
    if (TRUE == aSwtCfg->stackingEn) {
        uint32_t tmpCmd = 0UL;
        config.ipcConfig.ipcChannelID = 0UL;
        config.udpConfig.msgPayloadId = 0UL;
        config.udpConfig.streamCount  = 0UL;
        config.udpConfig.portNum      = 8192U;
        if (0UL == aSwtCfg->mstSlvMode) {
            config.udpConfig.remoteIP = BCM8957X_DEFAULT_IP_ADDR + 1;
            config.mode = RPC_CHAN_MODE_MASTER;
        } else {
            config.udpConfig.remoteIP = BCM8957X_DEFAULT_IP_ADDR;
            config.mode = RPC_CHAN_MODE_SLAVE;
        }
        config.type = RPC_CHAN_UDP;
        config.retryIntervalUs = 500UL; /* 500 us */
#ifdef BCM8956X_ENABLE_A0
        config.maxRetryCnt = 8000UL;
#else
        config.maxRetryCnt = 6UL;
#endif
        RPC_Init(RPC_CHANID_0, &config);
        if (0UL == aSwtCfg->mstSlvMode) {
            tmpCmd = BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_TCT_ID, TC10_IPC_CMD_COLLECT_APPLY);
            ret = RPC_SendCmd(RPC_CHANID_0,
                              tmpCmd,
                              (uint8_t*)&localInfo,
                              sizeof(localInfo),
                              &cmdHdl);
            if (BCM_ERR_OK != ret) {
                BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_HANDLE_TC10_PROC, 0UL, 0UL, 0UL, __LINE__);
            }
        }
        ret = BCM_ERR_OK;
        startTime = BCM_GetTimeNs();

        while ((BCM_ERR_OK == ret) ||  (BCM_ERR_EAGAIN == ret) || (BCM_ERR_BUSY == ret)) {
            uint32_t irqEventMap = 0UL;
            uint32_t len = RPC_MSG_PAYLOAD_DATA_SIZE;
            RPC_PacketType packet = 0UL;
            uint8_t *buffer = NULL;
            uint32_t bufferLen;

            ETHER_IntIRQHandler(ETHER_HW_ID_0, &irqEventMap);
            ETHER_ProcessPkts(ETHER_HW_ID_0);
            INET_ProcessTimers();

            ret = RPC_Process(RPC_CHANID_0, &packet);
            if ((BCM_ERR_OK == ret) &&
                (0UL != ((RPC_PACKET_MSG|RPC_PACKET_ASYNC) & packet))) {
                if (0UL == aSwtCfg->mstSlvMode) {
                    uint32_t asyncID;
                    if (0UL != (RPC_PACKET_MSG & packet)) {
                        ret = RPC_RecvResp(RPC_CHANID_0, &cmdHdl, BCM8957X_RpcBuffer, &len, &cmdRespCode);
                    } else if (0UL != (RPC_PACKET_ASYNC & packet)) {
                        ret = RPC_RecvAsync(RPC_CHANID_0, BCM8957X_RpcBuffer, &len, &asyncID);
                    } else {
                        /* Nothing */
                    }
                } else {
                    cmdRespCode = BCM_ERR_OK;
                    ret = RPC_RecvCmd(RPC_CHANID_0, &tmpCmd, &cmdHdl);
                    if (BCM_ERR_OK == ret) {
                        ret = RPC_GetBuffer(RPC_CHANID_0, cmdHdl, &buffer, &len);
                    }
                }
                if ((BCM_ERR_OK == ret)  && (sizeof(remoteInfo) == len)
                        && (BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_TCT_ID, TC10_IPC_CMD_COLLECT_APPLY) == tmpCmd)) {
                    if (BCM_ERR_OK == cmdRespCode) {
                        BCM_MemCpy((uint8_t*)&remoteInfo, buffer, sizeof(remoteInfo));
                    }
                    if (0UL != aSwtCfg->mstSlvMode) {
                        ret = RPC_GetBuffer(RPC_CHANID_0, cmdHdl, &buffer, &bufferLen);
                        if ((BCM_ERR_OK == ret) && (NULL != buffer)) {
                            BCM_MemCpy(buffer, (uint8_t*)&localInfo, sizeof(localInfo));
                            ret = RPC_SendResp(RPC_CHANID_0,
                                    sizeof(localInfo),
                                    BCM_ERR_OK,
                                    cmdHdl);
                        }
                        if (BCM_ERR_OK != ret) {
                            BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_HANDLE_TC10_PROC, 0UL, 0UL, 0UL, __LINE__);
                        }
                    } else {
                        break;
                    }
                }
            }
            if ((BCM_GetTimeNs() - startTime) > (uint64_t)(config.maxRetryCnt * config.retryIntervalUs * 1000UL)) {
                ret = BCM_ERR_TIME_OUT;
            }
        }
        RPC_Deinit(RPC_CHANID_0);
        if (BCM_CMDID(BCM_GROUPID_ETHSRV, BCM_TCT_ID, TC10_IPC_CMD_COLLECT_APPLY) == tmpCmd) {
           localInfo.forwardMap |= remoteInfo.forwardMap;
           DBG_LogStatus(DBG_LOG_APPLY_TC10_SYNC_SUCCESS);
        }
    }
    ret = TC10_ApplyForwardMap(aTC10Cfg, localInfo.forwardMap, aSwtCfg->mstSlvMode);
    if (BCM_ERR_OK != ret) {
        DBG_LogStatus(DBG_LOG_APPLY_TC10_FWD_FAILED);
        BCM8957X_RomReportError(ret, BRCM_SWDSGN_BCM8957X_HANDLE_TC10_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_APPLY_TC10_FWD_SUCCESS);
    }
}

/** @} */

/**
    @addtogroup grp_bcm8957x_rom_ifc
    @{
*/

/** @brief Early Init Function

    EArly Init function for BCM8957x ROM.

    @behavior Sync, Non-reentrant

    @param void

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_EARLY_INIT_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @code{.unparsed}
    CORTEX_MX_MPUDisable()
    for number of MPU Table devices
        CORTEX_MX_MPUConfigure(reg_num++, BCM8957X_MpuTblDevice[i].regionBaseAddr,
                BCM8957X_MpuTblDevice[i].regionAttr | BCM8957X_MpuTblDevice[i].regionSz)
    for number of MPU Table Memory
        CORTEX_MX_MPUConfigure(reg_num++, BCM8957X_MpuTblMemory[i].regionBaseAddr,
                BCM8957X_MpuTblMemory[i].regionAttr | BCM8957X_MpuTblMemory[i].regionSz)
    CORTEX_MX_MPUEnable()

    BCM_MemSet(__bss_start__, 0U, (uint32_t)__bss_end__ - (uint32_t)__bss_start__)

    MCU_Init(&BCM8957X_McuConfig)
    BCM_InitError()
    @endcode
*/
void BCM8957X_RomEarlyInit(void)
{
    uint32_t i = 0UL;
    uint32_t reg_num = 0UL;

    CORTEX_MX_MPUDisable();

    for (i = 0; i < sizeof(BCM8957X_MpuTblDevice)/sizeof(BCM8957X_MpuTblEntryType); i++) {
        CORTEX_MX_MPUConfigure(reg_num++, BCM8957X_MpuTblDevice[i].regionBaseAddr,
                BCM8957X_MpuTblDevice[i].regionAttr | BCM8957X_MpuTblDevice[i].regionSz);
    }

    for (i = 0UL; i < sizeof(BCM8957X_MpuTblMemory)/sizeof(BCM8957X_MpuTblEntryType); i++) {
        CORTEX_MX_MPUConfigure(reg_num++, BCM8957X_MpuTblMemory[i].regionBaseAddr,
                BCM8957X_MpuTblMemory[i].regionAttr | BCM8957X_MpuTblMemory[i].regionSz);
    }

    CORTEX_MX_MPUEnable();

    /* CLEAR BSS section */
    extern uint8_t __bss_start__[];
    extern uint8_t __bss_end__[];
    BCM_MemSet(__bss_start__, 0U, (uint32_t)__bss_end__ - (uint32_t)__bss_start__);

    MCU_Init(&BCM8957X_McuConfig);
    BCM_InitError();
}

/** @brief Main function

    Main function for BCM8957x ROM.

    @behavior Sync, Non-reentrant

    @param void

    @retval void

    @trace #BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC
    @trace #BRCM_SWREQ_BCM8957X_ROM

    @image html bcm8957x_rom_application.jpg ROM Main Flow
*/
void BCM8957X_RomMain(void)
{
    int32_t ret;
    LOADER_EntryPtType entryPt;
    LOADER_ConfigType loaderConfig;
    MCU_InfoType switchInfo;
#if !defined(BCM8956X_ENABLE_A0)
    OTP_RDBType* otpBase = (OTP_RDBType*)OTP_BASE;
    uint32_t otpRegister = otpBase->fout_data5;
#else
    uint32_t otpRegister = ((~((uint32_t)OTP_DISABLE_BIT_VAL_4BIT)) << OTP_DISABLE_BIT_SHIFT_WDT) |
                           ((~((uint32_t)OTP_DISABLE_BIT_VAL_4BIT)) << OTP_DISABLE_BIT_SHIFT_FLASH) |
                           ((~((uint32_t)OTP_DISABLE_BIT_VAL_4BIT)) << OTP_DISABLE_BIT_SHIFT_TFTP) |
                           ((~((uint32_t)OTP_DISABLE_BIT_VAL_4BIT)) << OTP_DISABLE_BIT_SHIFT_IPC);
#endif
    IO_RDBType* ioBase = (IO_RDBType*)IO_BASE;
    uint32_t xcvrConfigLen = OTP_XCVR_CONFIG_SIZE;
    uint32_t xcvrConfigLenInWords;
    uint32_t tc10ConfigLen = sizeof(TC10_ConfigurationType);

    DBG_LogStatus(DBG_LOG_ENTRY_MAIN);
    if (OTP_DISABLE_BIT_VAL_4BIT ==
        ((otpRegister >> OTP_DISABLE_BIT_SHIFT_WDT) & OTP_DISABLE_BIT_MASK_4BIT)) {
        DBG_LogStatus(DBG_LOG_WDT_INIT);
        WDT_Init(0UL, &BCM8957X_WDTConfig);
    }

    TIM_Init(0UL, &BCM8957X_TimeCfg);
    DBG_LogStatus(DBG_LOG_TIM_INIT);

    OTP_Init(OTP_HW_ID_0);
    DBG_LogStatus(DBG_LOG_OTP_INIT);

    SPUM_Init();

    ret = OTP_ReadIPConfig(OTP_HW_ID_0, &loaderConfig.ipInfo);
    if (BCM_ERR_OK != ret) {
        BCM_MemSet(&loaderConfig.ipInfo, 0U, sizeof(loaderConfig.ipInfo));
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_READ_IP_CONFIG);
    }

#ifdef BCM8956X_ENABLE_A0
    if (0 != (ioBase->straps_raw & IO_STRAPS_RAW_PHYADDR4_MASK)) {
        loaderConfig.swtInfo.stackingEn = 1U;
        loaderConfig.swtInfo.mstSlvMode = 1U;
        loaderConfig.swtInfo.stackPort0 = 8U;
        loaderConfig.swtInfo.stackPort1 = 0U;
        loaderConfig.swtInfo.vlan = 4094U;
        loaderConfig.swtInfo.xcvrCount = 4U;
        loaderConfig.swtInfo.impPort = 0U;
        loaderConfig.ipInfo.tftpIPAddr = BCM8957X_DEFAULT_IP_ADDR;
    } else {
        loaderConfig.swtInfo.stackingEn = 1U;
        loaderConfig.swtInfo.mstSlvMode = 0U;
        loaderConfig.swtInfo.stackPort0 = 6U;
        loaderConfig.swtInfo.stackPort1 = 0U;
        loaderConfig.swtInfo.vlan = 4094U;
        loaderConfig.swtInfo.xcvrCount = 4U;
        loaderConfig.swtInfo.impPort = 0U;
    }

    BCM_MemSet(&switchInfo, 0U, sizeof(switchInfo));
    switchInfo.stackingEn = loaderConfig.swtInfo.stackingEn ;
    switchInfo.mstSlvMode = loaderConfig.swtInfo.mstSlvMode ;
    switchInfo.stackPort0 = loaderConfig.swtInfo.stackPort0 ;
    switchInfo.stackPort1 = loaderConfig.swtInfo.stackPort1 ;
    switchInfo.vlan = loaderConfig.swtInfo.vlan ;

    ret = MCU_SetInfo(&switchInfo);
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    }

#else
    ret = OTP_ReadSwitchConfig(OTP_HW_ID_0, &loaderConfig.swtInfo);
    if (BCM_ERR_OK != ret) {
        BCM_MemSet(&loaderConfig.swtInfo, 0U, sizeof(loaderConfig.swtInfo));
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_READ_SWT_CONFIG);

        BCM_MemSet(&switchInfo, 0U, sizeof(switchInfo));
        switchInfo.stackingEn = loaderConfig.swtInfo.stackingEn ;
        switchInfo.mstSlvMode = loaderConfig.swtInfo.mstSlvMode ;
        switchInfo.stackPort0 = loaderConfig.swtInfo.stackPort0 ;
        switchInfo.stackPort1 = loaderConfig.swtInfo.stackPort1 ;
        switchInfo.vlan = loaderConfig.swtInfo.vlan ;

        ret = MCU_SetInfo(&switchInfo);
        if (BCM_ERR_OK != ret) {
            BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
        }
    }
#endif

    ret = OTP_ReadXCVRConfig(OTP_HW_ID_0, BCM8957X_XCVRConfig, &xcvrConfigLen);
    if (BCM_ERR_OK != ret) {
        BCM_MemSet(BCM8957X_XCVRConfig, 0U, sizeof(BCM8957X_XCVRConfig));
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_READ_XCVR_CONFIG);
    }

    ret = OTP_ReadTC10Config(OTP_HW_ID_0, (uint32_t*)&BCM8957X_TC10Config, &tc10ConfigLen);
    if (BCM_ERR_OK != ret) {
        BCM_MemSet(&BCM8957X_TC10Config, 0U, sizeof(BCM8957X_TC10Config));
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_READ_TC10_CONFIG);
    }

    BCM8957X_RomEthSrvInit(&loaderConfig.swtInfo, &loaderConfig.ipInfo);

#ifdef BCM8956X_ENABLE_A0
    extern const uint32_t sgmiiSlave[];
    extern const uint32_t sgmiiMaster[];
    xcvrConfigLenInWords = OTP_XCVR_CONFIG_SIZE / sizeof(uint32_t);
    if (0 != (ioBase->straps_raw & IO_STRAPS_RAW_PHYADDR4_MASK)) {
        XCVR_Configure(sgmiiSlave, 57UL, 0, loaderConfig.swtInfo.xcvrCount);
    } else {
        XCVR_Configure(sgmiiMaster, 57UL, 0, loaderConfig.swtInfo.xcvrCount);
    }
#else
    xcvrConfigLenInWords = xcvrConfigLen / sizeof(uint32_t);
    ret = XCVR_Configure(BCM8957X_XCVRConfig, xcvrConfigLenInWords, 0UL, loaderConfig.swtInfo.xcvrCount);
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_APPLY_XCVR_MIN_CONFIG);
    }
#endif
    BCM8957X_HandleTC10(&BCM8957X_TC10Config, &loaderConfig.swtInfo);
    DBG_LogStatus(DBG_LOG_APPLY_TC10_FWD_COMPLETE);

    ret = XCVR_Configure(BCM8957X_XCVRConfig, xcvrConfigLenInWords,
                         loaderConfig.swtInfo.xcvrCount,
                         xcvrConfigLenInWords - loaderConfig.swtInfo.xcvrCount);
    if (BCM_ERR_OK != ret) {
        BCM8957X_RomReportError(ret, BRCM_SWARCH_BCM8957X_ROM_MAIN_PROC, 0UL, 0UL, 0UL, __LINE__);
    } else {
        DBG_LogStatus(DBG_LOG_APPLY_XCVR_FULL_CONFIG);
    }

    BCM8957X_HandleTC10(&BCM8957X_TC10Config, &loaderConfig.swtInfo);
    DBG_LogStatus(DBG_LOG_APPLY_TC10_FWD_COMPLETE);

#if (APP_TEST_MODE==2)
    extern void APP_Init();
    (void)ioBase;
    (void)entryPt;
    APP_Init();
    BCM8957X_RomEthSrvDeInit();
    while(1) {};
#else
    ret = BCM_ERR_NOT_FOUND;
    if ((OTP_DISABLE_BIT_VAL_4BIT !=
        ((otpRegister >> OTP_DISABLE_BIT_SHIFT_FLASH) & OTP_DISABLE_BIT_MASK_4BIT))
        && (0UL == ((ioBase->straps_raw & IO_STRAPS_RAW_SFT_FORCE_DWNLD_MASK)
                        >> IO_STRAPS_RAW_SFT_FORCE_DWNLD_SHIFT))) {
        const LOADER_InfoType *flsLoader = FLSLDR_GetInfo();
        PINMUX_Init();

        LOADER_Init(&flsLoader, 1UL, &loaderConfig);
        ret = LOADER_FetchExe(&flsLoader, 1UL, LOADER_EXE_PID, &entryPt);
        LOADER_Deinit(&flsLoader, 1UL);
    } else {
        DBG_LogStatus(DBG_LOG_SKIP_FLASH_LOADER);
    }

    if (BCM_ERR_OK != ret) {
        const LOADER_InfoType * loaders[2UL] = {NULL, NULL};

        if (OTP_DISABLE_BIT_VAL_4BIT !=
            ((otpRegister >> OTP_DISABLE_BIT_SHIFT_TFTP) & OTP_DISABLE_BIT_MASK_4BIT)) {
            loaders[0UL] = TFTPLDR_GetInfo();
        }

        if (OTP_DISABLE_BIT_VAL_4BIT !=
            ((otpRegister >> OTP_DISABLE_BIT_SHIFT_IPC) & OTP_DISABLE_BIT_MASK_4BIT)) {
            loaders[1UL] = IPCLDR_GetInfo();
        }

        LOADER_Init(loaders, 2UL, &loaderConfig);
        do {
            ret = LOADER_FetchExe(loaders, 2UL, LOADER_EXE_PID, &entryPt);
        } while (BCM_ERR_OK != ret);

        LOADER_Deinit(loaders, 2UL);
    }

    BCM8957X_RomEthSrvDeInit();

    OTP_DeInit(OTP_HW_ID_0);
    DBG_LogStatus(DBG_LOG_OTP_DEINIT);

    DBG_LogStatus(DBG_LOG_ENTER_DOWNLOADED_EXE);
    entryPt();
#endif
}
/** @} */
