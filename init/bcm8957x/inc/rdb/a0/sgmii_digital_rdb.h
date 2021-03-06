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
    @file sgmii_digital_rdb.h
    @brief RDB File for SGMII_DIGITAL

    @version Orion_A0_20201104_SWDEV
*/

#ifndef SGMII_DIGITAL_RDB_H
#define SGMII_DIGITAL_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint16_t SGMII_DIGITAL_C10001S2X2_TYPE;
#define SGMII_DIGITAL_C10001S2X2_REMOTE_LOOPBACK_MASK (0x400U)
#define SGMII_DIGITAL_C10001S2X2_REMOTE_LOOPBACK_SHIFT (10U)
#define SGMII_DIGITAL_C10001S2X2_COMMA_DET_EN_MASK (0x100U)
#define SGMII_DIGITAL_C10001S2X2_COMMA_DET_EN_SHIFT (8U)
#define SGMII_DIGITAL_C10001S2X2_DISABLE_PLL_PWRDWN_MASK (0x40U)
#define SGMII_DIGITAL_C10001S2X2_DISABLE_PLL_PWRDWN_SHIFT (6U)
#define SGMII_DIGITAL_C10001S2X2_SGMII_MASTER_MODE_MASK (0x20U)
#define SGMII_DIGITAL_C10001S2X2_SGMII_MASTER_MODE_SHIFT (5U)
#define SGMII_DIGITAL_C10001S2X2_FIBER_MODE_1000X_MASK (0x1U)
#define SGMII_DIGITAL_C10001S2X2_FIBER_MODE_1000X_SHIFT (0U)




typedef uint16_t SGMII_DIGITAL_C10002S2X2_TYPE;
#define SGMII_DIGITAL_C10002S2X2_AUTONEG_FAST_TIMERS_MASK (0x40U)
#define SGMII_DIGITAL_C10002S2X2_AUTONEG_FAST_TIMERS_SHIFT (6U)
#define SGMII_DIGITAL_C10002S2X2_FILTER_FORCE_LINK_MASK (0x4U)
#define SGMII_DIGITAL_C10002S2X2_FILTER_FORCE_LINK_SHIFT (2U)
#define SGMII_DIGITAL_C10002S2X2_DISABLE_FALSE_LINK_MASK (0x2U)
#define SGMII_DIGITAL_C10002S2X2_DISABLE_FALSE_LINK_SHIFT (1U)
#define SGMII_DIGITAL_C10002S2X2_ENABLE_PARALLEL_DETECTION_MASK (0x1U)
#define SGMII_DIGITAL_C10002S2X2_ENABLE_PARALLEL_DETECTION_SHIFT (0U)




typedef uint8_t SGMII_DIGITAL_RESERVED_TYPE;




typedef uint16_t SGMII_DIGITAL_S10001S2X2_TYPE;
#define SGMII_DIGITAL_S10001S2X2_LINK_STATUS_CHANGE_MASK (0x80U)
#define SGMII_DIGITAL_S10001S2X2_LINK_STATUS_CHANGE_SHIFT (7U)
#define SGMII_DIGITAL_S10001S2X2_PAUSE_RESOLUTION_RXSIDE_MASK (0x40U)
#define SGMII_DIGITAL_S10001S2X2_PAUSE_RESOLUTION_RXSIDE_SHIFT (6U)
#define SGMII_DIGITAL_S10001S2X2_PAUSE_RESOLUTION_TXSIDE_MASK (0x20U)
#define SGMII_DIGITAL_S10001S2X2_PAUSE_RESOLUTION_TXSIDE_SHIFT (5U)
#define SGMII_DIGITAL_S10001S2X2_SPEED_STATUS_MASK (0x18U)
#define SGMII_DIGITAL_S10001S2X2_SPEED_STATUS_SHIFT (3U)
#define SGMII_DIGITAL_S10001S2X2_DUPLEX_STATUS_MASK (0x4U)
#define SGMII_DIGITAL_S10001S2X2_DUPLEX_STATUS_SHIFT (2U)
#define SGMII_DIGITAL_S10001S2X2_LINK_STATUS_MASK (0x2U)
#define SGMII_DIGITAL_S10001S2X2_LINK_STATUS_SHIFT (1U)
#define SGMII_DIGITAL_S10001S2X2_SGMII_MODE_MASK (0x1U)
#define SGMII_DIGITAL_S10001S2X2_SGMII_MODE_SHIFT (0U)




typedef uint16_t SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_TYPE;
#define SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_REFCLK_SEL_MASK (0xe000U)
#define SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_REFCLK_SEL_SHIFT (13U)
#define SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_FORCE_SPEED_MASK (0x1fU)
#define SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_FORCE_SPEED_SHIFT (0U)




typedef uint16_t SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_TYPE;
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_RXCK_MII_GEN_SEL_VAL_MASK (0x2000U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_RXCK_MII_GEN_SEL_VAL_SHIFT (13U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_CLKSIGDET_BYPASS_MASK (0x400U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_CLKSIGDET_BYPASS_SHIFT (10U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_CLK41_BYPASS_MASK (0x200U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_CLK41_BYPASS_SHIFT (9U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_MIIGMIIDLY_EN_MASK (0x100U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_MIIGMIIDLY_EN_SHIFT (8U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_MIIGMIIMUX_EN_MASK (0x80U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_MIIGMIIMUX_EN_SHIFT (7U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_FIFO_ERR_CYA_MASK (0x10U)
#define SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_FIFO_ERR_CYA_SHIFT (4U)




typedef uint16_t SGMII_DIGITAL_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE;
#define SGMII_DIGITAL_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_MASK (0x7ff0U)
#define SGMII_DIGITAL_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_SHIFT (4U)




typedef volatile struct COMP_PACKED sSGMII_DIGITAL_RDBType {
    SGMII_DIGITAL_C10001S2X2_TYPE control1000x1; /* OFFSET: 0x0 */
    SGMII_DIGITAL_C10002S2X2_TYPE control1000x2; /* OFFSET: 0x2 */
    SGMII_DIGITAL_RESERVED_TYPE rsvd0[4]; /* OFFSET: 0x4 */
    SGMII_DIGITAL_S10001S2X2_TYPE status1000x1; /* OFFSET: 0x8 */
    SGMII_DIGITAL_RESERVED_TYPE rsvd1[6]; /* OFFSET: 0xa */
    SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_TYPE misc1; /* OFFSET: 0x10 */
    SGMII_DIGITAL_MISC2_SGMIIPLUS2_X2_TYPE misc2; /* OFFSET: 0x12 */
    SGMII_DIGITAL_RESERVED_TYPE rsvd2[10]; /* OFFSET: 0x14 */
    SGMII_DIGITAL_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE blockaddress; /* OFFSET: 0x1e */
} SGMII_DIGITAL_RDBType;


#define DIGITAL_LANE0_BASE              (0x4ACD0600UL)

#define DIGITAL_LANE1_BASE              (0x4ACF0600UL)



#define SGMII_DIGITAL_MAX_HW_ID         (2UL)


#define SGMII_DIGITAL_MISC1_FORCE_SPEED_5000M  (0x11U)


#define SGMII_DIGITAL_MISC1_FORCE_SPEED_2500M  (0x10U)


#define SGMII_DIGITAL_BLOCK_ADDRESS_VALUE  (0x8300U)


#define SGMII0_DIGITAL_BASE             (DIGITAL_LANE0_BASE)


#define SGMII1_DIGITAL_BASE             (DIGITAL_LANE1_BASE)


#define SGMII2_DIGITAL_BASE             (DIGITAL_SGMIIPCIE_X1_BASE)


#define SGMII3_DIGITAL_BASE             (UNDEFINED)


#define SGMII4_DIGITAL_BASE             (UNDEFINED)


#define SGMII_DIGITAL_CONTROL1000X1_COMMA_DET_EN_MASK  (SGMII_DIGITAL_C10001S2X2_COMMA_DET_EN_MASK)


#define SGMII_DIGITAL_CONTROL1000X1_CRC_CHECKER_DISABLE_MASK  (0x0U)


#define SGMII_DIGITAL_MISC1_FORCE_SPEED_MASK  (SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_FORCE_SPEED_MASK)


#define SGMII_DIGITAL_MISC1_FORCE_SPEED_SHIFT  (SGMII_DIGITAL_MISC1_SGMIIPLUS2_X2_FORCE_SPEED_SHIFT)

#endif /* SGMII_DIGITAL_RDB_H */
