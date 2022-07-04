/*****************************************************************************
 Copyright 2022 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Corporation and/or its
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
    @defgroup grp_eth_xcvrdrv_sgmiiplusr_impl SGMII-PLUSR (MMAP based access) driver
    @ingroup grp_eth_xcvrdrv

    @addtogroup grp_eth_xcvrdrv_sgmiiplusr_impl
    @{

    @file sgmiiplusr.c
    @brief This file implements the SGMII-PLUSR Driver

    @version 0.1 Initial draft
*/

#include <string.h>
#include <compiler.h>
#include <bcm_utils.h>
#include <bcm_err.h>
#include <ethxcvr.h>
#include <ethxcvr_osil.h>
#include <sgmiiplusr_osil.h>
#include <bcm_time.h>

#include <sgmiiplusr_an_x1_timers_rdb.h>
#include <sgmiiplusr_an_x4_rdb.h>
#include <sgmiiplusr_cl22_rdb.h>
#include <sgmiiplusr_digital_rdb.h>
#include <sgmiiplusr_pcs_main0_rdb.h>
#include <sgmiiplusr_pll_afe_rdb.h>
#include <sgmiiplusr_pll2_rdb.h>
#include <sgmiiplusr_pmdcom_rdb.h>
#include <sgmiiplusr_rx_pmd_rdb.h>
#include <sgmiiplusr_rx_x4_rdb.h>
#include <sgmiiplusr_tx_x1_credit_gen1_rdb.h>
#include <sgmiiplusr_tx_x1_credit_gen2_rdb.h>
#include <sgmiiplusr_tx_x1_credit_gen4_rdb.h>
#include <sgmiiplusr_tx_x4_rdb.h>
#include <sgmiiplusr_rx_afe_pmd_rdb.h>
#include <mcu_clk.h>
#include <mcu_switch_ext.h>

/**
    @name SGMIIPLUSR driver Design IDs
    @{
    @brief Design IDs for SGMIIPLUSR driver
*/
#define BRCM_SWDSGN_SGMIIPLUSR_FUNCTBL_GLOBAL                 (0xC600U) /**< @brief #SGMIIPLUSR_FuncTbl */
#define BRCM_SWDSGN_SGMIIPLUSR_CL22_REGS_GLOBAL               (0xC601U) /**< @brief #SGMIIPLUSR_CL22_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_AN_X1_TIMERS_REGS_GLOBAL       (0xC602U) /**< @brief #SGMIIPLUSR_AN_X1_TIMERS_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS_GLOBAL  (0xC603U) /**< @brief #SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_TX_X1_CREDIT_GEN2_REGS_GLOBAL  (0xC604U) /**< @brief #SGMIIPLUSR_TX_X1_CREDIT_GEN2_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_TX_X1_CREDIT_GEN4_REGS_GLOBAL  (0xC605U) /**< @brief #SGMIIPLUSR_TX_X1_CREDIT_GEN4_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_PCS_MAIN0_REGS_GLOBAL          (0xC606U) /**< @brief #SGMIIPLUSR_PCS_MAIN0_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_PLL_AFE_REGS_GLOBAL            (0xC607U) /**< @brief #SGMIIPLUSR_PLL_AFE_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_PLL2_REGS_GLOBAL               (0xC608U) /**< @brief #SGMIIPLUSR_PLL2_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_PMDCOM_REGS_GLOBAL             (0xC609U) /**< @brief #SGMIIPLUSR_PMDCOM_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_DIGITAL_REGS_GLOBAL            (0xC60AU) /**< @brief #SGMIIPLUSR_DIGITAL_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_AN_X4_REGS_GLOBAL              (0xC60BU) /**< @brief #SGMIIPLUSR_AN_X4_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_RX_X4_REGS_GLOBAL              (0xC60CU) /**< @brief #SGMIIPLUSR_RX_X4_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_TX_X4_REGS_GLOBAL              (0xC60DU) /**< @brief #SGMIIPLUSR_TX_X4_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_RX_PMD_REGS_GLOBAL             (0xC60EU) /**< @brief #SGMIIPLUSR_RX_PMD_REGS */
#define BRCM_SWDSGN_SGMIIPLUSR_RWDATA_GLOBAL                  (0xC60FU) /**< @brief #SGMIIPLUSR_RWData */
#define BRCM_SWDSGN_SGMIIPLUSR_RWDATA_TYPE                    (0xC610U) /**< @brief #SGMIIPLUSR_RWDataType */
#define BRCM_SWDSGN_SGMIIPLUSR_INIT_PROC                      (0xC611U) /**< @brief #SGMIIPLUSR_Init */
#define BRCM_SWDSGN_SGMIIPLUSR_RESET_PROC                     (0xC612U) /**< @brief #SGMIIPLUSR_Reset */
#define BRCM_SWDSGN_SGMIIPLUSR_GETSQIVALUE_PROC               (0xC613U) /**< @brief #SGMIIPLUSR_GetSQIValue */
#define BRCM_SWDSGN_SGMIIPLUSR_GETDUPLEXMODE_PROC             (0xC614U) /**< @brief #SGMIIPLUSR_GetDuplexMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETSPEED_PROC                  (0xC615U) /**< @brief #SGMIIPLUSR_GetSpeed */
#define BRCM_SWDSGN_SGMIIPLUSR_GETLINKSTATE_PROC              (0xC616U) /**< @brief #SGMIIPLUSR_GetLinkState */
#define BRCM_SWDSGN_SGMIIPLUSR_GETMODE_PROC                   (0xC617U) /**< @brief #SGMIIPLUSR_GetMode */
#define BRCM_SWDSGN_SGMIIPLUSR_LINKIRQHANDLER_PROC            (0xC618U) /**< @brief #SGMIIPLUSR_LinkIRQHandler */
#define BRCM_SWDSGN_SGMIIPLUSR_LINKCHANGEINDHANDLER_PROC      (0xC619U) /**< @brief #SGMIIPLUSR_LinkChangeIndHandler */
#define BRCM_SWDSGN_SGMIIPLUSR_SETSPEED_PROC                  (0xC61BU) /**< @brief #SGMIIPLUSR_SetSpeed */
#define BRCM_SWDSGN_SGMIIPLUSR_GETJUMBOMODE_PROC              (0xC61CU) /**< @brief #SGMIIPLUSR_GetJumboMode */
#define BRCM_SWDSGN_SGMIIPLUSR_SETWAKEUPMODE_PROC             (0xC61DU) /**< @brief #SGMIIPLUSR_SetWakeUpMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETWAKEUPMODE_PROC             (0xC61EU) /**< @brief #SGMIIPLUSR_GetWakeUpMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETWAKEUPREASON_PROC           (0xC61FU) /**< @brief #SGMIIPLUSR_GetWakeUpReason */
#define BRCM_SWDSGN_SGMIIPLUSR_SETJUMBOMODE_PROC              (0xC620U) /**< @brief #SGMIIPLUSR_SetJumboMode */
#define BRCM_SWDSGN_SGMIIPLUSR_SETAUTONEGMODE_PROC            (0xC621U) /**< @brief #SGMIIPLUSR_SetAutoNegMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETAUTONEGSTATUS_PROC          (0xC622U) /**< @brief #SGMIIPLUSR_GetAutoNegStatus */
#define BRCM_SWDSGN_SGMIIPLUSR_GETSTATS_PROC                  (0xC623U) /**< @brief #SGMIIPLUSR_GetStats */
#define BRCM_SWDSGN_SGMIIPLUSR_SETDUPLEXMODE_PROC             (0xC624U) /**< @brief #SGMIIPLUSR_SetDuplexMode */
#define BRCM_SWDSGN_SGMIIPLUSR_SETFLOWCONTROL_PROC            (0xC625U) /**< @brief #SGMIIPLUSR_SetFlowControl */
#define BRCM_SWDSGN_SGMIIPLUSR_GETFLOWCONTROL_PROC            (0xC626U) /**< @brief #SGMIIPLUSR_GetFlowControl */
#define BRCM_SWDSGN_SGMIIPLUSR_RESTARTAUTONEG_PROC            (0xC627U) /**< @brief #SGMIIPLUSR_RestartAutoNeg */
#define BRCM_SWDSGN_SGMIIPLUSR_STATEHANDLER_PROC              (0xC628U) /**< @brief #SGMIIPLUSR_StateHandler */
#define BRCM_SWDSGN_SGMIIPLUSR_UPDATEHWSTATUS_PROC            (0xC629U) /**< @brief #SGMIIPLUSR_UpdateHWStatus */
#define BRCM_SWDSGN_SGMIIPLUSR_SETMODE_PROC                   (0xC62AU) /**< @brief #SGMIIPLUSR_SetMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETMASTERMODE_PROC             (0xC62BU) /**< @brief #SGMIIPLUSR_GetMasterMode */
#define BRCM_SWDSGN_SGMIIPLUSR_SETMASTERMODE_PROC             (0xC62CU) /**< @brief #SGMIIPLUSR_SetMasterMode */
#define BRCM_SWDSGN_SGMIIPLUSR_GETLOOPBACKMODE_PROC           (0xC62DU) /**< @brief #SGMIIPLUSR_GetLoopbackMode */
#define BRCM_SWDSGN_SGMIIPLUSR_SETLOOPBACKMODE_PROC           (0xC62EU) /**< @brief #SGMIIPLUSR_SetLoopbackMode */
#define BRCM_SWDSGN_SGMIIPLUSR_CONFIGAN_TIMERS_PROC           (0xC62FU) /**< @brief #SGMIIPLUSR_ConfigAN_Timers */
#define BRCM_SWDSGN_SGMIIPLUSR_CONFIG_CREDITGEN_PROC          (0xC630U) /**< @brief #SGMIIPLUSR_Config_CreditGen */
#define BRCM_SWDSGN_SGMIIPLUSR_SETUP1_25G_SPEED_PROC          (0xC631U) /**< @brief #SGMIIPLUSR_Setup1_25G_Speed */
#define BRCM_SWDSGN_SGMIIPLUSR_CONFIG1G_SPEED_PROC            (0xC632U) /**< @brief #SGMIIPLUSR_Config1G_Speed */
#define BRCM_SWDSGN_SGMIIPLUSR_CONFIG25G_SPEED_PROC           (0xC633U) /**< @brief #SGMIIPLUSR_Config25G_Speed */
#define BRCM_SWDSGN_SGMIIPLUSR_CONFIG5G_SPEED_PROC            (0xC634U) /**< @brief #SGMIIPLUSR_Config5G_Speed */
#define BRCM_SWDSGN_SGMIIPLUSR_RX_AFE_PMD_REGS_GLOBAL         (0xC635U) /**< @brief #SGMIIPLUSR_RX_AFE_PMD_REGS */
/** @} */

/**
    @brief SGMIIPLUSR driver private data type

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
typedef struct sSGMIIPLUSR_RWDataType {
    ETHXCVR_ModeType  mode;         /**< @brief Cached mode */
    uint32_t          isProgrammed; /**< @brief Internal usage */
} SGMIIPLUSR_RWDataType;

/**
    @brief SGMIIPLUSR driver private data

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_RWDataType SGMIIPLUSR_RWData COMP_SECTION(".bss.drivers");

/**
    @brief SGMIIPLUSR CL22 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_CL22_RDBType * const SGMIIPLUSR_CL22_REGS = (SGMIIPLUSR_CL22_RDBType *const)CL22_B0_SGMIIPLUSR_X1_BASE;

/**
    @brief SGMIIPLUSR AN X1 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_AN_X1_TIMERS_RDBType * const SGMIIPLUSR_AN_X1_TIMERS_REGS = (SGMIIPLUSR_AN_X1_TIMERS_RDBType *const)AN_X1_TIMERS_BASE;

/**
    @brief SGMIIPLUSR TX_X1 CREDIT_GEN1 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_TX_X1_CREDIT_GEN1_RDBType * const SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS = (SGMIIPLUSR_TX_X1_CREDIT_GEN1_RDBType *const)TX_X1_CREDIT_GEN1_BASE;

/**
    @brief SGMIIPLUSR TX_X1 CREDIT_GEN2 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_TX_X1_CREDIT_GEN2_RDBType * const SGMIIPLUSR_TX_X1_CREDIT_GEN2_REGS = (SGMIIPLUSR_TX_X1_CREDIT_GEN2_RDBType *const)TX_X1_CREDIT_GEN2_BASE;

/**
    @brief SGMIIPLUSR TX_X1 CREDIT_GEN4 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_TX_X1_CREDIT_GEN4_RDBType * const SGMIIPLUSR_TX_X1_CREDIT_GEN4_REGS = (SGMIIPLUSR_TX_X1_CREDIT_GEN4_RDBType *const)TX_X1_CREDIT_GEN4_BASE;

/**
    @brief SGMIIPLUSR PCS MAIN0 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_PCS_MAIN0_RDBType * const SGMIIPLUSR_PCS_MAIN0_REGS = (SGMIIPLUSR_PCS_MAIN0_RDBType *const)MAIN0_BASE;

/**
    @brief SGMIIPLUSR AFE block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_PLL_AFE_RDBType * const SGMIIPLUSR_PLL_AFE_REGS = (SGMIIPLUSR_PLL_AFE_RDBType *const)PLL_AFE_SGMIIPLUSR_X1_BASE;

/**
    @brief SGMIIPLUSR PLL2 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_PLL2_RDBType * const SGMIIPLUSR_PLL2_REGS = (SGMIIPLUSR_PLL2_RDBType *const)PLL2_SGMIIPLUSR_X1_BASE;

/**
    @brief SGMIIPLUSR PMDCOM block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_PMDCOM_RDBType * const SGMIIPLUSR_PMDCOM_REGS = (SGMIIPLUSR_PMDCOM_RDBType *const)PMD_COM_SGMIIPLUSR_X1_BASE;

/**
    @brief SGMIIPLUSR DIGITAL block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_DIGITAL_RDBType * const SGMIIPLUSR_DIGITAL_REGS = (SGMIIPLUSR_DIGITAL_RDBType *const)DIGITAL_SGMIIPLUSR_X1_BASE;

/**
    @brief SGMIIPLUSR AN X4 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_AN_X4_RDBType * const SGMIIPLUSR_AN_X4_REGS = (SGMIIPLUSR_AN_X4_RDBType *const)AN_X4_ABILITIES_BASE;

/**
    @brief SGMIIPLUSR RX X4 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_RX_X4_RDBType * const SGMIIPLUSR_RX_X4_REGS = (SGMIIPLUSR_RX_X4_RDBType *const)RX_X4_CONTROL0_BASE;

/**
    @brief SGMIIPLUSR TX X4 block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_TX_X4_RDBType * const SGMIIPLUSR_TX_X4_REGS = (SGMIIPLUSR_TX_X4_RDBType *const)TX_X4_CONTROL0_BASE;

/**
    @brief SGMIIPLUSR RX PMD block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_RX_PMD_RDBType * const SGMIIPLUSR_RX_PMD_REGS = (SGMIIPLUSR_RX_PMD_RDBType *const)RX_PMD_TEST_BASE;

/**
    @brief SGMIIPLUSR RX AFE PMD block base address

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
SGMIIPLUSR_RX_AFE_PMD_RDBType * const SGMIIPLUSR_RX_AFE_PMD_REGS = (SGMIIPLUSR_RX_AFE_PMD_RDBType *const)RX_AFE_BASE;

/**
    @code{.unparsed}
    write value of 0x029A to AN_X1_TIMERS_CL37_RESTART
    write value of 0x029A to AN_X1_TIMERS_CL37_ACK
    write value of 0xA000 to AN_X1_TIMERS_CL37_ERROR
    write value of 0x10EE to AN_X1_TIMERS_CL73_BREAK_LINK
    write value of 0xA000 to AN_X1_TIMERS_CL73_ERROR
    write value of 0x0BBB to AN_X1_TIMERS_CL73_DME_LOCK
    write value of 0x1B00 to AN_X1_TIMERS_LINK_UP
    write value of 0x8235 to AN_X1_TIMERS_LINK_FAIL_INH_TIMER_CL72
    write value of 0x8235 to AN_X1_TIMERS_LINK_FAIL_INH_TIMER_NOT_CL72
    write value of 0x8235 to AN_X1_TIMERS_CL72_MAX_WAIT_TIMER
    write value of 0x000F to AN_X1_TIMERS_IGNORE_LINK_TIMER
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_ConfigAN_Timers()
{
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl37_restart                     = SGMIIPLUSR_AN_X1_CONST0;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl37_ack                         = SGMIIPLUSR_AN_X1_CONST0;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl37_error                       = SGMIIPLUSR_AN_X1_CONST3;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl73_break_link                  = SGMIIPLUSR_AN_X1_CONST4;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl73_error                       = SGMIIPLUSR_AN_X1_CONST5;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl73_dme_lock                    = SGMIIPLUSR_AN_X1_CONST6;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->link_up                          = SGMIIPLUSR_AN_X1_CONST7;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->link_fail_inhibit_timer_cl72     = SGMIIPLUSR_AN_X1_CONST8;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->link_fail_inhibit_timer_not_cl72 = SGMIIPLUSR_AN_X1_CONST9;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->cl72_max_wait_timer              = SGMIIPLUSR_AN_X1_CONST10;
    SGMIIPLUSR_AN_X1_TIMERS_REGS->ignore_link_timer                = SGMIIPLUSR_AN_X1_CONST11;
}

/**
    @code{.unparsed}
    write a value of 0x00FA to TX_X1_CREDIT_GEN1_reg10M_credit0: reg10M_ClockCount0
    write a value of 0x0028 to TX_X1_CREDIT_GEN1_reg10M_credit2: reg10M_PCS_ClockCount0
    write a value of 0x00F9 to TX_X1_CREDIT_GEN1_reg10M_credit3: reg10M_CGC
    write a value of 0x0027 to TX_X1_CREDIT_GEN1_reg10M_credit4: reg10M_PCS_CGC
    write a value of 0x0019 to TX_X1_CREDIT_GEN1_reg100M_credit0: reg100M_ClockCount0
    write a value of 0x0028 to TX_X1_CREDIT_GEN1_reg100M_credit2: reg100M_PCS_ClockCount0
    write a value of 0x0018 to TX_X1_CREDIT_GEN1_reg100M_credit3: reg100M_CGC
    write a value of 0x0027 to TX_X1_CREDIT_GEN1_reg100M_credit4: reg100M_PCS_CGC
    write a value of 0x0005 to TX_X1_CREDIT_GEN1_reg1G_credit0: reg1G_ClockCount0
    write a value of 0x0004 to TX_X1_CREDIT_GEN1_reg1G_credit1: reg1G_CGC
    write a value of 0x0002 to TX_X1_CREDIT_GEN2_reg2P5G_credit0: reg2P5G_ClockCount0
    write a value of 0x0001 to TX_X1_CREDIT_GEN2_reg2P5G_credit1: reg2P5G_CGC
    write a value of 0x0021 to TX_X1_CREDIT_GEN4_reg5G_KR1_credit0: reg5G_KR1_ClockCount0
    write a value of 0x0006 to TX_X1_CREDIT_GEN4_reg5G_KR1_credit1: reg5G_KR1_CGC
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_Config_CreditGen()
{
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg10m_credit0    = SGMIIPLUSR_TX_X1_CONST1;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg10m_credit2    = SGMIIPLUSR_TX_X1_CONST2;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg10m_credit3    = SGMIIPLUSR_TX_X1_CONST3;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg10m_credit4    = SGMIIPLUSR_TX_X1_CONST4;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg100m_credit0   = SGMIIPLUSR_TX_X1_CONST5;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg100m_credit2   = SGMIIPLUSR_TX_X1_CONST6;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg100m_credit3   = SGMIIPLUSR_TX_X1_CONST7;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg100m_credit4   = SGMIIPLUSR_TX_X1_CONST8;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg1g_credit0     = SGMIIPLUSR_TX_X1_CONST9;
    SGMIIPLUSR_TX_X1_CREDIT_GEN1_REGS->reg1g_credit1     = SGMIIPLUSR_TX_X1_CONST10;
    SGMIIPLUSR_TX_X1_CREDIT_GEN2_REGS->reg2p5g_credit0   = SGMIIPLUSR_TX_X1_CONST11;
    SGMIIPLUSR_TX_X1_CREDIT_GEN2_REGS->reg2p5g_credit1   = SGMIIPLUSR_TX_X1_CONST12;
    SGMIIPLUSR_TX_X1_CREDIT_GEN4_REGS->reg1g_kr1_credit0 = SGMIIPLUSR_TX_X1_CONST13;
    SGMIIPLUSR_TX_X1_CREDIT_GEN4_REGS->reg1g_kr1_credit1 = SGMIIPLUSR_TX_X1_CONST14;
}

/**
    @code{.unparsed}
    write a value of 0x0000 PCS_USER1_Main0
    write a value of 0x5740 PLL_AFE_CTRL0
    write a value of 0x01D1 PLL_AFE_CTRL1
    write a value of 0x19E8 PLL_AFE_CTRL2
    write a value of 0xAB80 PLL_AFE_CTRL3
    write a value of 0x8821 PLL_AFE_CTRL4
    write a value of 0x0044 PLL_AFE_CTRL5
    write a value of 0x4000 PLL_AFE_CTRL6
    write a value of 0x08F7 PLL_AFE_CTRL7
    write a value of 0x0001 PLL_AFE_CTRL8
    write a value of 0x007C PLL2_CTRL6
    write a value of 0x003C PLL2_CTRL6
    write a value of 0x0022 PMD_CONTROL
    write a value of 0x8021 PLL_AFE_CTRL4
    write a value of 0x8821 PLL_AFE_CTRL4
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_Setup1_25G_Speed()
{
    /* REFCLK_SEL (bits 15:12)=0000, sets 25MHz refclk */
    SGMIIPLUSR_PCS_MAIN0_REGS->setup    = SGMIIPLUSR_PCS_CONST;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl0      = SGMIIPLUSR_PLL_AFE_CONST0;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl1      = SGMIIPLUSR_PLL_AFE_CONST1;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl2      = SGMIIPLUSR_PLL_AFE_CONST2;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl3      = SGMIIPLUSR_PLL_AFE_CONST3;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl4      = SGMIIPLUSR_PLL_AFE_CONST4;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl5      = SGMIIPLUSR_PLL_AFE_CONST5;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl6      = SGMIIPLUSR_PLL_AFE_CONST6;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl7      = SGMIIPLUSR_PLL_AFE_CONST7;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl8      = SGMIIPLUSR_PLL_AFE_CONST8;
    SGMIIPLUSR_PLL2_REGS->ctrl6         = SGMIIPLUSR_PLL2_AFE_CONST0;
    SGMIIPLUSR_PLL2_REGS->ctrl6         = SGMIIPLUSR_PLL2_AFE_CONST1;
    SGMIIPLUSR_PMDCOM_REGS->pmd_control = SGMIIPLUSR_PMDCOM_CONST0;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl4      = SGMIIPLUSR_PLL_AFE_CONST9;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl4      = SGMIIPLUSR_PLL_AFE_CONST4;
}

/**
    @code{.unparsed}
    if aConfig->autoNeg is ETHXCVR_BOOLEAN_FALSE
        Read  DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value & 0xC7FF) | 0x2000
        Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        Read  DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value | 0x42)
        Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        Read  DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value & 0xF7BF) | 0x42
        Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        Read AN_X4_ABILITIES_ENABLES_SGMIIPLUSR_X1
        value = value & 0xFF3F
        Write the value to AN_X4_ABILITIES_ENABLES_SGMIIPLUSR_X1
    else
        Read  DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value & 0xCFFF) | 0x2000
        Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        m/s = 0x6 + (master * 0x200)
        Write the value of m/s to AN_X4_ABILITIES_LOCAL_DEVICE_CL37_BASE_ABILITIES
        Read AN_X4_ABILITIES_ENABLES_SGMIIPLUSR_X1
        value = value OR 0xC0
        Write the value to AN_X4_ABILITIES_ENABLES_SGMIIPLUSR_X1
        Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value & 0xF7BF)
        Write the value to AN_X4_ABILITIES_ENABLES_SGMIIPLUSR_X1

        Write 0x0001 to RX_X4_CONTROL0_PMA_CONTROL_0
        Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        value = (value | 0x80)
        Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
        Write 0x01E6 to TX_X4_CONTROL0_MISC
        Write 0x01E7 to TX_X4_CONTROL0_MISC
        if aConfig->autoNeg is ETHXCVR_BOOLEAN_FALSE
            Write 0x0140 to CL22_B0_MIICntl
        else
            Write 0x1140 to CL22_B0_MIICntl
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_Config1G_Speed(const ETHXCVR_PortConfigType *const aConfig)
{
    uint16_t regVal = 0x0U;
    if(ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) {
        /* Following Figure 60: Force Speed 1G */
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal & 0xC7FFU) | 0x2000U;
        SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

        /* FORCE SPEED MODE:  SW_actual_speed_force_en (bit 6=1), SW_actual_speed (bits5:0=02) */
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal | 0x0042U);
        SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

        /* set credit_sw_en(bit 11)=0, set SW_actual_force_en(bit 6)=0 */
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal & 0xF7BFU) | 0x0042U;
        SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

        /* disable CISCO autoneg enable (bit 7) and IEEE CL37 autoneg enable (bit 6) */
        regVal = SGMIIPLUSR_AN_X4_REGS->enables_sgmiiplusr_x1;
        regVal = (regVal & 0xFF3FU);
        SGMIIPLUSR_AN_X4_REGS->enables_sgmiiplusr_x1 = regVal;
    }
    else {
        uint16_t master = 0x0U;
        /* Following Figure 64: Auto Negotiation Speed 1G Master (or Slave) */
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal & 0xCFFFU) | 0x2000U;
        SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

        /* set sgmii_master(bit 9)=1, set sgmii full dup(bit 2)=1, set sgmii_speed(bits 1:0)=10 */
        /* Deviating from F1 script, using forced master */
        master = (0x06U + 0x0200U);
        SGMIIPLUSR_AN_X4_REGS->local_device_cl37_base_abilities_sgmiiplusr_x1 = master;

        /* enable CISCO autoneg enable (bit 7) and IEEE CL37 autoneg enable (bit 6) */
        regVal = SGMIIPLUSR_AN_X4_REGS->enables_sgmiiplusr_x1;
        regVal = (regVal | 0x00C0U);
        SGMIIPLUSR_AN_X4_REGS->enables_sgmiiplusr_x1 = regVal;

        /* set credit_sw_en(bit 11)=0, set SW_actual_force_en(bit 6)=0 */
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal & 0xF7BFU);
        SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;
    }

    /* set rstb_lane(bit 0)=1 (turn off rst) */
    SGMIIPLUSR_RX_X4_REGS->pma_control_0 = SGMIIPLUSR_RX_X4_PC0SX1_RSTB_LANE_MASK;

    /* set mac_creditenable(bit 7)=1 */
    regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
    regVal = (regVal | 0x0080U);
    SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

    /* set rstb_tx_lane (turn off rst)(bit 1)=1 */
    SGMIIPLUSR_TX_X4_REGS->misc = 0x01E6U;
    /* set enable_tx_lane (bit 0)=1*/
    SGMIIPLUSR_TX_X4_REGS->misc = 0x01E7U;
    if(ETHXCVR_BOOLEAN_FALSE == aConfig->autoNeg) {
        SGMIIPLUSR_CL22_REGS->miicntl = 0x0140U;
    }
    else {
        /* enable autoneg; SGMII 1000 Mb/s; full duplex */
        SGMIIPLUSR_CL22_REGS->miicntl = 0x1140U;
    }
}

/**
    @code{.unparsed}
    Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    value = (value & 0xF780) | 0x43
    Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    Write 0x0001 to RX_X4_CONTROL0_PMA_CONTROL_0
    Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    value = (value | 0x80)
    Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    Write 0x01E7 to TX_X4_CONTROL0_MISC
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_Config25G_Speed()
{
    uint16_t regVal = 0x0U;

    /* set credit_sw_en(bit 11)=0, set SW_actual_force_en(bit 6)=1 */
    regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
    regVal = (regVal & 0xF780) | 0x0043U;
    SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

    SGMIIPLUSR_RX_X4_REGS->pma_control_0 = SGMIIPLUSR_RX_X4_PC0SX1_RSTB_LANE_MASK;

    /* set mac_creditenable(bit 7)=1 */
    regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
    regVal = (regVal | 0x0080U);
    SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

    /* set enable_tx_lane (bit 0)=1*/
    SGMIIPLUSR_TX_X4_REGS->misc = 0x01E7U;

}

/**
    @code{.unparsed}
    Write a value of 0x0000 to PCS_USER1_Main0
    Write a value of 0x5740 to PLL_AFE_CTRL0
    Write a value of 0x01D1 to PLL_AFE_CTRL1
    Write a value of 0x59E8 to PLL_AFE_CTRL2
    Write a value of 0xAB80 to PLL_AFE_CTRL3
    Write a value of 0x8821 to PLL_AFE_CTRL4
    Write a value of 0x0044 to PLL_AFE_CTRL5
    Write a value of 0x9000 to PLL_AFE_CTRL6
    Write a value of 0x0833 to PLL_AFE_CTRL7
    Write a value of 0x0001 to PLL_AFE_CTRL8

    Write a value of 0x0001 to RX_PMD_TEST_RXPMD_CONTROL_0
    Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    value = (value & 0xF780) | 0x69
    Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    Write 0x0001 to RX_X4_CONTROL0_PMA_CONTROL_0
    Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    value = (value | 0x80)
    Write the value to DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL
    Write 0x01E6 to TX_X4_CONTROL0_MISC
    Write 0x01E7 to TX_X4_CONTROL0_MISC

    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
static void SGMIIPLUSR_Config5G_Speed()
{
    uint16_t regVal = 0x0U;
    SGMIIPLUSR_PCS_MAIN0_REGS->setup = SGMIIPLUSR_PCS_CONST;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl0   = SGMIIPLUSR_PLL_AFE_CONST0;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl1   = SGMIIPLUSR_PLL_AFE_CONST1;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl2   = SGMIIPLUSR_PLL_AFE_CONST10;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl3   = SGMIIPLUSR_PLL_AFE_CONST3;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl4   = SGMIIPLUSR_PLL_AFE_CONST4;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl5   = SGMIIPLUSR_PLL_AFE_CONST5;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl6   = SGMIIPLUSR_PLL_AFE_CONST11;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl7   = SGMIIPLUSR_PLL_AFE_CONST12;
    SGMIIPLUSR_PLL_AFE_REGS->ctrl8   = SGMIIPLUSR_PLL_AFE_CONST8;

    /* set freq_sel(bit 6)=0 */
    SGMIIPLUSR_RX_PMD_REGS->rxpmd_control0 = SGMIIPLUSR_RX_PMD_RC0SX1_CRC_CHECKER_DISABLE_MASK;

    /* set credit_sw_en(bit 11)=0 */
    /* SW_actual_speed_force_en(bit 6)=0, SW_actual_speed(bits 5:0)=0x29 */
    regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
    regVal = (regVal & 0xF780U) | 0x0069U;
    SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

    /* set rstb_lane(bit 0)=1 */
    SGMIIPLUSR_RX_X4_REGS->pma_control_0 = SGMIIPLUSR_RX_X4_PC0SX1_RSTB_LANE_MASK;

    /* set mac_creditenable(bit 7)=1 */
    regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
    regVal = (regVal | 0x0080U);
    SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol = regVal;

    /* set rstb_tx_lane (turn off rst)(bit 1)=1 */
    SGMIIPLUSR_TX_X4_REGS->misc = 0x01E6U;
    /* set enable_tx_lane (bit 0)=1*/
    SGMIIPLUSR_TX_X4_REGS->misc = 0x01E7U;

}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aMode is ETHXCVR_MODE_ACTIVE and first time
        Call SGMIIPLUSR_ConfigAN_Timers ()
        Call SGMIIPLUSR_Config_CreditGen ()
        If speed is 1G or 2.5G
            Call SGMIIPLUSR_Setup1_25G_Speed ()
        Add a delay of 1ms

        If aSpeed is ETHXCVR_SPEED_1000MBPS
            SGMIIPLUSR_Config1G_Speed ()

        If aSpeed is ETHXCVR_SPEED_2500MBPS
            SGMIIPLUSR_Config25G_Speed ()

        If aSpeed is ETHXCVR_SPEED_5000MBPS
            Call SGMIIPLUSR_IntConfig5G_Speed()

        first time if FALSE
    if aMode is ETHXCVR_MODE_DOWN
        return BCM_ERR_NOSUPPORT
    if aMode is ETHXCVR_MODE_ISOLATE
        return BCM_ERR_NOSUPPORT
    if retVal is BCM_ERR_OK
        cache aMode

    return retVal
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/

int32_t SGMIIPLUSR_SetMode(uint8_t aBusIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          ETHXCVR_ModeType aMode)
{
    uint32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        if (ETHXCVR_MODE_ACTIVE == aMode) {
            if (FALSE == SGMIIPLUSR_RWData.isProgrammed) {
                retVal = MCU_SetSerDesClk(MCU_CLK_ID_SGR, aBusIdx);
                if (BCM_ERR_OK == retVal) {
                    SGMIIPLUSR_ConfigAN_Timers();
                    SGMIIPLUSR_Config_CreditGen();
                    if((ETHXCVR_SPEED_1000MBPS == aConfig->speed) ||
                           (ETHXCVR_SPEED_2500MBPS == aConfig->speed)) {
                        SGMIIPLUSR_Setup1_25G_Speed();
                    }
                    /* Add a delay of 1 ms */
                    BCM_CpuNDelay(1000 * 1000);

                    if (ETHXCVR_SPEED_1000MBPS == aConfig->speed) {
                        SGMIIPLUSR_Config1G_Speed(aConfig);
                    }
                    else if (ETHXCVR_SPEED_2500MBPS == aConfig->speed) {
                        SGMIIPLUSR_Config25G_Speed();
                    }
                    else if (ETHXCVR_SPEED_5000MBPS == aConfig->speed) {
                        SGMIIPLUSR_Config5G_Speed();
                    }
                    else {
                        retVal = BCM_ERR_INVAL_PARAMS;
                    }
                    SGMIIPLUSR_RWData.isProgrammed = TRUE;
                }
            }
            /* Disable bit'13 */
            regVal = SGMIIPLUSR_RX_AFE_PMD_REGS->ctrl4;
            regVal &= (~SGMIIPLUSR_RX_AFE_PMD_C4SX1_SIGDET_PD_MASK);
            SGMIIPLUSR_RX_AFE_PMD_REGS->ctrl4 = regVal;
        }
        else if (ETHXCVR_MODE_DOWN == aMode) {
            /* Enable bit'13 */
            regVal = SGMIIPLUSR_RX_AFE_PMD_REGS->ctrl4;
            regVal = regVal | SGMIIPLUSR_RX_AFE_PMD_C4SX1_SIGDET_PD_MASK;
            SGMIIPLUSR_RX_AFE_PMD_REGS->ctrl4 = regVal;
            retVal = BCM_ERR_OK;
        }
        else if (ETHXCVR_MODE_ISOLATE == aMode) {
            retVal = BCM_ERR_NOSUPPORT;
        }
        else {
            retVal = BCM_ERR_INVAL_PARAMS;
        }
    }

    /* Cache the mode */
    if (BCM_ERR_OK == retVal) {
        SGMIIPLUSR_RWData.mode = aMode;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS

    set *aLinkState to ETHXCVR_LINKSTATE_DOWN
    read status register twice (CL22_B0_SGMIIPLUSR_X1_MIISTAT)
    if bit[2] is 1
        *aLinkState to ETHXCVR_LINKSTATE_UP
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetLinkState(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_LinkStateType *const aLinkState)
{
    uint32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;
    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        *aLinkState = ETHXCVR_LINKSTATE_DOWN;
        regVal = SGMIIPLUSR_CL22_REGS->miistat;
        regVal = SGMIIPLUSR_CL22_REGS->miistat;

        if((regVal & SGMIIPLUSR_CL22_MSX1_LINK_STATUS_MASK) ==
                     SGMIIPLUSR_CL22_MSX1_LINK_STATUS_MASK) {
            *aLinkState = ETHXCVR_LINKSTATE_ACTIVE;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_Reset(uint8_t aBusIdx,
                        ETHXCVR_CntxtType *const aPhyCntxt,
                        const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS

    Read rx_afe_pmd_SGMIIPLUSR_X1_ctrl4 bit[13]
    If set
        *aMode is ETHXCVR_MODE_DOWN
    else
        *aMode is ETHXCVR_MODE_UP

    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetMode(uint8_t aBusIdx,
                          ETHXCVR_CntxtType *const aPhyCntxt,
                          const ETHXCVR_PortConfigType *const aConfig,
                          ETHXCVR_ModeType *const aMode)
{
    uint32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;
    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        regVal = SGMIIPLUSR_RX_AFE_PMD_REGS->ctrl4;
        if((regVal & SGMIIPLUSR_RX_AFE_PMD_C4SX1_SIGDET_PD_MASK) ==
                    SGMIIPLUSR_RX_AFE_PMD_C4SX1_SIGDET_PD_MASK) {
            *aMode = ETHXCVR_MODE_DOWN;
        }
        else {
            *aMode = ETHXCVR_MODE_ACTIVE;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetMasterMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType aMasterMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetMasterMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType *const aMasterMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetSpeed(uint8_t aBusIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_SpeedType aSpeed)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    Read DIGITAL_SGMIIPLUSR_X1_MISCDIGCONTROL [bits5:0]
    if data is 2
        set *aSpeed to ETHXCVR_SPEED_1000MBPS
    else if data is 3
        set *aSpeed to ETHXCVR_SPEED_2500MBPS
    else if data is 41
        set *aSpeed to ETHXCVR_SPEED_5000MBPS
    else
        return BCM_ERR_UNKNOWN

    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetSpeed(uint8_t aBusIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_SpeedType *const aSpeed)
{
    uint32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;
    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        regVal = SGMIIPLUSR_DIGITAL_REGS->miscdigcontrol;
        regVal = (regVal & SGMIIPLUSR_DIGITAL_MSX1_SW_ACTUAL_SPEED_MASK);
        if(regVal == 0x2) {
            *aSpeed = ETHXCVR_SPEED_1000MBPS;
        }
        else if (regVal == 0x3) {
            *aSpeed = ETHXCVR_SPEED_2500MBPS;
        }
        else if (regVal == 0x29) {
            *aSpeed = ETHXCVR_SPEED_5000MBPS;
        }
        else {
            retVal = BCM_ERR_UNKNOWN;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aDuplexMode to duplex mode in configuration
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetDuplexMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_DuplexModeType *const aDuplexMode)
{
    uint32_t retVal = BCM_ERR_OK;
    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        *aDuplexMode = aConfig->duplex;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aDuplexMode is not ETHXCVR_DUPLEXMODE_FULL
    return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetDuplexMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aPhyCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_DuplexModeType aDuplexMode)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (aDuplexMode != ETHXCVR_DUPLEXMODE_FULL) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    set *aFlowControl to flow control mode in configuration
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetFlowControl(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType *const aFlowControl)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aFlowControl = aConfig->flowControl;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aFlowControl is not ETHXCVR_FLOWCONTROL_NONE return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetFlowControl(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_FlowControlType aFlowControl)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (aFlowControl != ETHXCVR_FLOWCONTROL_NONE) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetSQIValue(uint8_t aBusIdx,
                              ETHXCVR_CntxtType *const aPhyCntxt,
                              const ETHXCVR_PortConfigType *const aConfig,
                              uint32_t *const aSQIValue)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    Reset the global data
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_Init(uint8_t aBusIdx,
                       ETHXCVR_CntxtType *const aPhyCntxt,
                       const ETHXCVR_PortConfigType *const aConfig)
{
    uint32_t retVal = BCM_ERR_OK;
    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        SGMIIPLUSR_RWData.mode = ETHXCVR_MODE_DOWN;
        SGMIIPLUSR_RWData.isProgrammed = FALSE;
    }
    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    if aMode is ETHXCVR_BOOLEAN_TRUE return BCM_ERR_NOSUPPORT
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetJumboMode(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_BooleanType aMode)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        if (ETHXCVR_BOOLEAN_TRUE == aMode) {
            retVal = BCM_ERR_NOSUPPORT;
        }
    }
    return retVal;
}

/**
    @code{.unparsed}
    Mention that loopback is not supported
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetLoopbackMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType aMode)
{
    /* Current version of driver does not support loopback */
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    Mention that loopback is not supported
     if aBusIdx is invalid
         return BCM_ERR_INVAL_PARAMS
     Else
         aMode to be made as FALSE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetLoopbackMode(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aPhyCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_BooleanType *const aMode)
{
    /* Current version of driver does not support loopback */
    int32_t retVal = BCM_ERR_OK;

    if ((SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) || (NULL == aMode)) {
        retVal = BCM_ERR_INVAL_PARAMS;
    }
    else {
        *aMode = (ETHXCVR_BooleanType)ETHXCVR_BOOLEAN_FALSE;
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    set *aMode to ETHXCVR_BOOLEAN_FALSE
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetJumboMode(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               ETHXCVR_BooleanType *const aMode)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        *aMode = ETHXCVR_BOOLEAN_FALSE;
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetWakeUpMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetWakeUpMode(uint8_t aBusIdx,
                                ETHXCVR_CntxtType *const aCntxt,
                                const ETHXCVR_PortConfigType *const aConfig,
                                ETHXCVR_BooleanType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetWakeUpReason(uint8_t aBusIdx,
                                  ETHXCVR_CntxtType *const aCntxt,
                                  const ETHXCVR_PortConfigType *const aConfig,
                                  ETHXCVR_WakeupReasonType *const aReason)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_SetAutoNegMode(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig,
                                 ETHXCVR_BooleanType aAutonegMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_RestartAutoNeg(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    read status register twice (CL22_B0_SGMIIPLUSR_X1_MIISTAT)
    if autoneg_ability is not set
        set *aStatus to ETHXCVR_AUTONEGSTATUS_NO_ABILITY
    else if autoneg_complete is not set
        set *aStatus to ETHXCVR_AUTONEGSTATUS_INCOMPLETE
    else
        set *aStatus to ETHXCVR_AUTONEGSTATUS_COMPLETE

    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetAutoNegStatus(uint8_t aBusIdx,
                                   ETHXCVR_CntxtType *const aPhyCntxt,
                                   const ETHXCVR_PortConfigType *const aConfig,
                                   ETHXCVR_AutoNegStatusType *const aStatus)
{
    uint32_t retVal = BCM_ERR_OK;
    uint16_t regVal = 0x0U;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        regVal = SGMIIPLUSR_CL22_REGS->miistat;
        regVal = SGMIIPLUSR_CL22_REGS->miistat;

        if(0x0U == (regVal & SGMIIPLUSR_CL22_MSX1_AUTONEG_ABILITY_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_NO_ABILITY;
        }
        else if(0x0U == (regVal & SGMIIPLUSR_CL22_MSX1_AUTONEG_COMPLETE_MASK)) {
            *aStatus = ETHXCVR_AUTONEGSTATUS_INCOMPLETE;
        } else {
            *aStatus = ETHXCVR_AUTONEGSTATUS_COMPLETE;
        }
    }

    return retVal;
}

/**
    @code{.unparsed}
    if aBusIdx is invalid return BCM_ERR_INVAL_PARAMS
    clear aStats
    return BCM_ERR_OK
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_GetStats(uint8_t aBusIdx,
                           ETHXCVR_CntxtType *const aPhyCntxt,
                           const ETHXCVR_PortConfigType *const aConfig,
                           ETHXCVR_StatsType *const aStats)
{
    uint32_t retVal = BCM_ERR_OK;

    if (SGMIIPLUSR_CL22_MAX_HW_ID <= aBusIdx) {
        retVal = BCM_ERR_INVAL_PARAMS;
    } else {
        BCM_MemSet(aStats, 0U, sizeof(ETHXCVR_StatsType));
    }

    return retVal;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_StateHandler(uint8_t aBusIdx,
                               ETHXCVR_CntxtType *const aPhyCntxt,
                               const ETHXCVR_PortConfigType *const aConfig,
                               uint32_t *const aIsModeChanged,
                               ETHXCVR_ModeType *const aMode)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_UpdateHWStatus(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_LinkIRQHandler(uint8_t aBusIdx,
                                 ETHXCVR_CntxtType *const aPhyCntxt,
                                 const ETHXCVR_PortConfigType *const aConfig)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @code{.unparsed}
    return BCM_ERR_NOSUPPORT
    @endcode

    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
int32_t SGMIIPLUSR_LinkChangeIndHandler(uint8_t aBusIdx,
                                       ETHXCVR_CntxtType *const aPhyCntxt,
                                       const ETHXCVR_PortConfigType *const aConfig,
                                       ETHXCVR_LinkStateType *const aLinkState,
                                       uint32_t *const aIsLinkStateChanged)
{
    return BCM_ERR_NOSUPPORT;
}

/**
    @trace #BRCM_SWARCH_SGMIIPLUSR_FUNCTBL_GLOBAL
    @trace #BRCM_SWREQ_SGMIIPLUSR_FUNCTBL
*/
const ETHXCVR_FuncTblType SGMIIPLUSR_FuncTbl = {
    .init = SGMIIPLUSR_Init,
    .deinit = SGMIIPLUSR_Init,
    .reset = SGMIIPLUSR_Reset,
    .setMode = SGMIIPLUSR_SetMode,
    .getMode = SGMIIPLUSR_GetMode,
    .setMasterMode = SGMIIPLUSR_SetMasterMode,
    .getMasterMode = SGMIIPLUSR_GetMasterMode,
    .getSpeed = SGMIIPLUSR_GetSpeed,
    .setSpeed = SGMIIPLUSR_SetSpeed,
    .getDuplexMode = SGMIIPLUSR_GetDuplexMode,
    .setDuplexMode = SGMIIPLUSR_SetDuplexMode,
    .setFlowControl = SGMIIPLUSR_SetFlowControl,
    .getFlowControl = SGMIIPLUSR_GetFlowControl,
    .getLinkState = SGMIIPLUSR_GetLinkState,
    .getSQIValue = SGMIIPLUSR_GetSQIValue,
    .setLoopbackMode = SGMIIPLUSR_SetLoopbackMode,
    .getLoopbackMode = SGMIIPLUSR_GetLoopbackMode,
    .setJumboMode = SGMIIPLUSR_SetJumboMode,
    .getJumboMode = SGMIIPLUSR_GetJumboMode,
    .setWakeUpMode = SGMIIPLUSR_SetWakeUpMode,
    .getWakeUpMode = SGMIIPLUSR_GetWakeUpMode,
    .getWakeUpReason = SGMIIPLUSR_GetWakeUpReason,
    .setAutoNegMode = SGMIIPLUSR_SetAutoNegMode,
    .getAutoNegStatus = SGMIIPLUSR_GetAutoNegStatus,
    .restartAutoNeg = SGMIIPLUSR_RestartAutoNeg,
    .getStats = SGMIIPLUSR_GetStats,
    .stateHandler = SGMIIPLUSR_StateHandler,
    .updateHWStatus = SGMIIPLUSR_UpdateHWStatus,
    .linkChangeIndHandler = SGMIIPLUSR_LinkChangeIndHandler,
    .linkIRQHandler  = SGMIIPLUSR_LinkIRQHandler,
};

/** @} */
