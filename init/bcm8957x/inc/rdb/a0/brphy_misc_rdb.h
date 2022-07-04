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
    @file brphy_misc_rdb.h
    @brief RDB File for BRPHY_MISC

    @version Orion_A0_20201104_SWDEV
*/

#ifndef BRPHY_MISC_RDB_H
#define BRPHY_MISC_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t BRPHY_MISC_RESERVED_TYPE;




typedef uint16_t BRPHY_MISC_TOP_GLOBAL_RESET_REG_TYPE;
#define BRPHY_MISC_TOP_GLOBAL_RESET_REG_MII_SOFT_RST_MASK (0x8000U)
#define BRPHY_MISC_TOP_GLOBAL_RESET_REG_MII_SOFT_RST_SHIFT (15U)




typedef uint16_t BRPHY_MISC_TC10_CLR_TEST_TYPE;
#define BRPHY_MISC_TC10_CLR_TEST_PSD_CNT_MASK (0xe000U)
#define BRPHY_MISC_TC10_CLR_TEST_PSD_CNT_SHIFT (13U)
#define BRPHY_MISC_TC10_CLR_TEST_START_SIGNAL_MASK (0x1000U)
#define BRPHY_MISC_TC10_CLR_TEST_START_SIGNAL_SHIFT (12U)
#define BRPHY_MISC_TC10_CLR_TEST_SLEEP_MODE_MASK (0xf00U)
#define BRPHY_MISC_TC10_CLR_TEST_SLEEP_MODE_SHIFT (8U)
#define BRPHY_MISC_TC10_CLR_TEST_WAKE_VIA_MDI_MASK (0xf0U)
#define BRPHY_MISC_TC10_CLR_TEST_WAKE_VIA_MDI_SHIFT (4U)
#define BRPHY_MISC_TC10_CLR_TEST_WVM_STATE_MASK (0xfU)
#define BRPHY_MISC_TC10_CLR_TEST_WVM_STATE_SHIFT (0U)




typedef uint16_t BRPHY_MISC_AN_TX_AMP_CNTRL_TYPE;
#define BRPHY_MISC_AN_TX_AMP_CNTRL_100BT1_ABIST_OUT_MASK (0xf000U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_100BT1_ABIST_OUT_SHIFT (12U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_100BT1_BIAS_TRIM_MASK (0xf00U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_100BT1_BIAS_TRIM_SHIFT (8U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_BR_ABIST_OUT_MASK (0xf0U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_BR_ABIST_OUT_SHIFT (4U)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_BR_BIAS_TRIM_MASK (0xfU)
#define BRPHY_MISC_AN_TX_AMP_CNTRL_BR_BIAS_TRIM_SHIFT (0U)




typedef volatile struct COMP_PACKED sBRPHY_MISC_RDBType {
    BRPHY_MISC_RESERVED_TYPE rsvd0[10]; /* OFFSET: 0x0 */
    BRPHY_MISC_TOP_GLOBAL_RESET_REG_TYPE top_global_reset_reg; /* OFFSET: 0xa */
    BRPHY_MISC_RESERVED_TYPE rsvd1[2]; /* OFFSET: 0xc */
    BRPHY_MISC_TC10_CLR_TEST_TYPE tc10_afe_clr_test_reg; /* OFFSET: 0xe */
    BRPHY_MISC_AN_TX_AMP_CNTRL_TYPE an_tx_amp_cntrl; /* OFFSET: 0x10 */
} BRPHY_MISC_RDBType;


#define BRPHY_TOP_MISC_0_BASE           (0x4A4F3000UL)



#define BRPHY_MISC_MAX_HW_ID            (1UL)

#endif /* BRPHY_MISC_RDB_H */
