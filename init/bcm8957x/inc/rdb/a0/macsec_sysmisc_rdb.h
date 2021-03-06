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
    @file macsec_sysmisc_rdb.h
    @brief RDB File for MACSEC_SYSMISC

    @version Orion_A0_20201104_SWDEV
*/

#ifndef MACSEC_SYSMISC_RDB_H
#define MACSEC_SYSMISC_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint32_t MACSEC_SYSMISC_MSPU_CTRL_TYPE;
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_31_22_MASK (0xffc00000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_31_22_SHIFT (22UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_SOFT_RESET_MASK (0x200000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_SOFT_RESET_SHIFT (21UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_SOFT_RESET_MASK (0x100000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_SOFT_RESET_SHIFT (20UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_SOFT_RESET_MASK (0x80000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_SOFT_RESET_SHIFT (19UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_SOFT_RESET_MASK (0x40000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_SOFT_RESET_SHIFT (18UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_SOFT_RESET_MASK (0x20000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_SOFT_RESET_SHIFT (17UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_SOFT_RESET_MASK (0x10000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_SOFT_RESET_SHIFT (16UL)
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_15_14_MASK (0xc000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_15_14_SHIFT (14UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_OUTBOUND_SEL_MASK (0x2000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_OUTBOUND_SEL_SHIFT (13UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_OUTBOUND_SEL_MASK (0x1000UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_OUTBOUND_SEL_SHIFT (12UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_OUTBOUND_SEL_MASK (0x800UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_OUTBOUND_SEL_SHIFT (11UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_OUTBOUND_SEL_MASK (0x400UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_OUTBOUND_SEL_SHIFT (10UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_OUTBOUND_SEL_MASK (0x200UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_OUTBOUND_SEL_SHIFT (9UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_OUTBOUND_SEL_MASK (0x100UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_OUTBOUND_SEL_SHIFT (8UL)
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_7_6_MASK (0xc0UL)
#define MACSEC_SYSMISC_MSPU_CTRL_SPARE_7_6_SHIFT (6UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_INBOUND_SEL_MASK (0x20UL)
#define MACSEC_SYSMISC_MSPU_CTRL_5_INBOUND_SEL_SHIFT (5UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_INBOUND_SEL_MASK (0x10UL)
#define MACSEC_SYSMISC_MSPU_CTRL_4_INBOUND_SEL_SHIFT (4UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_INBOUND_SEL_MASK (0x8UL)
#define MACSEC_SYSMISC_MSPU_CTRL_3_INBOUND_SEL_SHIFT (3UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_INBOUND_SEL_MASK (0x4UL)
#define MACSEC_SYSMISC_MSPU_CTRL_2_INBOUND_SEL_SHIFT (2UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_INBOUND_SEL_MASK (0x2UL)
#define MACSEC_SYSMISC_MSPU_CTRL_1_INBOUND_SEL_SHIFT (1UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_INBOUND_SEL_MASK (0x1UL)
#define MACSEC_SYSMISC_MSPU_CTRL_0_INBOUND_SEL_SHIFT (0UL)




typedef uint32_t MACSEC_SYSMISC_TESTMODE_CTRL_TYPE;
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_5_INGRESS_MASK (0x800UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_5_INGRESS_SHIFT (11UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_5_EGRESS_MASK (0x400UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_5_EGRESS_SHIFT (10UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_4_INGRESS_MASK (0x200UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_4_INGRESS_SHIFT (9UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_4_EGRESS_MASK (0x100UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_4_EGRESS_SHIFT (8UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_3_INGRESS_MASK (0x80UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_3_INGRESS_SHIFT (7UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_3_EGRESS_MASK (0x40UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_3_EGRESS_SHIFT (6UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_2_INGRESS_MASK (0x20UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_2_INGRESS_SHIFT (5UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_2_EGRESS_MASK (0x10UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_2_EGRESS_SHIFT (4UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_1_INGRESS_MASK (0x8UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_1_INGRESS_SHIFT (3UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_1_EGRESS_MASK (0x4UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_1_EGRESS_SHIFT (2UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_0_INGRESS_MASK (0x2UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_0_INGRESS_SHIFT (1UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_0_EGRESS_MASK (0x1UL)
#define MACSEC_SYSMISC_TESTMODE_CTRL_MSPU_0_EGRESS_SHIFT (0UL)




typedef uint32_t MACSEC_SYSMISC_PROBESEL_CTRL_TYPE;
#define MACSEC_SYSMISC_PROBESEL_CTRL_MSPU_PROBE_SEL_MASK (0x7UL)
#define MACSEC_SYSMISC_PROBESEL_CTRL_MSPU_PROBE_SEL_SHIFT (0UL)




typedef uint32_t MACSEC_SYSMISC_INTERRUPT_STAT_TYPE;
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_5_INT_MASK (0x20UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_5_INT_SHIFT (5UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_4_INT_MASK (0x10UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_4_INT_SHIFT (4UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_3_INT_MASK (0x8UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_3_INT_SHIFT (3UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_2_INT_MASK (0x4UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_2_INT_SHIFT (2UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_1_INT_MASK (0x2UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_1_INT_SHIFT (1UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_0_INT_MASK (0x1UL)
#define MACSEC_SYSMISC_INTERRUPT_STAT_MSPU_0_INT_SHIFT (0UL)




typedef uint32_t MACSEC_SYSMISC_INTERRUPT_MASK_TYPE;
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_5_INTMASK_MASK (0x20UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_5_INTMASK_SHIFT (5UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_4_INTMASK_MASK (0x10UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_4_INTMASK_SHIFT (4UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_3_INTMASK_MASK (0x8UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_3_INTMASK_SHIFT (3UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_2_INTMASK_MASK (0x4UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_2_INTMASK_SHIFT (2UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_1_INTMASK_MASK (0x2UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_1_INTMASK_SHIFT (1UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_0_INTMASK_MASK (0x1UL)
#define MACSEC_SYSMISC_INTERRUPT_MASK_MSPU_0_INTMASK_SHIFT (0UL)




typedef uint32_t MACSEC_SYSMISC_PKTI_STAT_TYPE;
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_5_PKTINFLIGHT_EGRESS_MASK (0x2000UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_5_PKTINFLIGHT_EGRESS_SHIFT (13UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_4_PKTINFLIGHT_EGRESS_MASK (0x1000UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_4_PKTINFLIGHT_EGRESS_SHIFT (12UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_3_PKTINFLIGHT_EGRESS_MASK (0x800UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_3_PKTINFLIGHT_EGRESS_SHIFT (11UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_2_PKTINFLIGHT_EGRESS_MASK (0x400UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_2_PKTINFLIGHT_EGRESS_SHIFT (10UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_1_PKTINFLIGHT_EGRESS_MASK (0x200UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_1_PKTINFLIGHT_EGRESS_SHIFT (9UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_0_PKTINFLIGHT_EGRESS_MASK (0x100UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_0_PKTINFLIGHT_EGRESS_SHIFT (8UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_5_PKTINFLIGHT_INGRESS_MASK (0x20UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_5_PKTINFLIGHT_INGRESS_SHIFT (5UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_4_PKTINFLIGHT_INGRESS_MASK (0x10UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_4_PKTINFLIGHT_INGRESS_SHIFT (4UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_3_PKTINFLIGHT_INGRESS_MASK (0x8UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_3_PKTINFLIGHT_INGRESS_SHIFT (3UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_2_PKTINFLIGHT_INGRESS_MASK (0x4UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_2_PKTINFLIGHT_INGRESS_SHIFT (2UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_1_PKTINFLIGHT_INGRESS_MASK (0x2UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_1_PKTINFLIGHT_INGRESS_SHIFT (1UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_0_PKTINFLIGHT_INGRESS_MASK (0x1UL)
#define MACSEC_SYSMISC_PKTI_STAT_MSPU_0_PKTINFLIGHT_INGRESS_SHIFT (0UL)




typedef uint8_t MACSEC_SYSMISC_RESERVED_TYPE;




typedef uint32_t MACSEC_SYSMISC_SPARE_REG_TYPE;
#define MACSEC_SYSMISC_SPARE_REG_REG_MASK (0xffffffffUL)
#define MACSEC_SYSMISC_SPARE_REG_REG_SHIFT (0UL)




typedef volatile struct COMP_PACKED sMACSEC_SYSMISC_RDBType {
    MACSEC_SYSMISC_MSPU_CTRL_TYPE mspu_ctrl; /* OFFSET: 0x0 */
    MACSEC_SYSMISC_TESTMODE_CTRL_TYPE testmode_ctrl; /* OFFSET: 0x4 */
    MACSEC_SYSMISC_PROBESEL_CTRL_TYPE probesel_ctrl; /* OFFSET: 0x8 */
    MACSEC_SYSMISC_INTERRUPT_STAT_TYPE interrupt_stat; /* OFFSET: 0xc */
    MACSEC_SYSMISC_INTERRUPT_MASK_TYPE interrupt_mask; /* OFFSET: 0x10 */
    MACSEC_SYSMISC_PKTI_STAT_TYPE pktinflight_stat; /* OFFSET: 0x14 */
    MACSEC_SYSMISC_RESERVED_TYPE rsvd0[228]; /* OFFSET: 0x18 */
    MACSEC_SYSMISC_SPARE_REG_TYPE spare_reg; /* OFFSET: 0xfc */
} MACSEC_SYSMISC_RDBType;


#define MACSEC_SYSMISC_BASE             (0x4DFF0000UL)



#define MACSEC_SYSMISC_MAX_HW_ID        (1UL)

#endif /* MACSEC_SYSMISC_RDB_H */
