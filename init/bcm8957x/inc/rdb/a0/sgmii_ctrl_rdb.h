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
    @file sgmii_ctrl_rdb.h
    @brief RDB File for SGMII_CTRL

    @version Orion_A0_20201104_SWDEV
*/

#ifndef SGMII_CTRL_RDB_H
#define SGMII_CTRL_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t SGMII_CTRL_RESERVED_TYPE;




typedef uint16_t SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_TYPE;
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_GLOOP1G_MASK (0x100U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_GLOOP1G_SHIFT (8U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PMD_TXDISABLE_MASK (0x10U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PMD_TXDISABLE_SHIFT (4U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_EDEN_MASK (0x8U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_EDEN_SHIFT (3U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_CDET_MASK (0x4U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_CDET_SHIFT (2U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PCS_EN_RX_MASK (0x2U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PCS_EN_RX_SHIFT (1U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PCS_EN_TX_MASK (0x1U)
#define SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PCS_EN_TX_SHIFT (0U)




typedef uint16_t SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_TYPE;
#define SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_RX1G_MODE_MASK (0xcU)
#define SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_RX1G_MODE_SHIFT (2U)
#define SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_TX1G_MODE_MASK (0x3U)
#define SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_TX1G_MODE_SHIFT (0U)




typedef uint16_t SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_TYPE;
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_RESET_RX_MASK (0x200U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_RESET_RX_SHIFT (9U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_PWRDN_RX_MASK (0x100U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_PWRDN_RX_SHIFT (8U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_RESET_TX_MASK (0x2U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_RESET_TX_SHIFT (1U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_PWRDN_TX_MASK (0x1U)
#define SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_PWRDN_TX_SHIFT (0U)




typedef uint16_t SGMII_CTRL_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE;
#define SGMII_CTRL_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_MASK (0x7ff0U)
#define SGMII_CTRL_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_SHIFT (4U)




typedef volatile struct COMP_PACKED sSGMII_CTRL_RDBType {
    SGMII_CTRL_RESERVED_TYPE rsvd0[2]; /* OFFSET: 0x0 */
    SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_TYPE lanectrl; /* OFFSET: 0x2 */
    SGMII_CTRL_LANECTRLB_SGMIIPLUS2_X2_TYPE mode1g; /* OFFSET: 0x4 */
    SGMII_CTRL_LANECTRLC_SGMIIPLUS2_X2_TYPE pwrrst; /* OFFSET: 0x6 */
    SGMII_CTRL_RESERVED_TYPE rsvd1[22]; /* OFFSET: 0x8 */
    SGMII_CTRL_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE blockaddress; /* OFFSET: 0x1e */
} SGMII_CTRL_RDBType;


#define CTRL_LANE0_BASE                 (0x4ACD0C00UL)

#define CTRL_LANE1_BASE                 (0x4ACF0C00UL)



#define SGMII_CTRL_MAX_HW_ID            (2UL)


#define SGMII0_CTRL_BASE                (CTRL_LANE0_BASE)


#define SGMII1_CTRL_BASE                (CTRL_LANE1_BASE)


#define SGMII2_CTRL_BASE                (CTRL_SGMIIPCIE_X1_BASE)


#define SGMII3_CTRL_BASE                (UNDEFINED)


#define SGMII4_CTRL_BASE                (UNDEFINED)


#define SGMII_CTRL_LANECTRLA_PMD_TXDISABLE_MASK  (SGMII_CTRL_LANECTRLA_SGMIIPLUS2_X2_PMD_TXDISABLE_MASK)

#endif /* SGMII_CTRL_RDB_H */
