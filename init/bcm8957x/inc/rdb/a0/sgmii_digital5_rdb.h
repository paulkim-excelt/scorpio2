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
    @file sgmii_digital5_rdb.h
    @brief RDB File for SGMII_DIGITAL5

    @version Orion_A0_20201104_SWDEV
*/

#ifndef SGMII_DIGITAL5_RDB_H
#define SGMII_DIGITAL5_RDB_H

#include <stdint.h>

#include <compiler.h>


typedef uint8_t SGMII_DIGITAL5_RESERVED_TYPE;




typedef uint16_t SGMII_DIGITAL5_MISC8_SGMIIPLUS2_X2_TYPE;
#define SGMII_DIGITAL5_MISC8_SGMIIPLUS2_X2_FORCE_OSCDR_MODE_MASK (0xfU)
#define SGMII_DIGITAL5_MISC8_SGMIIPLUS2_X2_FORCE_OSCDR_MODE_SHIFT (0U)




typedef uint16_t SGMII_DIGITAL5_LSSS2X2_TYPE;
#define SGMII_DIGITAL5_LSSS2X2_LINK_SPEED_STATUS_MASK (0x7U)
#define SGMII_DIGITAL5_LSSS2X2_LINK_SPEED_STATUS_SHIFT (0U)




typedef uint16_t SGMII_DIGITAL5_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE;
#define SGMII_DIGITAL5_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_MASK (0x7ff0U)
#define SGMII_DIGITAL5_BLOCKADDRESS_SGMIIPLUS2_X2_BLOCKADDRESS_SHIFT (4U)




typedef volatile struct COMP_PACKED sSGMII_DIGITAL5_RDBType {
    SGMII_DIGITAL5_RESERVED_TYPE rsvd0[20]; /* OFFSET: 0x0 */
    SGMII_DIGITAL5_MISC8_SGMIIPLUS2_X2_TYPE misc8; /* OFFSET: 0x14 */
    SGMII_DIGITAL5_LSSS2X2_TYPE link_speed; /* OFFSET: 0x16 */
    SGMII_DIGITAL5_RESERVED_TYPE rsvd1[6]; /* OFFSET: 0x18 */
    SGMII_DIGITAL5_BLOCKADDRESS_SGMIIPLUS2_X2_TYPE blockaddress; /* OFFSET: 0x1e */
} SGMII_DIGITAL5_RDBType;


#define DIGITAL5_LANE0_BASE             (0x4ACD0680UL)

#define DIGITAL5_LANE1_BASE             (0x4ACF0680UL)



#define SGMII_DIGITAL5_MAX_HW_ID        (2UL)


#define SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX5  (0x3U)


#define SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX2  (0x1U)


#define SGMII_DIGITAL5_FORCE_OSCDR_MODE_OSX0  (0x0U)


#define SGMII_DIGITAL5_BLOCK_ADDRESS_VALUE  (0x8340U)


#define SGMII0_DIGITAL5_BASE            (DIGITAL5_LANE0_BASE)


#define SGMII1_DIGITAL5_BASE            (DIGITAL5_LANE1_BASE)


#define SGMII2_DIGITAL5_BASE            (DIGITAL5_SGMIIPCIE_X1_BASE)


#define SGMII3_DIGITAL5_BASE            (UNDEFINED)


#define SGMII4_DIGITAL5_BASE            (UNDEFINED)

#endif /* SGMII_DIGITAL5_RDB_H */
