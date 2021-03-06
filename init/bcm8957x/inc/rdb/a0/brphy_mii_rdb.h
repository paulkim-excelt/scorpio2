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
    @file brphy_mii_rdb.h
    @brief RDB File for BRPHY_MII

    @version Orion_A0_20201104_SWDEV
*/

#ifndef BRPHY_MII_RDB_H
#define BRPHY_MII_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint16_t BRPHY_MII_MII_CTRL_TYPE;
#define BRPHY_MII_MII_CTRL_RESET_MASK (0x8000U)
#define BRPHY_MII_MII_CTRL_RESET_SHIFT (15U)
#define BRPHY_MII_MII_CTRL_POWER_DOWN_MASK (0x800U)
#define BRPHY_MII_MII_CTRL_POWER_DOWN_SHIFT (11U)
#define BRPHY_MII_MII_CTRL_ISOLATE_MASK (0x400U)
#define BRPHY_MII_MII_CTRL_ISOLATE_SHIFT (10U)




typedef uint16_t BRPHY_MII_MII_STAT_TYPE;
#define BRPHY_MII_MII_STAT_CAPABILITY_MASK (0x7e00U)
#define BRPHY_MII_MII_STAT_CAPABILITY_SHIFT (9U)
#define BRPHY_MII_MII_STAT_EXTENDED_STAT_MASK (0x1c0U)
#define BRPHY_MII_MII_STAT_EXTENDED_STAT_SHIFT (6U)
#define BRPHY_MII_MII_STAT_LDS_COMPLETE_MASK (0x20U)
#define BRPHY_MII_MII_STAT_LDS_COMPLETE_SHIFT (5U)
#define BRPHY_MII_MII_STAT_LNK_STAT_MASK (0x4U)
#define BRPHY_MII_MII_STAT_LNK_STAT_SHIFT (2U)
#define BRPHY_MII_MII_STAT_JABBER_DETECT_MASK (0x2U)
#define BRPHY_MII_MII_STAT_JABBER_DETECT_SHIFT (1U)
#define BRPHY_MII_MII_STAT_EXTENDED_CAPABILITY_MASK (0x1U)
#define BRPHY_MII_MII_STAT_EXTENDED_CAPABILITY_SHIFT (0U)




typedef uint16_t BRPHY_MII_PHY_ID_MSB_TYPE;
#define BRPHY_MII_PHY_ID_MSB_OUI_MSB_MASK (0xffffU)
#define BRPHY_MII_PHY_ID_MSB_OUI_MSB_SHIFT (0U)




typedef uint16_t BRPHY_MII_PHY_ID_LSB_TYPE;
#define BRPHY_MII_PHY_ID_LSB_OUI_LSB_MASK (0xfc00U)
#define BRPHY_MII_PHY_ID_LSB_OUI_LSB_SHIFT (10U)
#define BRPHY_MII_PHY_ID_LSB_MODEL_MASK (0x3f0U)
#define BRPHY_MII_PHY_ID_LSB_MODEL_SHIFT (4U)
#define BRPHY_MII_PHY_ID_LSB_REVISION_MASK (0xfU)
#define BRPHY_MII_PHY_ID_LSB_REVISION_SHIFT (0U)




typedef uint8_t BRPHY_MII_RESERVED_TYPE;




typedef volatile struct COMP_PACKED sBRPHY_MII_RDBType {
    BRPHY_MII_MII_CTRL_TYPE mii_ctrl; /* OFFSET: 0x0 */
    BRPHY_MII_MII_STAT_TYPE mii_stat; /* OFFSET: 0x2 */
    BRPHY_MII_PHY_ID_MSB_TYPE phy_id_msb; /* OFFSET: 0x4 */
    BRPHY_MII_PHY_ID_LSB_TYPE phy_id_lsb; /* OFFSET: 0x6 */
    BRPHY_MII_RESERVED_TYPE rsvd0[48]; /* OFFSET: 0x8 */
} BRPHY_MII_RDBType;


#define BRPHY0_BR_CL22_IEEE_BASE        (0x4A4FFFC0UL)

#define BRPHY1_BR_CL22_IEEE_BASE        (0x494FFFC0UL)

#define BRPHY2_BR_CL22_IEEE_BASE        (0x498FFFC0UL)

#define BRPHY3_BR_CL22_IEEE_BASE        (0x49CFFFC0UL)

#define BRPHY4_BR_CL22_IEEE_BASE        (0x4A0FFFC0UL)



#define BRPHY_MII_MAX_HW_ID             (5UL)


#define BRPHY0_CL22_IEEE_BASE           (BRPHY0_BR_CL22_IEEE_BASE)


#define BRPHY1_CL22_IEEE_BASE           (BRPHY1_BR_CL22_IEEE_BASE)


#define BRPHY2_CL22_IEEE_BASE           (BRPHY2_BR_CL22_IEEE_BASE)


#define BRPHY3_CL22_IEEE_BASE           (BRPHY3_BR_CL22_IEEE_BASE)


#define BRPHY4_CL22_IEEE_BASE           (BRPHY4_BR_CL22_IEEE_BASE)


#define BRPHY_MII_MII_CTRL_SPEED_SELECTION_MASK  (0x1C0U)

#endif /* BRPHY_MII_RDB_H */
